Player player;
String serverUrl = "http://localhost:25565/api/Iraira";

ArrayList<IDrawable> objects = new ArrayList<IDrawable>();

void setup() {
  size(800, 800);
  objects.add(new RectWall(200, 200, 200, 300,PI/3));
  player = new Player(100, 100);
  objects.add(player);
  //println(new CollisionRect(new PVector(100,100),new PVector(100,100)).GetSides().get(3));
}

void draw() {
  background(255);
  for (IMovable o : GetMovables()) {
    o.Move();
  }
  for (IDrawable o : objects) {
    o.Draw();
  }
  //JSONObject json = loadJSONObject(serverUrl);
  //p.addSpeed(new PVector(json.getFloat("x"), json.getFloat("y")));
}

void keyPressed() {
  if (keyCode == UP) {
    player.addSpeed(new PVector(0, -1));
  }
  if (keyCode == DOWN) {
    player.addSpeed(new PVector(0, 1));
  }
  if (keyCode == RIGHT) {
    player.addSpeed(new PVector(1, 0));
  }
  if (keyCode == LEFT) {
    player.addSpeed(new PVector(-1, 0));
  }
}
