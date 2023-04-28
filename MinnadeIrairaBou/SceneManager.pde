enum Scene {
  Game, 
    Goal,
}

Scene CurrentScene = Scene.Game;
int CurrentStage = 0;

int GoalSceneChangeTime = 270;

void ChangeScene(Scene scene) {
  if (CurrentScene != scene) {
    CurrentScene = scene;
    if (CurrentScene == Scene.Game) {
      for(int i=0;i<objects.size();){
        if(objects.get(i) instanceof FireWork || objects.get(i) instanceof IStageObject){
          objects.remove(i);
        }else{
          i++;
        }
      }
      CurrentStage++;
      objects.addAll(0,stages.get(CurrentStage));
    } else if (CurrentScene == Scene.Goal) {
        for(int i=0;i<objects.size();){
        if(objects.get(i) instanceof SceneChangeObject){
          objects.remove(i);
        }else{
          i++;
        }
      }
      for (int i=0; i<30; i++) {
        objects.add(new FireWork());
        objects.add(new SceneChangeObject(250, 20));
      }
    }
  }
}

class SceneChangeObject implements IDrawable {
  int coverTime;
  int interbal = 10;
  int time = 0;
  SceneChangeObject(int delay, int coverTime) {
    this.time = -delay;
    this.coverTime = coverTime;
  }
  void Draw() {
    push();
    time++;
    if (time>=0) {
      fill(0);
      if (time <= coverTime) {
        arc(WindowCenter(), new Vec2(width, height).mult(2), -HALF_PI, TWO_PI*((float)time/coverTime)-HALF_PI);
      }else if (time <= coverTime + interbal) {
        rect(new Vec2(),new Vec2(width,height));
      }else if (time <= 2*coverTime + interbal) {
        arc(WindowCenter(), new Vec2(width, height).mult(2), TWO_PI*((float)(time - coverTime - interbal)/coverTime)-HALF_PI,TWO_PI-HALF_PI); //<>//
      }
    }
    if (time == coverTime) ChangeScene(Scene.Game);
    pop();
  }
}
