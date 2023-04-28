import java.util.function.Supplier; //<>//

String serverUrl = "http://localhost:80/IrairaBou/";
ArrayList<IDrawable> objects = new ArrayList<IDrawable>();

ArrayList<ArrayList<IDrawable>> stages;

void setup() {
  size(1000, 1000);
  stages = LoadStages();
  objects = stages.get(0);
  loadJSONObject(serverUrl);
  //objects = RotateStage();
}

void draw() {
  JSONObject json = loadJSONObject(serverUrl);
  for (Player player : GetPlayers(objects)) {
    player.ReciveJson(json);
  }
  background(255);
  for (int i=0; i<objects.size(); i++) {
    if (objects.get(i) instanceof IMovable) ((IMovable)objects.get(i)).Move();
  }
  for (int i=0; i<objects.size(); i++) {
    objects.get(i).Draw();
  }
}

void keyPressed() {
  JSONObject json = new JSONObject();
  json.setInt("up", keyCode == UP ? 1:0);
  json.setInt("down", keyCode == DOWN ? 1:0);
  json.setInt("right", keyCode == RIGHT ? 1:0);
  json.setInt("left", keyCode == LEFT ? 1:0);
  for (Player player : GetPlayers(objects)) {
    player.ReciveJson(json);
  }
}
