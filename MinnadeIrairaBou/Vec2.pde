class Vec2 {
  final float x;
  final float y;
  Vec2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Vec2(Vec2 vec) {
    this.x = vec.x;
    this.y = vec.y;
  }
  Vec2(JSONObject json) {
    this.x = json.getFloat("x");
    this.y = json.getFloat("y");
  }
  Vec2() {
    this.x = 0;
    this.y = 0;
  }
  String toString() {
    return "["+x+","+y+"]";
  }
  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.setFloat("x",x);
    json.setFloat("y",y);
    return json;
  }
  Vec2 copy() {
    return new Vec2(this);
  }
  float mag() {
    return sqrt(x*x + y*y);
  }
  Vec2 add(Vec2 vec) {
    return new Vec2(x+vec.x, y+vec.y);
  }
  Vec2 addX(float x) {
    return new Vec2(this.x+x, y);
  }
  Vec2 addY(float y) {
    return new Vec2(x, this.y+y);
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
    return x * vec.x + y * vec.y;
  }
  float cross(Vec2 vec) {
    return x * vec.y - y * vec.x;
  }
  Vec2 normalize() {
    return div(mag());
  }
  Vec2 setMag(float scalar) {
    return normalize().mult(scalar); //<>//
  }
  Vec2 rotate(float radian) {
    return new Vec2(x*cos(radian)-y*sin(radian), x*sin(radian)+y*cos(radian));
  }
  Vec2 lerp(Vec2 vec) {
    return vec.mult(dot(vec)/pow(vec.mag(), 2));
  }
  float angle(Vec2 vec) {
    return acos(dot(vec)/(mag()*vec.mag()));
  }
  //return 0~2PI
  float angle() {
    float temp = acos(x/mag());
    if (y>=0) {
      return temp;
    } else {
      return PI*2-temp;
    }
  }
}

Vec2 WindowCenter(){
  return new Vec2(width/2,height/2);
}

void line(Vec2 p1, Vec2 p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}
void rect(Vec2 pos, Vec2 size) {
  rect(pos.x, pos.y, size.x, size.y);
}
void rect(Vec2 pos, Vec2 size, float r) {
  rect(pos.x, pos.y, size.x, size.y, r);
}
void rect(Vec2 pos, Vec2 size, float tl, float tr, float br, float bl) {
  rect(pos.x, pos.y, size.x, size.y, tl, tr, br, bl);
}
void ellipse(Vec2 pos, Vec2 size) {
  ellipse(pos.x, pos.y, size.x, size.y);
}
void circle(Vec2 pos, float size) {
  circle(pos.x, pos.y, size);
}
void point(Vec2 pos) {
  point(pos.x, pos.y);
}
void text(char c,Vec2 pos) {
  text(c,pos.x, pos.y);
}
void text(String text,Vec2 pos) {
  text(text,pos.x, pos.y);
}
void image(PImage img, Vec2 pos) {
  image(img, pos.x, pos.y);
}
void image(PImage img, Vec2 pos, Vec2 size) {
  image(img, pos.x, pos.y, size.x, size.y);
}
void arc(Vec2 pos, Vec2 size, float start, float stop) {
  arc(pos.x, pos.y, size.x, size.y, start, stop);
}
void arc(Vec2 pos, Vec2 size, float start, float stop, int mode) {
  arc(pos.x, pos.y, size.x, size.y, start, stop, mode);
}
void quad(Vec2 p1, Vec2 p2, Vec2 p3, Vec2 p4) {
  quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
}
void triangle(Vec2 p1, Vec2 p2, Vec2 p3) {
  triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
}
void square(Vec2 pos, float size) {
  square(pos.x, pos.y, size);
}
void vertex(Vec2 pos) {
  vertex(pos.x, pos.y);
}
void curveVertex(Vec2 pos) {
  curveVertex(pos.x, pos.y);
}
void bezierVertex(Vec2 p1, Vec2 p2, Vec2 anchor) {
  bezierVertex(p1.x, p1.y, p2.x, p2.y, anchor.x, anchor.y);
}
void bezier(Vec2 p1, Vec2 p2, Vec2 p3, Vec2 p4) {
  bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
}
void curve(Vec2 p1, Vec2 p2, Vec2 p3, Vec2 p4) {
  curve(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
}
void translate(Vec2 pos) {
  translate(pos.x, pos.y);
}
