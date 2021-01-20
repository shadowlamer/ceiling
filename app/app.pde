import android.os.Bundle;
import android.view.WindowManager;
import android.app.Activity;
import hypermedia.net.*; 

private final String multicastGroup = "224.0.0.180";
private final int udpPort = 1515;
private final int numLeds = 14;

private UDP udptx;
private UI ui;



private byte colors[] = new byte[numLeds * 3];

void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  getActivity().getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}

void setup()
{
  fullScreen(P2D);
  udptx = new UDP(this, udpPort, multicastGroup);
  ui = new UI();
}


void draw() {   
    ui.draw();

    if (touches.length == 1) {
      colorMode(RGB, 255);
      float d = (100 + 100 * touches[0].area) * displayDensity;
      fill(0, 128);
      ellipse(touches[0].x, touches[0].y, d, d);
      colorMode(RGB, 64);
      color c = get((int) touches[0].x, (int)  touches[0].y);  
      for (int led = 0; led < numLeds; led++) {
          colors[led * 3 + 0] = (byte) red(c);
          colors[led * 3 + 1] = (byte) green(c);
          colors[led * 3 + 2] = (byte) blue(c);
      }
    }

    if (touches.length > 1) {
      colorMode(RGB, 255);
      for (int i = 0; i < 2; i++) {
        float d = (100 + 100 * touches[i].area) * displayDensity; 
        fill(0, 128);
        ellipse(touches[i].x, touches[i].y, d, d);
        fill(255, 0, 0);
      } 

      float dx = (touches[0].x - touches[1].x) / numLeds; 
      float dy = (touches[0].y - touches[1].y) / numLeds; 

      colorMode(RGB, 64);
      for (int led = 0; led < numLeds; led++) {
          float px = touches[1].x + dx * led; 
          float py = touches[1].y + dy * led; 
          color c = get((int) px, (int) py);  
          colors[led * 3 + 0] = (byte) red(c);
          colors[led * 3 + 1] = (byte) green(c);
          colors[led * 3 + 2] = (byte) blue(c);
      }

  }

}


void touchStarted() {
}

void touchMoved() {
}

void touchEnded() { 
//  System.out.println(colors);
  udptx.send(colors);
        for (int led = 0; led < numLeds; led++) {
          System.out.println(colors[led * 3 + 0]);
          System.out.println(colors[led * 3 + 1]);
          System.out.println(colors[led * 3 + 2]);
        }
 }

void onStop() {
  super.onStop();
  getActivity().finish();
  System.exit(0);
}
