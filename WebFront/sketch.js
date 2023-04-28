function drawArrow(x, y, angle = 0, s = 200) {
  push();
  translate(x, y);
  scale(s / 200);
  rotate(angle);
  beginShape();
  vertex(0, -50);
  vertex(100, -50);
  vertex(100, -100);
  vertex(200, 0);
  vertex(100, 100);
  vertex(100, 50);
  vertex(0, 50);
  endShape(CLOSE);
  pop();
}

let url = "/IrairaBou";
function POST(direction) {
  data = { direction: direction };
  fetch(url, {
    method: "POST",
    mode: "cors",
    headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });
}

class ArrowButton {
  static COOLDOWN_TIME = 10;
  static arrowSize;
  static space;
  static update() {
    if (width < height) {
      ArrowButton.arrowSize = width / 4;
    } else {
      ArrowButton.arrowSize = height / 4;
    }
    ArrowButton.space = ArrowButton.arrowSize / 3;
  }
  constructor(direction, postMessage) {
    this.direction = direction;
    this.postMessage = postMessage;
    this.cooldown = 0;
  }
  Draw() {
    push();
    this.cooldown--;
    if(this.cooldown > 0) fill(200);
    else fill(256, 50, 0);
    translate(width / 2, height / 2);
    rotate(this.direction);
    drawArrow(ArrowButton.space, 0, 0, ArrowButton.arrowSize);
    pop();
  }
  //めっちゃ雑に作ったけど動いてるから良いでしょｗ(いじらなくていいよ)
  mousePressedEvent() {
    if(this.cooldown > 0) return;
    let CollisionWidth = ArrowButton.arrowSize / 3.3;
    let CollisionHeight = ArrowButton.arrowSize;
    let vec = createVector(mouseY - height / 2,mouseX - width / 2);
    vec.rotate(this.direction);
    if (-CollisionWidth < vec.x && vec.x < CollisionWidth && ArrowButton.space < vec.y && vec.y < CollisionHeight + ArrowButton.space) {
      POST(this.postMessage);
      this.cooldown = ArrowButton.COOLDOWN_TIME;
    }
  }
}

let arrows;

function setup() {
  createCanvas(windowWidth, windowHeight);
  arrows = [new ArrowButton(0, "right"),
  new ArrowButton(PI / 2, "down"),
  new ArrowButton(PI, "left"),
  new ArrowButton(-PI / 2, "up")];
}
function draw() {
  background(250);
  width = windowWidth;
  height = windowHeight;
  ArrowButton.update();
  for (let arrow of arrows) {
    arrow.Draw();
  }
}

function mousePressed() {
  for (let arrow of arrows) {
    arrow.mousePressedEvent();
  }
}
