class FloatingText extends BaseObjectText implements IStageObject{
  Vec2 floatDirection = new Vec2(0,20);
  float space = 0;
  FloatingText(String text,Vec2 position,float size){
    super(text,position,size);
  }
  FloatingText(JSONObject json){
    super(json);
  }
  JSONObject toJson(){
    return super.toJson();
  }
  ObjectType GetType(){
    return ObjectType.Text;
  }
  Vec2 GetPosition(){
    return position;
  }
  ArrayList<ICollision> GetCollision(){
    return new ArrayList<ICollision>();
  }
  void Draw(){
    push();
    fill(0);
    SetStyle();
    for(int i=0,pos=0;i<text.length();i++){
      text(text.charAt(i),position.add(floatDirection.mult(noise(i,frameCount*0.01)).addX(pos)));
      pos += space + textWidth(text.charAt(i));
    }
    pop();
  }
}

class TrackingText extends BaseObjectText implements IStageObject{
  float space = 0;
  IStageObject target;
  TrackingText(String text,Vec2 position,float size,IStageObject target){
    super(text,position,size);
    this.target = target;
  }
  TrackingText(JSONObject json){
    super(json);
  }
  JSONObject toJson(){
    return super.toJson();
  }
  ObjectType GetType(){
    return ObjectType.Text;
  }
  Vec2 GetPosition(){
    return position;
  }
  ArrayList<ICollision> GetCollision(){
    return new ArrayList<ICollision>();
  }
  void Draw(){
    push();
    fill(0);
    SetStyle();
    for(int i=0,pos=0;i<text.length();i++){
      text(text.charAt(i),target.GetPosition().add(position).addX(pos));
      pos += space + textWidth(text.charAt(i));
    }
    pop();
  }
}
