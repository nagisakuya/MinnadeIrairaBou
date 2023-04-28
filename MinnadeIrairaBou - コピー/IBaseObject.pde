//流石にラムダ式使いて～
ArrayList<IWall> GetWalls(){
  ArrayList<IWall> walls = new ArrayList<IWall>();
  for(IDrawable d:objects)
  if(d instanceof IWall) walls.add((IWall)d);
  return walls;
}
ArrayList<IMovable> GetMovables(){
  ArrayList<IMovable> movables = new ArrayList<IMovable>();
  for(IDrawable d:objects)
  if(d instanceof IMovable) movables.add((IMovable)d);
  return movables;
}

interface IDrawable{
  void Draw();
}

interface IMovable{
  void Move();
}
