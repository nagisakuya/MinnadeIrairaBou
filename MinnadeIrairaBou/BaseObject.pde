interface IDrawable {
  void Draw();
}

interface IJsonable {
  JSONObject toJson();
}

interface ICollision {
  boolean CollisionCheck(BaseObjectLine line);
  boolean CollisionCheck(BaseObjectCircle circle);
  boolean CollisionCheck(BaseObjectRect rect);
  boolean CollisionCheck(BaseObjectTiltedRect rect);
  boolean CollisionCheck(BaseObjectPolygon polygon);
}

class BaseObjectLine implements ICollision, IDrawable, IJsonable {
  Vec2 initial;
  Vec2 vector;
  BaseObjectLine(Vec2 initial, Vec2 vector) {
    this.initial = initial;
    this.vector = vector;
  }
  BaseObjectLine(float ix, float iy, float vx, float vy) {
    initial = new Vec2(ix, iy);
    vector = new Vec2(vx, vy);
  }
  BaseObjectLine(JSONObject json) {
    initial = new Vec2(json.getJSONObject("initial"));
    vector = new Vec2(json.getJSONObject("vector"));
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setJSONObject("initial", initial.toJson());
    json.setJSONObject("vector", vector.toJson());
    json.setString("class", "BaseObjectLine");
    return json;
  }
  Vec2 terminal() {
    return initial.add(vector);
  }
  boolean IsLeftSide(Vec2 point) {
    Vec2 temp = initial.to(point);
    return vector.cross(temp) < 0;
  }
  String toString() {
    return "[initial:" + initial + ",terminal:" + terminal()+ ",vector:" + vector+"]";
  }
  void Draw() {
    push();
    line(initial, terminal());
    pop();
  }
  boolean CollisionCheck(BaseObjectLine line) {
    if (0 < vector.cross(line.initial.sub(initial)) * vector.cross(line.terminal().sub(initial)))
      return false;
    if (0 < line.vector.cross(initial.sub(line.initial)) * line.vector.cross(terminal().sub(line.initial)))
      return false;
    return true;
  }
  boolean CollisionCheck(BaseObjectCircle circle) {
    Vec2 A = initial.to(circle.center);
    float d = abs(vector.cross(A))/vector.mag();
    if (d > circle.radius) return false;
    Vec2 B = terminal().to(circle.center);
    if (vector.dot(A)*vector.dot(B) <= 0) return true;
    if (A.mag()<=circle.radius || B.mag()<=circle.radius) return true;
    return false;
  }
  boolean CollisionCheck(BaseObjectRect rect) {
    return rect.CollisionCheck(this);
  }
  boolean CollisionCheck(BaseObjectTiltedRect rect) {
    return rect.CollisionCheck(this);
  }
  boolean CollisionCheck(BaseObjectPolygon polygon) {
    return polygon.CollisionCheck(this);
  }
}

class BaseObjectCircle implements ICollision, IDrawable, IJsonable {
  Vec2 center;
  float radius;
  BaseObjectCircle(Vec2 p, float r) {
    center = p;
    radius = r;
  }
  BaseObjectCircle(float x1, float y1, float r) {
    center = new Vec2(x1, y1);
    radius = r;
  }
  BaseObjectCircle(JSONObject json) {
    center = new Vec2(json.getJSONObject("center"));
    radius = json.getFloat("radius");
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setJSONObject("center", center.toJson());
    json.setFloat("radius", radius);
    json.setString("class", "BaseObjectCircle");
    return json;
  }
  String toString() {
    return "[center:" + center + ",radius:" + radius + "]";
  }
  void Draw() {
    circle(center, radius*2);
  }
  boolean CollisionCheck(BaseObjectLine line) {
    return line.CollisionCheck(this);
  }
  boolean CollisionCheck(BaseObjectCircle circle) {
    return center.sub(circle.center).mag() <= radius + circle.radius;
  }
  boolean CollisionCheck(BaseObjectRect rect) {
    return rect.CollisionCheck(this);
  }
  boolean CollisionCheck(BaseObjectTiltedRect rect) {
    return rect.CollisionCheck(this);
  }
  boolean CollisionCheck(BaseObjectPolygon polygon) {
    return polygon.CollisionCheck(this);
  }
}

class OriginObjectPolygon {
  //MUST_OVVERRIDE
  ArrayList<Vec2> GetVertices() {
    if (true)
      throw new RuntimeException("ERROR:define GetVertices Method");
    return new ArrayList<Vec2>();
  }
  ArrayList<BaseObjectLine> GetSides() {
    ArrayList<BaseObjectLine> sides = new ArrayList<BaseObjectLine>();
    ArrayList<Vec2>vertices = GetVertices();
    for (int i = 0; i<vertices.size(); i++) {
      sides.add(new BaseObjectLine(vertices.get(i), vertices.get(i).to(vertices.get((i+1)%vertices.size()))));
    }
    return sides;
  }
  boolean IsInside(Vec2 point) {
    for (BaseObjectLine side : GetSides()) {
      if (side.IsLeftSide(point)) return false;
    }
    return true;
  }
  boolean CollisionCheck(BaseObjectLine line) {
    if (IsInside(line.initial) || IsInside(line.terminal())) return true;
    for (BaseObjectLine side : GetSides()) {
      if (side.CollisionCheck(line)) return true;
    }
    return false;
  }
  boolean CollisionCheck(BaseObjectCircle circle) {
    if (IsInside(circle.center)) return true;
    for (BaseObjectLine side : GetSides()) {
      if (side.CollisionCheck(circle)) return true;
    }
    return false;
  }
  boolean CollisionCheck(BaseObjectRect rect) {
    for (Vec2 vertex : GetVertices()) {
      if (rect.IsInside(vertex)) return true;
    }
    return false;
  }
  boolean CollisionCheck(BaseObjectTiltedRect rect) {
    for (Vec2 vertex : rect.GetVertices()) {
      if (IsInside(vertex)) return true;
    }
    return false;
  }
  boolean CollisionCheck(BaseObjectPolygon polygon) {
    for (Vec2 vertex : polygon.GetVertices()) {
      if (IsInside(vertex)) return true;
    }
    return false;
  }
}

class BaseObjectRect extends OriginObjectPolygon implements ICollision, IDrawable, IJsonable {
  Vec2 position;
  Vec2 size;
  BaseObjectRect(Vec2 position, Vec2 size) {
    this.position = position;
    this.size = size;
  }
  BaseObjectRect(float px, float py, float sx, float sy) {
    position = new Vec2(px, py);
    size = new Vec2(sx, sy);
  }
  BaseObjectRect(JSONObject json) {
    position = new Vec2(json.getJSONObject("position"));
    position = new Vec2(json.getJSONObject("size"));
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setJSONObject("position", position.toJson());
    json.setJSONObject("size", size.toJson());
    json.setString("class", "BaseObjectRect");
    return json;
  }
  String toString() {
    return "[position:" + position + ",size:" + size + "]";
  }
  void Draw() {
    rect(position, size);
  }
  ArrayList<Vec2> GetVertices() {
    ArrayList<Vec2> re = new ArrayList<Vec2>();
    re.add(position);
    re.add(position.add(new Vec2(size.x, 0)));
    re.add(position.add(size));
    re.add(position.add(new Vec2(0, size.y)));
    return re;
  }
  boolean IsInside(Vec2 point) {
    return position.x <= point.x && point.x <= position.x + size.x &&
      position.y <= point.y && point.y <= position.y + size.y;
  }
  boolean CollisionCheck(BaseObjectRect rect) {
    return position.x-rect.size.x<=rect.position.x &&rect.position.x <= position.x + size.x &&
      position.y-rect.size.y<=rect.position.y &&rect.position.y <= position.y + size.y ;
  }
}

class BaseObjectTiltedRect extends OriginObjectPolygon implements ICollision, IDrawable, IJsonable {
  float tilt;
  Vec2 position;
  Vec2 size;
  BaseObjectTiltedRect(Vec2 position, Vec2 size, float tilt) {
    this.position = position;
    this.size = size;
    this.tilt = tilt;
  }
  BaseObjectTiltedRect(JSONObject json) {
    position = new Vec2(json.getJSONObject("position"));
    size = new Vec2(json.getJSONObject("size"));
    tilt = json.getFloat("tilt");
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setJSONObject("position", position.toJson());
    json.setJSONObject("size", size.toJson());
    json.setFloat("tilt", tilt);
    json.setString("class", "BaseObjectTiltedRect");
    return json;
  }
  String toString() {
    return "[position:" + position + ",size:" + size + ",tilt:" + tilt + "]";
  }
  void Draw() {
    translate(position);
    rotate(tilt);
    rect(new Vec2(), size);
  }
  ArrayList<Vec2> GetVertices() {
    ArrayList<Vec2> re =new ArrayList<Vec2>();
    re.add(position);
    re.add(position.add(new Vec2(size.x, 0).rotate(tilt)));
    re.add(position.add(size.rotate(tilt)));
    re.add(position.add(new Vec2(0, size.y).rotate(tilt)));
    //for(Vec2 r:re) circle(r.x,r.y,5);
    return re;
  }
}
class BaseObjectPolygon extends OriginObjectPolygon implements ICollision, IDrawable, IJsonable {
  ArrayList<Vec2> vertices;
  //右回りに頂点が並んでいる凸多角形であること
  BaseObjectPolygon(ArrayList<Vec2> vertices) {
    this.vertices = vertices;
  }
  BaseObjectPolygon(JSONObject json) {
    vertices = new ArrayList<Vec2>();
    JSONArray verticesArray = json.getJSONArray("vertices");
    for (int i=0; i<verticesArray.size(); i++) {
      vertices.add(new Vec2(verticesArray.getJSONObject(i)));
    }
  }
  JSONObject toJson() {
    JSONArray verticesArray = new JSONArray();
    for (int i=0; i<vertices.size(); i++) {
      verticesArray.setJSONObject(i, vertices.get(i).toJson());
    }
    JSONObject json = new JSONObject();
    json.setString("class", "BaseObjectRect");
    json.setJSONArray("vertices", verticesArray);
    return json;
  }
  String toString() {
    return vertices.toString();
  }
  ArrayList<Vec2> GetVertices() {
    return vertices;
  }
  void Draw() {
    beginShape();
    for (Vec2 v : GetVertices()) {
      vertex(v);
    }
    endShape(CLOSE);
  }
}

class BaseObjectText implements IDrawable, IJsonable {
  Vec2 position;
  String text;
  float size;
  PFont font = null;
  BaseObjectText(String text,Vec2 position, float size) {
    this.text = text;
    this.position = position;
    this.size = size;
  }
  BaseObjectText(JSONObject json) {
    position = new Vec2(json.getJSONObject("position"));
    text = json.getString("text");
    size = json.getFloat("size");
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setJSONObject("position", position.toJson());
    json.setFloat("size", size);
    json.setString("text", text);
    json.setString("class", "BaseObjectText");
    return json;
  }
  String toString() {
    return "[text:" + text + ",position:" + position+ ",size:" + size+"]";
  }
  BaseObjectText SetFont(PFont font) {
    this.font = font;
    return this;
  }
  void SetStyle(){
    if(font != null) textFont(font);
    textSize(size);
  }
  void Draw() {
    push();
    text(text,position);
    pop();
  }
}
