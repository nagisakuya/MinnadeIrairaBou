class RectObject extends CollisionTiltedRect implements IDrawable {
  RectObject(PVector position, PVector size, float tilt) {
    super(position,size,tilt);
  }
  RectObject(float x1, float y1, float x2, float y2, float tilt) {
    super(new PVector(x1, y1),new PVector(x2, y2),tilt);
  }
  void Draw() {
    push();
    translate(position.x, position.y);
    rotate(tilt);
    rect(0, 0, size.x, size.y);
    pop();
  }
  ArrayList<ICollision> GetCollision() {
    ArrayList<ICollision> re = new ArrayList<ICollision>(1);
    re.add(new CollisionTiltedRect(position, size, tilt));
    return re;
  }
}

class RectMovableObject extends RectObject {
  RectObject previous;
  void UpdatePrevious() {
    previous = new RectObject(position, size, tilt);
  }
  RectMovableObject(float x1, float y1, float x2, float y2, float angle) {
    super(x1, y1, x2, y2, angle);
    UpdatePrevious();
  }
  void Draw() {
    super.Draw();
    UpdatePrevious();
  }
  ArrayList<ICollision> GetCollision() {
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    int temp;
    if (previous.position.x < position.x) {
      if (previous.position.y < position.y) {
        temp = 3;
      } else {
        temp = 2;
      }
    } else {
      if (previous.position.y < position.y) {
        temp = 0;
      } else {
        temp = 1;
      }
    }
    ArrayList<PVector> tempVertices = previous.GetVertices();
    for (int i = 0; i < 3; i++) {
      vertices.add(tempVertices.get((i+temp)%4));
    }
    tempVertices = GetVertices();
    for (int i = 0; i < 3; i++) {
      vertices.add(tempVertices.get((i+temp+2)%4));
    }
    ArrayList<ICollision> re =new ArrayList<ICollision>();
    re.add(new CollisionPolygon(vertices));
    return re;
  }
}
