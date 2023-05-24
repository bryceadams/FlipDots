/**
 * FlipDot Controller
 *
 * This Processing sketch is to control FlipDot panels from AlfaZeta.
 * It uses a virtual display you can draw and animate on that then gets cast to your FlipDot display panels.
 *
 * If you don't have a FlipDot display you can still use this software as a FlipDot simulator. Just set `config_cast = false`
 *
 * @author Owen McAteer
 * @url https://github.com/owenmcateer/FlipDots
 * @socials https://twitter.com/motus_art
 * @socials https://instagram.com/motus_art
 *
 * Required libraries
 * - processing.net | Processing foundation
 * - processing.serial | Processing foundation
 * - websockets | Lasse Steenbock Vestergaard | (Only for realtime Crypo feed example)
 */
import processing.serial.*;
Serial arduinoPort;  // Create object from Serial class

boolean onPi = false;

void settings() {
  if (args != null) {
    onPi = true;
  }

  size(onPi ? 10 : 1080, onPi ? 5 : 720, P2D);
}

void setup() {
  frameRate(config_fps);
  colorMode(RGB, 255, 255, 255, 1);
  
  if (onPi) {
    // try connect to /dev/ttyACM0, but if that doesn't work, use /dev/ttyACM1
    try {
      arduinoPort = new Serial(this, "/dev/ttyACM0", 9600);
    } catch (Exception e) {
      arduinoPort = new Serial(this, "/dev/ttyACM1", 9600);
    }

    delay(1000); //GLV added Wait for Arduino to reset
  }

  // Core setup functions
  cast_setup();
  config_setup();
  stages_setup();
  
  if (! onPi) {
    ui_setup();
  }
  
  example_setup();

  // Scene setup
  //crypto_ticker_setup();
}


/**
 * Draw tick
 */
void draw() {
  background(59);
  
  if (onPi) {  
    read_arduino_data();
  }
  
  // 3D test
  virtual3D.beginDraw();
  virtual3D.background(0);
  virtual3D.translate(virtual3D.width / 2, virtual3D.height / 2);
  virtual3D.rotateX(frameCount / 20.0);
  virtual3D.rotateY(frameCount / 20.0);
  virtual3D.stroke(255);
  virtual3D.strokeWeight(2);
  virtual3D.noFill();
  virtual3D.box(11);
  virtual3D.endDraw();
  // End 3D test

  // Between beginDraw/endDraw you can draw whatever you want to virtualDisplay(PGraphics)
  virtualDisplay.beginDraw();
  virtualDisplay.background(0);

  // Blips
  //example_blips();
  //example_anim();
  custom();

  // Games
  // games_tetris();

  // Crypto ticker
  //crypto_ticker();

  // End drawing
  virtualDisplay.endDraw();
  
  if (onPi) {
      println(round(frameRate) + " fps (target: " + config_fps + "fps)");
  }

  // Preview frame render
  if (! onPi) {
    ui_render();
  }

  // Process frame
  stage_process();

  // Cast to display
  cast_broadcast();
}
