//Old code

color GenerateRainbow() {
  return color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
}

class FireWork implements IDrawable {
  float x = random(50,width-50);
  float y = height + random (0, 200);
  float ax = random(-10,10);
  float ay = -random(20,50);
  float size = 20;
  color col = GenerateRainbow();
  int remain_time = (int)random(65,90);
  float Decel = 0.95;
  float Acc = -0.2;
  ArrayList<Particle> particles = null;
  float delay = random(0,100);
  void Draw() {
    if(delay>0){
      delay--;
      return;
    }
    push();
    if (particles == null) {
      remain_time--;
      fill(col);
      noStroke();
      ellipse(x, y, size, size);
      y += ay;
      ay = ay * Decel + (1 - Decel) * Acc;
      x += ax;
      ax = ax * Decel;
      if (remain_time < 0) {
        int layer_count = (int)random(5, 10);
        float m_speed = random(0.2, 2.5);
        particles = new ArrayList<Particle>();
        for (int t = 0; t <= layer_count; t++ ) {
          int particle_count = (int)random(t*5 + 1, t*10);
          for (int i = 0; i < particle_count; i++ ) {
            float temp = PI * 2/particle_count * i + random(0, 0.1);
            float speed = m_speed * sin(PI / 2 * (float)t / layer_count) + random(0, 0.04);
            particles.add(new Particle(x, y, speed*sin(temp), speed * cos(temp), col));
          }
        }
      }
    } else {
      for (IDrawable o : particles) {
        o.Draw();
      }
    }
    pop();
  }
}
class Particle implements IDrawable {
  float x;
  float y;
  float ax;
  float ay;
  color col;
  int size = 10;
  int remain_time = disapper_time;
  static final int disapper_time = 200;
  static final float Decel = 0.97;
  static final float gravity = 1;
  static final float Particle_Start_Speed = 7;
  Particle(float x, float y, float ax, float ay, color col) {
    this.x = x;
    this.y = y;
    this.ax = Particle_Start_Speed * ax;
    this.ay = Particle_Start_Speed * ay;
    this.col = col;
  }
  void Draw() {
    remain_time--;
    if (remain_time > 0) {
      fill(col);
      noStroke();
      x += ax;
      y += ay;
      ax = Decel * ax;
      ay = Decel * ay + (1.0 - Decel) * gravity;
      float temp = (float)size * 
        (pow(((float)remain_time/disapper_time), 2));
      circle(x, y, temp);
    }
  }
}
