void clouds() {
    // potent b multiples speed
    float potentB = map(potentBValInt, 0, 500, 1, 2);

    float noiseScale = 0.03;
    float threshold = 0.5;
    float speedX = 0.004 * potentB;
    float speedY = 0.005 * potentB;
    float speedZ = 0.002 * potentB;
    float noiseLevel = 2.0;

    virtualDisplay.loadPixels();
    for (int i = 0; i < virtualDisplay.pixels.length; i++) {
      float x = (i / 1) % virtualDisplay.width;
      float y = (i / 1) / virtualDisplay.width;
      float n = 0.0;
      for (int j = 0; j < noiseLevel; j += 1) {
        float level = pow(2, j);
        n += noise(
          (x * noiseScale + frameCount * speedX) * level,
          (y * noiseScale + frameCount * speedY) * level,
          frameCount * speedZ * level
        );
      }
      n /= noiseLevel;
      if (n > threshold) {
        virtualDisplay.pixels[i] = 255;
      }
      else {
        virtualDisplay.pixels[i] = 0;
      }
    }
    virtualDisplay.updatePixels();
}