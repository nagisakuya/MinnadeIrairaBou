class Vec2 {
  float x;
  float y;
  Vec2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Vec2(Vec2 vec) {
    this.x = vec.x;
    this.y = vec.y;
  }
  Vec2() {
    this.x = 0;
    this.y = 0;
  }
  Vec2 copy() {
    return new Vec2(this);
  }
  void set(float x, float y) {
    this.x = x;
    this.y = y;
  }
  float mag() {
    return sqrt(x*x + y*y);
  }
  Vec2 add(Vec2 vec) {
    return new Vec2(x+vec.x, y+vec.y);
  }
  Vec2 sub(Vec2 vec) {
    return new Vec2(x-vec.x, y-vec.y);
  }
  Vec2 to(Vec2 vec) {
    return new Vec2(vec.x-x, vec.y-y);
  }
  Vec2 mult(float scalar) {
    return new Vec2(x*scalar, y*scalar);
  }
  Vec2 div(float scalar) {
    return new Vec2(x/scalar, y/scalar);
  }
  float dist(Vec2 vec) {
    return sqrt(pow(x-vec.x, 2)+pow(y-vec.y, 2));
  }
  float dot(Vec2 vec) {
    return x*vec.x + y*vec.y;
  }
  float cross(Vec2 vec) {
    return x*vec.y - y*vec.x;
  }
  Vec2 normalize(){
    return div(mag());
  }
  Vec2 setMag(float scalar){
    return normalize().mult(scalar);
  }
  Vec2 rotate(float radian){
    return new Vec2(x*cos(radian)+y*sin(radian),x*sin(radian)+y*cos(radian));
  }
  Vec2 lerp(Vec2 vec){
    return vec.mult(dot(vec)/pow(vec.mag(),2));
  }
  float angle(Vec2 vec){
    return acos(dot(vec)/(mag()*vec.mag()));
  }
  float angle(){
    float temp = acos(x/mag());
    if(y>=0){
      return temp;
    }
    else{
      return PI*2-temp;
    }
  }
}
