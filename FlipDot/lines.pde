void lines() {
  int linesCount = int(map(potentBValInt, 0, 500, 3, 14));
  float linesSpeed = map(potentCValInt, 0, 500, 180, 30);

  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  virtualDisplay.stroke(255);
  virtualDisplay.noFill();

virtualDisplay.translate(virtualDisplay.width / 2, virtualDisplay.height / 2);
for (int i = 0; i < linesCount; i++) {
    virtualDisplay.rotate(frameCount / linesSpeed);
    virtualDisplay.line(-virtualDisplay.width, 0, virtualDisplay.width, 0);
}

  virtualDisplay.endDraw();
}