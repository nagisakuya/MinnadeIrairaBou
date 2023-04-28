interface IWall {
  ArrayList<ICollision> GetCollision();
}

class RectWall extends RectObject implements IWall {
  RectWall(float x1, float y1, float x2, float y2,float angle) {
    super(x1,y1,x2,y2,angle);
  }
}

/*class SinMoveWall extends RectObject implements IWall {
  float theta = 0;
  float speed = 1;
  float 
  SinMoveWall(float x1, float y1, float x2, float y2,float angle) {
    super(x1,y1,x2,y2,angle);
  }
  Move
}*/
