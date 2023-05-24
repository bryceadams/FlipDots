int animationsCount = 11;

int getAnimationIndex() {
  int animationIndex = ceil(map(potentAValInt, 0, 500, 0, animationsCount));
  //animationIndex = 1;
  return animationIndex;
}

void custom() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  virtualDisplay.stroke(255);
  virtualDisplay.noFill();

  // create an array of animations and a switch/case to call them based on animationIndex
  int animationIndex = getAnimationIndex();
  switch (animationIndex) {
    case 1:
      simpleText();
      break;
    case 2:
      counterText();
      break;
    case 3:
      potentText();
      break;
    case 4:
      balls();
      break;
    case 5:
      lines();
      break;
    case 6:
      blips();
      break;
    case 7:
      stars();
      break;
    case 8:
      tunnel();
      break;
    case 9:
      clouds();
      break;
    case 10:
      snake();
      break;
  }
  
  virtualDisplay.endDraw();
}

void simpleText() {
  virtualDisplay.background(0);
  virtualDisplay.fill(255);
  virtualDisplay.noStroke();

  virtualDisplay.textFont(FlipDotFont_pixel);
  virtualDisplay.textLeading(7);
  virtualDisplay.textAlign(CENTER, CENTER);

  // array of text strings that are under 8 characters each and will fit on the display
  String[] textStrings = {
    "Hello!",
    "I'm a",
    "FlipDot",
    "Display",
    "I'm",
    "controlled",
    "by",
    "a",
    "Potentiometer",
    "and",
    "an",
    "Arduino",
    "Uno",
    "I'm",
    "made",
    "by",
    "Marius",
    "Watz",
    "and",
    "you",
    "can",
    "find",
    "me",
    "on",
    "Github",
    "at",
    "github.com/mariuswatz/FlipDotArduino",
    "I'm",
    "a",
    "work",
    "in",
    "progress",
    "so",
    "please",
    "be",
    "patient",
    "with",
    "me",
    "I",
    "will",
    "be",
    "better",
    "soon",
    "I",
    "promise",
    ":-)"
  };

  // get the length of the array and mapped potent value (which string to output below)
  int textStringsLength = textStrings.length;
  int mappedPotentValInt = int(map(potentBValInt, 0, 500, 0, textStringsLength));

  virtualDisplay.text(textStrings[mappedPotentValInt], virtualDisplay.width / 2, virtualDisplay.height / 3);
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
  virtualDisplay.text(potentBValInt, virtualDisplay.width / 2, virtualDisplay.height / 3);
}

// Ball
ArrayList<Ball> balls;

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
int potentBValIntPrevious = 50;

// Face
float mouthState;
float mouthStateChangeSpeed = 0.1;
int mouthDirection = 1;

void example_setup() {  
  // balls
  balls = new ArrayList<Ball>();
  for (int i = 0; i < 10; i++) {
    float x = random(virtualDisplay.width);
    float y = random(virtualDisplay.height);
    float vx = random(-1, 1);
    float vy = random(-1, 1);
    float radius = random(1, 2);
    balls.add(new Ball(x, y, vx, vy, radius));
  }
  
  // blobs
  for (int i = 0; i < numBlobs; i++) {
    float x = random(virtualDisplay.width);
    float y = random(virtualDisplay.height);
    float size = random(3, 5);
    color c = color(255, 255, 255);
    float xSpeed = random(-1, 1);
    float ySpeed = random(-1, 1);
    blobs[i] = new Blob(x, y, size, c, xSpeed, ySpeed);
  }
  
  // snake
  snake = new Snake(10);
  counter = 0;
  
  // stars
  stars = new ArrayList<Star>();
  int mappedPotentValInt = int(map(potentBValInt, 0, 500, 30, 250));
  for (int i = 0; i < mappedPotentValInt; i++) {
    stars.add(new Star());
  }

  // face
  mouthState = 0;
}

void balls() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);

  float speedFactor = map(potentBValInt, 0, 500, 0.1, 2);

  for (Ball ball : balls) {
    ball.vx *= speedFactor;
    ball.vy *= speedFactor;
    ball.update();
    ball.vx /= speedFactor;
    ball.vy /= speedFactor;
    ball.display();
  }

  virtualDisplay.endDraw();
}

void blobs() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  
  for (Blob b : blobs) {    
    b.xSpeed = int(map(potentBValInt, 0, 500, -2, 2));
    b.ySpeed = int(map(potentBValInt, 0, 500, -2, 2));

    b.update();
    b.display(virtualDisplay);
  }
  
  virtualDisplay.endDraw();
}


void snake() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  
  snake.changeDirection(potentBValInt);
  
  if (counter % updateInterval == 0) {
    snake.update();
  }
  counter++;
  
  snake.display(virtualDisplay);
  virtualDisplay.endDraw();
}

void stars() {
   int mappedPotentValInt = int(map(potentBValInt, 0, 500, 0, 200));
  
  // Check if potentValInt has changed
  if (mappedPotentValInt != potentBValIntPrevious) {
    int difference = mappedPotentValInt - potentBValIntPrevious;
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
    potentBValIntPrevious = mappedPotentValInt;
  }

  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  for (Star star : stars) {
    star.update();
    star.display(virtualDisplay);
  }
  virtualDisplay.endDraw();
}

void face() {
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  virtualDisplay.translate(virtualDisplay.width / 2, virtualDisplay.height / 2);
  virtualDisplay.stroke(255);
  virtualDisplay.strokeWeight(0.5);
  virtualDisplay.noFill();
  drawSmileyFace(virtualDisplay, mouthDirection);
  mouthState += mouthStateChangeSpeed * mouthDirection;

  counter++;
  if (counter % 10 == 0) {
    mouthDirection *= -1;
  }

  virtualDisplay.endDraw();
}

void drawSmileyFace(PGraphics pg, int mouthDir) {
  // Draw head
  pg.ellipse(0, 0, 12, 12);

  // Draw eyes
  pg.ellipse(-2, -2, 2, 1);
  pg.ellipse(2, -2, 2, 1);

  // Draw mouth
  if (mouthDir == 1) {
    pg.arc(0, 2, 8, 3, 0.2, PI - 0.2);
  } else {
    pg.arc(0, 3, 8, 3, PI + 0.2, TWO_PI - 0.2);
  }
}

class Ball {
  float x, y;
  float vx, vy;
  float radius;

  Ball(float x, float y, float vx, float vy, float radius) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.radius = radius;
  }

  void update() {
    x += vx;
    y += vy;

    if (x < radius) {
      x = radius;
      vx = -vx;
    } else if (x > virtualDisplay.width - radius) {
      x = virtualDisplay.width - radius;
      vx = -vx;
    }
    
    if (y < radius) {
      y = radius;
      vy = -vy;
    } else if (y > virtualDisplay.height - radius) {
      y = virtualDisplay.height - radius;
      vy = -vy;
    }
  }

  void display() {
    virtualDisplay.ellipse(x, y, radius * 2, radius * 2);
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
