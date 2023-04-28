boolean RestartFlag = false;

void DrawArrow(Vec2 pos,float angle,float size,float space) {
  if(size == 0) return;
  push();
  translate(pos);
  translate(new Vec2(space,0).rotate(angle));
  scale(size / 200);
  rotate(angle);
  beginShape();
  vertex(0, -50);
  vertex(100, -50);
  vertex(100, -100);
  vertex(200, 0);
  vertex(100, 100);
  vertex(100, 50);
  vertex(0, 50);
  endShape(CLOSE);
  pop();
}

enum Direction{
  up,
  down,
  right,
  left
}

class Player implements IDrawable, IMovable, IStageObject {
  Vec2 startPosition;
  Vec2 position;
  Vec2 previoiusPos;
  Vec2 speed = new Vec2();
  float size = 10;
  float speedDecelerate = 0.95;
  HashMap<Direction,ArrayList<Integer>> inputTimeStamp;
  Player(Vec2 pos) {
    startPosition = pos;
    position = startPosition;
    previoiusPos = position;
    inputTimeStamp = new HashMap<Direction,ArrayList<Integer>>();
    inputTimeStamp.put(Direction.up,new ArrayList<Integer>());
    inputTimeStamp.put(Direction.down,new ArrayList<Integer>());
    inputTimeStamp.put(Direction.right,new ArrayList<Integer>());
    inputTimeStamp.put(Direction.left,new ArrayList<Integer>());
  }
  //コンストラクタからコンストラクタ呼べるようにしてくれ
  //コピペ
  Player(JSONObject json) {
    startPosition = new Vec2(json.getJSONObject("startPosition"));
    position = startPosition;
    previoiusPos = position;
    inputTimeStamp = new HashMap<Direction,ArrayList<Integer>>();
    inputTimeStamp.put(Direction.up,new ArrayList<Integer>());
    inputTimeStamp.put(Direction.down,new ArrayList<Integer>());
    inputTimeStamp.put(Direction.right,new ArrayList<Integer>());
    inputTimeStamp.put(Direction.left,new ArrayList<Integer>());
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setJSONObject("startPosition", startPosition.toJson());
    json.setString("class", "Player");
    return json;
  }
  Vec2 GetPosition() {
    return position;
  }
  ObjectType GetType() {
    return ObjectType.Player;
  }
  ArrayList<ICollision> GetCollision() {
    ArrayList<ICollision> re = new ArrayList<ICollision>();
    re.add(new BaseObjectCircle(position, size/2));
    re.add(new BaseObjectLine(position, previoiusPos.sub(position)));
    return re;
  }
  void Move() {
    previoiusPos = position;
    position = position.add(speed);
    speed = speed.mult(speedDecelerate);
  }
  void CollisionCheck() {
    if(CurrentScene != Scene.Game) return;
    BaseObjectCircle cCircle = new BaseObjectCircle(position, size/2);
    BaseObjectLine cLine = new BaseObjectLine(position, previoiusPos.sub(position));
    fill(255);
    for (int i=0; i<objects.size(); i++) {
      if (objects.get(i) instanceof IStageObject) {
        for (ICollision c : ((IStageObject)objects.get(i)).GetCollision()) {
          if (c.CollisionCheck(cCircle) || c.CollisionCheck(cLine)) {
            if (((IStageObject)objects.get(i)).GetType() == ObjectType.Wall) {
              position = startPosition;
              speed = new Vec2();
              break;
            } else if (((IStageObject)objects.get(i)).GetType() == ObjectType.Goal) {
              ChangeScene(Scene.Goal);
              break;
            }
          }
        }
      }
    }
  }
  void DrawFlag() {
    push();
    translate(startPosition);
    line(new Vec2(), new Vec2(0, -50));
    fill(0, 255, 0);
    triangle(new Vec2(0, -35), new Vec2(0, -50), new Vec2(30, -42));
    pop();
  }
  void DrawArrows() {
    push();
    for(Direction d :inputTimeStamp.keySet()){
      ArrayList<Integer> array = inputTimeStamp.get(d);
      for(int i=0;i<array.size();){
        array.set(i,array.get(i)-1);
        if(array.get(i) == 0){
          array.remove(i);
          continue;
        }
        i++;
      }
    }
    noFill();
    float scale = 3;
    DrawArrow(position,0,scale*sqrt(inputTimeStamp.get(Direction.right).size()),size);
    DrawArrow(position,HALF_PI,scale*sqrt(inputTimeStamp.get(Direction.down).size()),size);
    DrawArrow(position,PI,scale*sqrt(inputTimeStamp.get(Direction.left).size()),size);
    DrawArrow(position,-HALF_PI,scale*sqrt(inputTimeStamp.get(Direction.up).size()),size);
    pop();
  }
  void Draw() {
    DrawFlag();
    DrawArrows();
    fill(255);
    CollisionCheck();
    circle(position, size);
  }
  void addSpeed(Vec2 v) {
    speed = speed.add(v);
  }
  void ReciveJson(JSONObject json) {
    if (CurrentScene == Scene.Game) {
      int up = json.getInt("up");
      int down = json.getInt("down");
      int right = json.getInt("right");
      int left = json.getInt("left");
      int remainTime = 60;
      for(int i=0;i<up;i++) inputTimeStamp.get(Direction.up).add(remainTime);
      for(int i=0;i<down;i++) inputTimeStamp.get(Direction.down).add(remainTime);
      for(int i=0;i<right;i++) inputTimeStamp.get(Direction.right).add(remainTime);
      for(int i=0;i<left;i++) inputTimeStamp.get(Direction.left).add(remainTime);
      speed = speed.add(new Vec2(right-left,down-up).div(10));
    }
  }
}

ArrayList<Player> GetPlayers(ArrayList<IDrawable> drawables) {
  ArrayList<Player> array = new ArrayList<Player>();
  for (IDrawable o : drawables) if (o instanceof Player) array.add((Player)o);
  return array;
}
