void tunnel() {
    // get potent b value
    float potentB = map(potentBValInt, 0, 1023, 1.2, 2.5);

    virtualDisplay.stroke(255);
    virtualDisplay.strokeWeight(1);
    virtualDisplay.noFill();
    virtualDisplay.rectMode(CENTER);
    virtualDisplay.translate(virtualDisplay.width / 2, virtualDisplay.height / 2);
    for (int i = 0; i < 8; i++) {
      virtualDisplay.rotate(frameCount / 100.0);
      float s = map((i / 4.0 + frameCount/90.0)%1, 0, 1, 0, virtualDisplay.width);
      s = pow(potentB, s);
      virtualDisplay.rect(0, 0, s, s);
    }
}