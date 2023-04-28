interface IMovable{
  void Move();
}

enum ObjectType{
  Wall,
  Goal,
  Player,
  Text,
}

class RectObject extends BaseObjectTiltedRect implements IDrawable,IStageObject {
  ObjectType type;
  RectObject(ObjectType type,Vec2 position, Vec2 size, float tilt) {
    super(position,size,tilt);
    this.type = type;
  }
  RectObject(JSONObject json) {
    super(json);
    type = ObjectType.valueOf(json.getString("type"));
  }
  JSONObject toJson() {
    JSONObject json = super.toJson();
    json.setString("type",type.name());
    json.setString("class","RectObject");
    return json;
  }
  Vec2 GetPosition(){
    return position;
  }
  ObjectType GetType(){
    return type;
  }
  void Draw() {
    push();
    if(GetType() == ObjectType.Wall){
      noStroke();
      fill(255,0,51);
    }else if(GetType() == ObjectType.Goal){
      noStroke();
      fill(0,255,0);
    }
    translate(position);
    rotate(tilt);
    rect(new Vec2(),size);
    pop();
  }
  ArrayList<ICollision> GetCollision() {
    ArrayList<ICollision> re = new ArrayList<ICollision>(1);
    re.add(new BaseObjectTiltedRect(position, size, tilt));
    return re;
  }
}

class RectLinerMoveObject extends RectObject {
  BaseObjectTiltedRect previous;
  void UpdatePrevious() {
    previous = new BaseObjectTiltedRect(position, size, tilt);
  }
  RectLinerMoveObject(ObjectType type,Vec2 position, Vec2 size, float tilt) {
    super(type,position,size,tilt);
  }
  RectLinerMoveObject(JSONObject json) {
    super(json);
  }
  JSONObject toJson() {
    JSONObject json = super.toJson();
    json.setString("class","RectLinerMoveObject");
    return json;
  }
  ArrayList<ICollision> GetCollision() {
    ArrayList<Vec2> vertices = new ArrayList<Vec2>();
    int temp;
    float theta = previous.position.to(position).angle() - previous.tilt;
    if(theta < 0) theta += PI*2;
    if (theta<=PI/2) {
      temp = 3;
    }else if (theta<=PI) {
      temp = 0;
    }else if (theta<=PI*3/2) {
      temp = 1;
    }else {
      temp = 2;
    } 
    ArrayList<Vec2> tempVertices = previous.GetVertices();
    for (int i = 0; i < 3; i++) {
      vertices.add(tempVertices.get((i+temp)%4));
    }
    theta = previous.position.to(position).angle() - tilt;
    if(theta < 0) theta += PI*2;
    if (theta<=PI/2) {
      temp = 1;
    }else if (theta<=PI) {
      temp = 2;
    }else if (theta<=PI*3/2) {
      temp = 3;
    }else {
      temp = 0;
    } 
    tempVertices = GetVertices();
    for (int i = 0; i < 3; i++) {
      vertices.add(tempVertices.get((i+temp)%4));
    }
    for (int i = 0; i < vertices.size();) {
      if(vertices.get(i) == vertices.get((i+1)%vertices.size())){
        vertices.remove(i);
        continue;
      }
      i++;
    }
    ArrayList<ICollision> re =new ArrayList<ICollision>();
    re.add(new BaseObjectPolygon(vertices));
    return re;
  }
}

class SinMoveObject extends RectLinerMoveObject implements IMovable {
  float theta;
  final float hertz;
  final Vec2 basePosition;
  final Vec2 direction;
  SinMoveObject(ObjectType type, Vec2 pos, Vec2 size, float angle, float hertz, Vec2 direction, float theta) {
    super(type, pos, size, angle);
    this.basePosition = this.position;
    this.hertz = hertz;
    this.direction = direction;
    this.theta = theta;
    SetPosition();
  }
  SinMoveObject(JSONObject json) {
    super(json);
    basePosition = new Vec2(json.getJSONObject("basePosition"));
    direction = new Vec2(json.getJSONObject("direction"));
    hertz = json.getFloat("hertz");
    theta = json.getFloat("theta");
  }
  JSONObject toJson() {
    JSONObject json = super.toJson();
    json.setJSONObject("basePosition", basePosition.toJson());
    json.setJSONObject("direction", direction.toJson());
    json.setFloat("hertz", hertz);
    json.setFloat("theta", theta);
    json.setString("class","SinMoveObject");
    return json;
  }
  void SetPosition() {
    UpdatePrevious();
    position = basePosition.add(direction.mult(sin(theta)));
  }
  void Move() {
    theta += hertz * 2*PI/frameRate;
    SetPosition();
  }
}

class RotateObject extends RectObject implements IMovable {
  final float hertz;
  Vec2 center;
  float theta = 0;
  final Vec2 initialPosition;
  final float initialTilt;
  RotateObject(ObjectType type, Vec2 pos, Vec2 size, Vec2 center, float tilt, float hertz) {
    super(type, pos, size, tilt);
    this.hertz = hertz;
    this.center = center;
    initialTilt = tilt;
    initialPosition = position;
    Move();
  }
  RotateObject(JSONObject json) {
    super(json);
    center = new Vec2(json.getJSONObject("center"));
    hertz = json.getFloat("hertz");
    initialTilt = tilt;
    initialPosition = position;
  }
  JSONObject toJson() {
    JSONObject json = super.toJson();
    json.setJSONObject("center", center.toJson());
    json.setFloat("hertz", hertz);
    json.setString("class","RotateObject");
    return json;
  }
  RotateObject SetTheta(float theta){
    this.theta = theta;
    return this;
  }
  void Move() {
    theta += hertz * 2*PI/frameRate;
    tilt = initialTilt + theta;
    position = center.add(center.to(initialPosition).rotate(theta));
  }
}
