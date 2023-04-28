ArrayList<ArrayList<IDrawable>> LoadStages() {
  ArrayList<ArrayList<IDrawable>> stages = new ArrayList<ArrayList<IDrawable>>();
  stages.add(TitleStage());
  stages.add(WallTutrioul());
  stages.add(Stage2());
  stages.add(SinStage());
  stages.add(RotateStage());
  stages.add(MultiPlayerStage());
  stages.add(finalstage());
  return stages;
}

ArrayList<IDrawable> GenerateSideWalls(float size) {
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 0), new Vec2(width, size), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, height-size), new Vec2(width, size), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(width-size, 0), new Vec2(size, height), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 0), new Vec2(size, height), 0));
  return objects;
}
ArrayList<IDrawable> GenerateCross(Vec2 pos,float size,float theta,float hertz) {
  float wsize = 15;
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.add(new RotateObject(ObjectType.Wall, pos.addX(-wsize/2), new Vec2(wsize, size),pos,0, hertz).SetTheta(theta));
  objects.add(new RotateObject(ObjectType.Wall, pos.addX(-wsize/2), new Vec2(wsize, size),pos,0, hertz).SetTheta(PI/2 + theta));
  objects.add(new RotateObject(ObjectType.Wall, pos.addX(-wsize/2), new Vec2(wsize, size),pos,0, hertz).SetTheta(PI+ theta));
  objects.add(new RotateObject(ObjectType.Wall, pos.addX(-wsize/2), new Vec2(wsize, size),pos,0, hertz).SetTheta(PI*3/2+ theta));
  return objects;
}

ArrayList<IDrawable> TitleStage() {
  PFont font = createFont("Data/851MkPOP_100.ttf", 60);
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.addAll(GenerateSideWalls(10));
  RectObject goal = new RectObject(ObjectType.Goal, new Vec2(650-150/2, 600-150/2), new Vec2(150, 150), 0);
  objects.add(goal);
  Player player = new Player(new Vec2(250, 600));
  objects.add(player);
  objects.add(new FloatingText("みんなで", new Vec2(90, 130), 120).SetFont(font));
  objects.add(new FloatingText("イライラ棒", new Vec2(150, 280), 170).SetFont(font));
  objects.add(new TrackingText("みんな↑", new Vec2(-155, 50), 50, player).SetFont(font));
  objects.add(new TrackingText("↑ゴール", new Vec2(goal.size.x/2-25, 50+goal.size.y), 50, goal).SetFont(font));
  return objects;
}

ArrayList<IDrawable> WallTutrioul() {
  PFont font = createFont("Data/851MkPOP_100.ttf", 60);
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.addAll(GenerateSideWalls(10));
  objects.add(new RectObject(ObjectType.Goal, new Vec2(800-150/2, 500-150/2), new Vec2(150, 150), 0));
  objects.add(new Player(new Vec2(200, 500)));
  RectObject wall = new RectObject(ObjectType.Wall, new Vec2(500-30/2, 500-600/2), new Vec2(30, 600), 0);
  objects.add(wall);
  objects.add(new TrackingText("↑触るな！", new Vec2().addY(wall.size.y).add(new Vec2(-10, 40)), 50, wall).SetFont(font));
  return objects;
}

ArrayList<IDrawable> Stage2() {
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.addAll(GenerateSideWalls(10));
  objects.add(new RectObject(ObjectType.Goal, new Vec2(700-100/2, 900-100/2), new Vec2(100, 100), 0));
  objects.add(new Player(new Vec2(100, 100)));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 200), new Vec2(500, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(600, 200), new Vec2(500, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 400), new Vec2(200, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(300, 400), new Vec2(400, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(800, 400), new Vec2(800, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 600), new Vec2(600, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(700, 600), new Vec2(500, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 800), new Vec2(300, 15), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(400, 800), new Vec2(1000, 15), 0));
  return objects;
}

ArrayList<IDrawable> SinStage() {
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.addAll(GenerateSideWalls(10));
  for (int i=0; i<5; i++) {
    objects.add(new SinMoveObject(ObjectType.Wall, new Vec2(200-100/2 + 150*i, 500-100/2), new Vec2(100, 100),0 ,0.1+i*0.01,new Vec2(0,400),0));
  }
  objects.add(new RectObject(ObjectType.Goal, new Vec2(900-100/2, 500-100/2), new Vec2(100, 100), 0));
  objects.add(new Player(new Vec2(100, 500)));
  return objects;
}

ArrayList<IDrawable> RotateStage() {
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 0), new Vec2(width, 300), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, height-300), new Vec2(width, 300), 0));
  objects.addAll(GenerateCross(new Vec2(350,400),110,0,-0.1));
  objects.addAll(GenerateCross(new Vec2(350,600),110,PI/4,0.1));
  objects.addAll(GenerateCross(new Vec2(600,400),110,PI/4,-0.1));
  objects.addAll(GenerateCross(new Vec2(600,600),110,0,0.1));
  ArrayList<IDrawable> temp = GenerateCross(new Vec2(1000,500),200,0,0.1);
  ((RotateObject)temp.get(1)).type = ObjectType.Goal;
  objects.addAll(temp);
  objects.addAll(GenerateSideWalls(10));
  objects.add(new Player(new Vec2(100, 500)));
  return objects;
}

ArrayList<IDrawable> MultiPlayerStage() {
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  objects.add(new RectObject(ObjectType.Goal, new Vec2(900,0), new Vec2(100, 1000), 0));
  objects.addAll(GenerateSideWalls(10));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 300), new Vec2(1000, 10), 0));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(0, 700), new Vec2(1000, 10), 0));
  
  objects.addAll(GenerateCross(new Vec2(400,1000),280,PI/4,0.03));
  objects.addAll(GenerateCross(new Vec2(700,850),140,0,-0.05));
  
  objects.add(new SinMoveObject(ObjectType.Wall, new Vec2(500-80/2, 65-80/2), new Vec2(80, 80),0 ,0.05,new Vec2(330,0),0));
  objects.add(new SinMoveObject(ObjectType.Wall, new Vec2(500-80/2, 155-80/2), new Vec2(80, 80),0 ,0.05,new Vec2(330,0),PI/3));
  objects.add(new SinMoveObject(ObjectType.Wall, new Vec2(500-80/2, 245-80/2), new Vec2(80, 80),0 ,0.05,new Vec2(330,0),TWO_PI/3));
  
  objects.add(new RectObject(ObjectType.Wall, new Vec2(50, 700), new Vec2(250, 15), -PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(150, 300), new Vec2(250, 15), PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(250, 700), new Vec2(250, 15), -PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(350, 300), new Vec2(250, 15), PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(450, 700), new Vec2(250, 15), -PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(550, 300), new Vec2(250, 15), PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(650, 700), new Vec2(250, 15), -PI/3));
  objects.add(new RectObject(ObjectType.Wall, new Vec2(750, 300), new Vec2(250, 15), PI/3));
  
  objects.add(new Player(new Vec2(100, 150)));
  objects.add(new Player(new Vec2(100, 500)));
  objects.add(new Player(new Vec2(100, 850)));
  return objects;
}

ArrayList<IDrawable> finalstage() {
  ArrayList<IDrawable> objects = new ArrayList<IDrawable>();
  PFont font = createFont("Data/851MkPOP_100.ttf", 60);
  objects.addAll(GenerateSideWalls(10));
  Player player = new Player(WindowCenter());
  objects.add(player);
  objects.add(new FloatingText("CONGRATULATIONS", new Vec2(50, 150), 100).SetFont(font));
  objects.add(new FloatingText("全ステージクリア！", new Vec2(50, 340), 130).SetFont(font));
  return objects;
}
