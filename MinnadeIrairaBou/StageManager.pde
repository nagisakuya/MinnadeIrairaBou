interface IStageObject {
  ObjectType GetType();
  ArrayList<ICollision> GetCollision();
  JSONObject toJson();
  Vec2 GetPosition();
}

ArrayList<IDrawable> LoadStage(JSONObject json) {
  ArrayList<IDrawable> stageObjects = new ArrayList<IDrawable>();
  JSONObject stageData = json.getJSONObject("stageData");
  JSONArray objectDataArray = json.getJSONArray("stageObjects");

  for (int i=0; i<objectDataArray.size(); i++) {
    stageObjects.add((IDrawable)JsonToStageObject(objectDataArray.getJSONObject(i)));
  }
  return stageObjects;
}

JSONObject WriteStage(ArrayList<IStageObject> stageObjects) {
  JSONObject stageData = new JSONObject();
  JSONArray objectDataArray = new JSONArray();

  for (int i=0; i<stageObjects.size(); i++) {
    objectDataArray.setJSONObject(i, stageObjects.get(i).toJson());
  }

  JSONObject json = new JSONObject();
  json.setJSONObject("stageData", stageData);
  json.setJSONArray("stageObjects", objectDataArray);

  return json;
}

IStageObject JsonToStageObject(JSONObject json) {
  String className = json.getString("class");
  if (className == "RectObject") {
    return new RectObject(json);
  } else if (className == "RectLinerMoveObject") {
    return new RectLinerMoveObject(json);
  } else if (className == "SinMoveObject") {
    return new SinMoveObject(json);
  } else if (className == "RotateObject") {
    return new RotateObject(json);
  } else if (className == "Player") {
    return new Player(json);
  }
  return null;
}

ArrayList<IStageObject> GetIStageObject(ArrayList<IDrawable> drawables){
  ArrayList<IStageObject> array = new ArrayList<IStageObject>();
  for(IDrawable o:drawables) if(o instanceof IStageObject) array.add((IStageObject)o);
  return array;
}
