PGraphics virtualDisplay;

/**
 * Create vitural canvas to draw onto
 */
void stages_setup() {
  // Create virtual stages
  virtualDisplay = createGraphics(
    config_canvasW,
    config_canvasH,
    P2D
  );
}


/**
 * Process image.
 */
void stage_process() {
  virtualDisplay.filter(THRESHOLD, 0.5);
  virtualDisplay.loadPixels();
  
  for (int i = 0; i < panels.length; i++) {
    panels[i].process();
  }
}
