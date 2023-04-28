interface ICollision {
  void Show();
  boolean CollisionCheck(CollisionLine line);
  boolean CollisionCheck(CollisionCircle circle);
  boolean CollisionCheck(CollisionRect rect);
  boolean CollisionCheck(CollisionTiltedRect rect);
}

class CollisionLine implements ICollision {
  PVector initial;
  PVector vector;
  //キャプチャーする
  CollisionLine(PVector i, PVector v) {
    initial = i;
    vector = v;
  }
  CollisionLine(float ix, float iy, float vx, float vy) {
    initial = new PVector(ix, iy);
    vector = new PVector(vx, vy);
  }
  PVector terminal() {
    return initial.copy().add(vector);
  }
  boolean IsLeftSide(PVector point) {
    PVector temp = point.copy().sub(initial);
    return vector.x * temp.y - vector.y * temp.x < 0;
  }
  String toString() {
    return "[initial:" + initial + ",terminal:" + terminal()+ ",vector:" + vector+"]";
  }
  void Show() {
    push();
    line(initial.x, initial.y, terminal().x, terminal().y);
    pop();
  }
  boolean CollisionCheck(CollisionLine line) {
    if (0 < vector.cross(line.initial.copy().sub(initial)).mag() * vector.cross(line.terminal().copy().sub(initial)).mag())
      return false;
    if (0 < line.vector.cross(initial.copy().sub(line.initial)).mag() * line.vector.cross(terminal().copy().sub(line.initial)).mag())
      return false;
    return true;
  }
  boolean CollisionCheck(CollisionCircle circle) {
    PVector A = circle.center.copy().sub(initial);
    float d = vector.cross(A).mag()/vector.mag();
    if (d > circle.radius) return false;
    PVector B = circle.center.copy().sub(terminal());
    if (vector.dot(A)*vector.dot(B) <= 0) return true;
    if (A.mag()<=circle.radius || B.mag()<=circle.radius) return true;
    return false;
  }
  boolean CollisionCheck(CollisionRect rect) {
    return rect.CollisionCheck(this);
  }
  boolean CollisionCheck(CollisionTiltedRect rect) {
    return rect.CollisionCheck(this);
  }
}

class CollisionCircle implements ICollision {
  PVector center;
  float radius;
  //キャプチャーする
  CollisionCircle(PVector p, float r) {
    center = p;
    radius = r;
  }
  CollisionCircle(float x1, float y1, float r) {
    center = new PVector(x1, y1);
    radius = r;
  }
  void Show() {
    push();
    circle(center.x, center.y, radius*2);
    pop();
  }
  boolean CollisionCheck(CollisionLine line) {
    return line.CollisionCheck(this);
  }
  boolean CollisionCheck(CollisionCircle circle) {
    return center.copy().sub(circle.center).mag() <= radius + circle.radius;
  }
  boolean CollisionCheck(CollisionRect rect) {
    return rect.CollisionCheck(this);
  }
  boolean CollisionCheck(CollisionTiltedRect rect) {
    return rect.CollisionCheck(this);
  }
}

class BaseCollisionPolygon {
  //MUST_OVVERRIDE
  ArrayList<PVector> GetVertices() {
    if(true)
    throw new RuntimeException("WARN:undefined method called");
    return new ArrayList<PVector>();
  }
  ArrayList<CollisionLine> GetSides() {
    ArrayList<CollisionLine> sides = new ArrayList<CollisionLine>();
    ArrayList<PVector>vertices = GetVertices();
    for (int i = 0; i<vertices.size(); i++) {
      sides.add(new CollisionLine(vertices.get(i), vertices.get((i+1)%4).copy().sub(vertices.get(i))));
    }
    return sides;
  }
  boolean IsInside(PVector point) {
    for (CollisionLine side : GetSides()) {
      if (side.IsLeftSide(point)) return false;
    }
    return true;
  }

  boolean CollisionCheck(CollisionLine line) {
    if (IsInside(line.initial) || IsInside(line.terminal())) return true;
    for (CollisionLine side : GetSides()) {
      if (side.CollisionCheck(line)) return true;
    }
    return false;
  }
  boolean CollisionCheck(CollisionCircle circle) {
    if (IsInside(circle.center)) return true;
    for (CollisionLine side : GetSides()) {
      if (side.CollisionCheck(circle)) return true;
    }
    return false;
  }
  boolean CollisionCheck(CollisionRect rect) {
    for (PVector vertex : GetVertices()) {
      if (rect.IsInside(vertex)) return true;
    }
    return false;
  }
  boolean CollisionCheck(CollisionTiltedRect rect) {
    for (PVector vertex : rect.GetVertices()) {
      if (IsInside(vertex)) return true;
    }
    return false;
  }
}

class CollisionRect extends BaseCollisionPolygon implements ICollision {
  PVector position;
  PVector size;
  //キャプチャーする
  CollisionRect(PVector position, PVector size) {
    this.position = position;
    this.size = size;
  }
  CollisionRect(float px, float py, float sx, float sy) {
    position = new PVector(px, py);
    size = new PVector(sx, sy);
  }
  void Show() {
    push();
    rect(position.x, position.y, size.x, size.y);
    pop();
  }
  ArrayList<PVector> GetVertices() {
    ArrayList<PVector> re = new ArrayList<PVector>();
    re.add(position);
    re.add(position.copy().add(new PVector(size.x, 0)));
    re.add(position.copy().add(size.copy()));
    re.add(position.copy().add(new PVector(0, size.y)));
    return re;
  }
  boolean IsInside(PVector point) {
    return position.x <= point.x && point.x <= position.x + size.x &&
      position.y <= point.y && point.y <= position.y + size.y;
  }
  boolean CollisionCheck(CollisionRect rect) {
    return position.x-rect.size.x<=rect.position.x &&rect.position.x <= position.x + size.x &&
      position.y-rect.size.y<=rect.position.y &&rect.position.y <= position.y + size.y ;
  }
}

class CollisionTiltedRect extends BaseCollisionPolygon implements ICollision {
  float tilt;
  PVector position;
  PVector size;
  CollisionTiltedRect(PVector position, PVector size, float tilt) {
    this.position = position;
    this.size = size;
    this.tilt = tilt;
  }
  void Show() {
    push();
    translate(position.x, position.y);
    rotate(tilt);
    rect(0, 0, size.x, size.y);
    pop();
  }
  ArrayList<PVector> GetVertices() {
    ArrayList<PVector> re =new ArrayList<PVector>();
    re.add(position);
    re.add(position.copy().add(new PVector(size.x, 0).rotate(tilt)));
    re.add(position.copy().add(size.copy().rotate(tilt)));
    re.add(position.copy().add(new PVector(0, size.y).rotate(tilt)));
    return re;
  }
}
class CollisionPolygon extends BaseCollisionPolygon implements ICollision {
  ArrayList<PVector> vertices;
  //右回りに頂点が並んでいる凸多角形であること
  CollisionPolygon(ArrayList<PVector> vertices) {
    this.vertices = vertices;
  }
  ArrayList<PVector> GetVertices() {
    return vertices;
  }
  void Show() {
    push();
    beginShape();
    for(PVector v:GetVertices()){
      vertex(v.x,v.y);
    }
    endShape();
    pop();
  }
}
