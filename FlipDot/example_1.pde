void custom() {
  //simpleText();
  //bouncingBall();
  //blobs();
  //snake();
  //stars();
  stick();

  //counterText();
  //potentText();
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

int count = 0;

void counterText() {
  count = count + 1;
  virtualDisplay.background(0);
  virtualDisplay.fill(255);
  virtualDisplay.noStroke();

  virtualDisplay.textFont(FlipDotFont_pixel);
  virtualDisplay.textLeading(7);
  virtualDisplay.textAlign(CENTER, CENTER);
  virtualDisplay.text(count, virtualDisplay.width / 2, virtualDisplay.height / 3);
}

void potentText() {
  count = count + 1;
  virtualDisplay.background(0);
  virtualDisplay.fill(255);
  virtualDisplay.noStroke();

  virtualDisplay.textFont(FlipDotFont_pixel);
  virtualDisplay.textLeading(7);
  virtualDisplay.textAlign(CENTER, CENTER);
  virtualDisplay.text(potentValInt, virtualDisplay.width / 2, virtualDisplay.height / 3);
}

// Ball
float speedFactor = 5.0; // Change this value to control the ball speed
Ball ball;
float potentValPrev = 0;

// Blobs
int numBlobs = 10;
Blob[] blobs = new Blob[numBlobs];
int scaleFactor = 20;

// Snake
Snake snake;
int counter = 0;
int updateInterval = 3; // Controls how often the snake updates its position

// Stars
ArrayList<Star> stars;
int numStars = 50;
int prevPotentValInt = 50;

// Stick
float angle;
float angleSpeed = 0.1;

void example_setup() {
  ball = new Ball(speedFactor);
  
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
  
  // stars
  stars = new ArrayList<Star>();
  int mappedPotentValInt = int(map(potentValInt, 0, 500, 0, 200));
  for (int i = 0; i < mappedPotentValInt; i++) {
    stars.add(new Star());
  }

  // stick
  angle = 0;
}

void bouncingBall() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  
  if (potentValInt != potentValPrev) {
    potentValPrev = potentValInt;
    ball.changeSpeed(potentValInt / 100);
  }
  
  ball.update();
  ball.display(virtualDisplay);
  virtualDisplay.endDraw();
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
  
  snake.changeDirection(potentValInt);
  
  if (counter % updateInterval == 0) {
    snake.update();
  }
  counter++;
  
  snake.display(virtualDisplay);
  virtualDisplay.endDraw();
}

void stars() {
   int mappedPotentValInt = int(map(potentValInt, 0, 500, 0, 200));
  
  // Check if potentValInt has changed
  if (mappedPotentValInt != prevPotentValInt) {
    int difference = mappedPotentValInt - prevPotentValInt;
    if (difference > 0) {
      // Add stars
      for (int i = 0; i < difference; i++) {
        stars.add(new Star());
      }
    } else {
      // Remove stars
      for (int i = 0; i < -difference; i++) {
        if (stars.size() > 0) {
          stars.remove(0);
        }
      }
    }
    prevPotentValInt = mappedPotentValInt;
  }

  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  for (Star star : stars) {
    star.update();
    star.display(virtualDisplay);
  }
  virtualDisplay.endDraw();
}

void stick() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  virtualDisplay.translate(virtualDisplay.width / 2, virtualDisplay.height - 1);
  virtualDisplay.stroke(255);
  virtualDisplay.scale(0.5);
  drawStickFigure(virtualDisplay);
  angle += angleSpeed;
  virtualDisplay.endDraw();
}


void drawStickFigure(PGraphics pg) {
  float legLength = 5;
  float armLength = 3;

  // Draw head
  pg.ellipse(0, -10, 2, 2);

  // Draw body
  pg.line(0, -9, 0, -4);

  // Draw arms
  float armAngle = sin(angle) * 15;
  pg.line(0, -7, armLength * cos(radians(180 + armAngle)), -7 + armLength * sin(radians(180 + armAngle)));
  pg.line(0, -7, armLength * cos(radians(180 - armAngle)), -7 + armLength * sin(radians(180 - armAngle)));

  // Draw legs
  float legAngle = sin(angle) * 15;
  pg.line(0, -4, legLength * cos(radians(legAngle)), -4 + legLength * sin(radians(legAngle)));
  pg.line(0, -4, legLength * cos(radians(-legAngle)), -4 + legLength * sin(radians(-legAngle)));
}

class Ball {
  PVector position;
  PVector velocity;
  float radius;

  Ball(float speedFactor) {
    position = new PVector(virtualDisplay.width / 2, virtualDisplay.height / 2);
    velocity = new PVector(speedFactor / 2, speedFactor / 2);
    radius = 2;
  }
  
  void changeSpeed(float speedFactor) {
    velocity = new PVector(speedFactor / 2, speedFactor / 2);
  }

  void update() {
    position.add(velocity);

    if (position.x - radius < 0 || position.x + radius > virtualDisplay.width) {
      velocity.x = -velocity.x;
    }

    if (position.y - radius < 0 || position.y + radius > virtualDisplay.height) {
      velocity.y = -velocity.y;
    }
  }

  void display(PGraphics pg) {
    pg.fill(255);
    pg.noStroke();
    pg.ellipse(position.x, position.y, radius * 2, radius * 2);
  }
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

  void changeDirection(int direction) {
    if (direction > 400) {
      // down
      velocity = new PVector(0, 1);
    } else if (direction > 250) {
      // right
      velocity = new PVector(1, 0);
    } else if (direction > 150) {
      // up
      velocity = new PVector(0, -1);
    } else {
      // left
      velocity = new PVector(-1, 0);
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

class Star {
  PVector position;
  float speed;

  Star() {
    position = new PVector(random(virtualDisplay.width), random(virtualDisplay.height));
    speed = random(0.1, 1);
  }

  void update() {
    position.y += speed;
    if (position.y > virtualDisplay.height) {
      position.y = 0;
      position.x = random(virtualDisplay.width);
      speed = random(0.1, 1);
    }
  }

  void display(PGraphics pg) {
    pg.fill(255);
    pg.noStroke();
    pg.rect(position.x, position.y, 1, 1);
  }
}

void keyPressed() {
  if (keyCode == UP) {
    potentValInt = 300;
    //ball.changeSpeed(3);
    //snake.changeDirection('U');
  } else if (keyCode == DOWN) {
    potentValInt = 100;
        //ball.changeSpeed(1);

    //snake.changeDirection('D');
  } else if (keyCode == LEFT) {
    //snake.changeDirection('L');
  } else if (keyCode == RIGHT) {
    //snake.changeDirection('R');
  }
}
