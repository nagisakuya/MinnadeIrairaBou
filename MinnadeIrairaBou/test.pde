IDrawable testRotateWall = new RotateObject(ObjectType.Wall, new Vec2(200, 100), new Vec2(100, 300), new Vec2(300, 400), 0, 0.3);
IDrawable testSinWall = new SinMoveObject(ObjectType.Wall, new Vec2(200, 100), new Vec2(100, 300), 0, 0.3, new Vec2(50, 50), 5);
IDrawable testGoal = new RectObject(ObjectType.Goal, new Vec2(300, 300), new Vec2(100, 100), 0);

void JSONTest() {
  println(WriteStage(GetIStageObject(objects)));
  objects = LoadStage(WriteStage(GetIStageObject(objects)));
}
