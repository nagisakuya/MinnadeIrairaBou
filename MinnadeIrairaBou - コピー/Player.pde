class Player implements IDrawable,IMovable {
  PVector defaultPos;
  PVector pos;
  PVector previoiusPos;
  PVector speed = new PVector();
  float size = 5;
  float speedDecelerate = 0.95;
  Player(int x, int y) {
    defaultPos = new PVector(x, y);
    pos = defaultPos.copy();
  }
  void Move() {
    previoiusPos = pos.copy();
    pos.add(speed);
    speed.mult(speedDecelerate);
  }
  void CollisionCheck(){
    ArrayList<IWall> walls = GetWalls();
    CollisionCircle cCircle = new CollisionCircle(pos, size);
    CollisionLine cLine = new CollisionLine(pos, previoiusPos.copy().sub(pos));
    for (IWall wall : walls) {
      for (ICollision c : wall.GetCollision()) {
        if (c.CollisionCheck(cCircle) || c.CollisionCheck(cLine)) {
          //pos = defaultPos.copy();
          //speed = new PVector();
          fill(255,0,0);
          break;
        }
      }
    }
  }
  void Draw() {
    fill(255);
    CollisionCheck();
    ellipse(pos.x, pos.y, size*2, size*2);
  }
  void addSpeed(PVector v) {
    speed.add(v);
  }
}
