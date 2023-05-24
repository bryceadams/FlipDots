void lines() {
  int linesCount = int(map(potentBValInt, 0, 1023, 3, 14));

  virtualDisplay.beginDraw();
  virtualDisplay.background(0);
  virtualDisplay.stroke(255);
  virtualDisplay.noFill();

virtualDisplay.translate(virtualDisplay.width / 2, virtualDisplay.height / 2);
for (int i = 0; i < linesCount; i++) {
    virtualDisplay.rotate(frameCount / 100.0);
    virtualDisplay.line(-virtualDisplay.width, 0, virtualDisplay.width, 0);
}

  virtualDisplay.endDraw();
}