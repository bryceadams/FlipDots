void custom() {
  //simpleText();
  //bouncingBall();
  //blobs();
  snake();
}

void simpleText() {
  virtualDisplay.background(0);
  virtualDisplay.fill(255);
  virtualDisplay.noStroke();

  virtualDisplay.textFont(FlipDotFont_pixel);
  virtualDisplay.textLeading(7);
  virtualDisplay.textAlign(CENTER, CENTER);
  virtualDisplay.text("Hello!", virtualDisplay.width / 2, virtualDisplay.height / 3);
}

// Ball
float x, y, xSpeed, ySpeed, ballRadius;

// Blobs
int numBlobs = 10;
Blob[] blobs = new Blob[numBlobs];
int scaleFactor = 20;

// Snake
Snake snake;
int counter = 0;
int updateInterval = 3; // Controls how often the snake updates its position

void example_setup() {
  ballRadius = 3;
  x = virtualDisplay.width/2;
  y = virtualDisplay.height/2;
  xSpeed = 1;
  ySpeed = 1;
  
  for (int i = 0; i < numBlobs; i++) {
    float x = random(virtualDisplay.width);
    float y = random(virtualDisplay.height);
    float size = random(3, 5);
    color c = color(255, 255, 255);
    float xSpeed = random(-1, 1);
    float ySpeed = random(-1, 1);
    blobs[i] = new Blob(x, y, size, c, xSpeed, ySpeed);
  }
  
  snake = new Snake(10);
  counter = 0;
}


void bouncingBall() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  virtualDisplay.fill(255);
  virtualDisplay.noStroke();
  virtualDisplay.ellipse(x, y, ballRadius*2, ballRadius*2);
  virtualDisplay.endDraw();
  
  image(virtualDisplay, 0, 0);

  x += xSpeed;
  y += ySpeed;

  if (x > virtualDisplay.width - ballRadius || x < ballRadius) {
    xSpeed = -xSpeed;
  }
  if (y > virtualDisplay.height - ballRadius || y < ballRadius) {
    ySpeed = -ySpeed;
  }
}


void blobs() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  
  for (Blob b : blobs) {
    b.update();
    b.display(virtualDisplay);
  }
  
  virtualDisplay.endDraw();
}


void snake() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  
  if (counter % updateInterval == 0) {
    snake.update();
  }
  counter++;
  
  snake.display(virtualDisplay);
  virtualDisplay.endDraw();
}


class Blob {
  float x, y, size;
  color c;
  float xSpeed, ySpeed;

  Blob(float x, float y, float size, color c, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.c = c;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }

  void update() {
    x += xSpeed;
    y += ySpeed;

    if (x < 0 || x > virtualDisplay.width) xSpeed = -xSpeed;
    if (y < 0 || y > virtualDisplay.height) ySpeed = -ySpeed;
  }

  void display(PGraphics pg) {
    pg.fill(c);
    pg.noStroke();
    pg.ellipse(x, y, size, size);
  }
}

class Snake {
  ArrayList<PVector> body;
  PVector velocity;

  Snake(int length) {
    body = new ArrayList<PVector>();
    for (int i = 0; i < length; i++) {
      body.add(new PVector(virtualDisplay.width / 2, virtualDisplay.height / 2));
    }
    velocity = new PVector(1, 0);
  }

  void changeDirection(char direction) {
    switch (direction) {
      case 'U':
        velocity = new PVector(0, -1);
        break;
      case 'D':
        velocity = new PVector(0, 1);
        break;
      case 'L':
        velocity = new PVector(-1, 0);
        break;
      case 'R':
        velocity = new PVector(1, 0);
        break;
    }
  }

  void update() {
    PVector newPos = PVector.add(body.get(0), velocity);
    newPos.x = (newPos.x + virtualDisplay.width) % virtualDisplay.width;
    newPos.y = (newPos.y + virtualDisplay.height) % virtualDisplay.height;
    body.add(0, newPos);
    body.remove(body.size() - 1);
  }

  void display(PGraphics pg) {
    pg.fill(255);
    pg.noStroke();
    for (PVector segment : body) {
      pg.rect(segment.x, segment.y, 1, 1);
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    snake.changeDirection('U');
  } else if (keyCode == DOWN) {
    snake.changeDirection('D');
  } else if (keyCode == LEFT) {
    snake.changeDirection('L');
  } else if (keyCode == RIGHT) {
    snake.changeDirection('R');
  }
}
