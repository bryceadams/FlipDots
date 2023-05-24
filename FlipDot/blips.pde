void blips() {
  int potentB = int(map(potentBValInt, 0, 500, 3, 10));

  // Blips config
  int blips_count = potentB;
  float blips_max_speed = 150.0;
  float blips_weight = 40.0;
  
  // Draw blips
  for (int i = 0; i < blips_count; i++) {
    float phaseShift = noise(i) * blips_max_speed;
    float phase = (frameCount % phaseShift) / phaseShift;
    float flatPhase = floor(frameCount / phaseShift);
  
    virtualDisplay.strokeWeight(phaseShift / blips_weight);
    virtualDisplay.ellipse(
      noise(i, 1, flatPhase) * virtualDisplay.width,
      noise(i, 2, flatPhase) * virtualDisplay.height,
      phase * (virtualDisplay.width * 2),
      phase * (virtualDisplay.width * 2)
    );
  }
}