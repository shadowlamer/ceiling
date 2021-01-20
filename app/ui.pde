class UI {
    
  private final int maxSat = 100;
  private final int maxHue = 100;

  public UI() {
    background(0);
   }
  
  public void draw() {
    int plotWidth = width / maxSat;
    int plotHeight = height / maxHue;
    noStroke();
    colorMode(HSB, 100);
    for (int i = 0; i < 100; i++) {
      for (int j = 0; j < 100; j++) {
        fill(j, i * 2, 200 - i * 2);
        rect(i * plotWidth, j * plotHeight, plotWidth, plotHeight);
      }
    }  
  }   
}
