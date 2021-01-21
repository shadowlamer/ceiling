class UI {
  
  private class Point {
      float x = -1.0;
      float y = -1.0;
  }
  
  private Point points[];
  private color colors[];
  private int numPoints;
  float x;
  float y;
  float w;
  float h;
  
  private final int depth = 50;
  private final int touchSize = 70;

  public UI(int numPoints, float x, float y, float w, float h) {
    this.numPoints = numPoints;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    points = new Point[numPoints];
    colors = new color[numPoints];
    for (int point = 0; point < numPoints; point ++) {
      points[point] = new Point();
    }
    background(0);
  }
  
  private void drawBackground() {
    noStroke();
    colorMode(RGB, 255);
    fill(255, 255);
    rect(this.x, this.y, this.w * 0.1, this.h);
    fill(0, 0);
    rect(this.w * 0.9, this.y, this.w * 0.1, this.h);
    drawColorRectangle(this.w * 0.1, this.y, this.w * 0.8, this.h);
  }
  
  private void drawColorRectangle(float x, float y, float w, float h) {
    float plotWidth = w / depth / 2;
    float plotHeight = h / depth;
  
    noStroke();
    colorMode(HSB, depth);
    for (int i = 0; i < depth; i++) {
      for (int j = 0; j < depth; j++) {
        fill(j, i, depth);
        rect(x + i * plotWidth, y + j * plotHeight, plotWidth, plotHeight);
        fill(j, depth, i);
        rect(x + w - (i + 1) * plotWidth, y + j * plotHeight, plotWidth, plotHeight);
      }
    }  
  }
  
  private void drawTouches() {
    colorMode(RGB, 255);
    for (int point = 0; point < numPoints; point++) {
      if (touches.length == 1 && isPointInArea(touches[0].x, touches[0].y)) {
        points[point].x = touches[0].x;  
        points[point].y = touches[0].y;  
      }
      if (touches.length > 1 && isPointInArea(touches[0].x, touches[0].y) && isPointInArea(touches[1].x, touches[1].y)) {
        float dx = (touches[0].x - touches[1].x) / numPoints; 
        float dy = (touches[0].y - touches[1].y) / numPoints; 
        points[point].x = touches[1].x + dx * point; 
        points[point].y = touches[1].y + dy * point; 
      }
      if (points[point].x >= 0 && points[point].y >= 0) {
        fill(0, 70);
        ellipse(points[point].x, points[point].y, touchSize * displayDensity, touchSize * displayDensity);
      }
    }
  }
  
  private boolean isPointInArea(float x, float y) {
    return (x >= this.x) && (x < this.x + this.w) && (y >= this.y) && (y < this.y + this.h);
  }
  
  public color[] getColors() {
    return colors;
  }
  
  public void draw() {
    drawBackground();
    for (int point = 0; point < numPoints; point++) {
      colors[point] = get((int) points[point].x, (int) points[point].y);
    }    
   drawTouches();
  }   
}
