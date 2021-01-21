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
  ui = new UI(numLeds, 0, height * 0.1, width, height * 0.7);
}


void draw() {   
    ui.draw();
}


void touchStarted() {
}

void touchMoved() {
}

void touchEnded() {
  colorMode(RGB, 64);
  color uiColors[] = ui.getColors();
  for (int led = 0; led < numLeds; led++) {
      color c = uiColors[led];
      colors[led * 3 + 0] = (byte) red(c);
      colors[led * 3 + 1] = (byte) green(c);
      colors[led * 3 + 2] = (byte) blue(c);
  }
  udptx.send(colors);
 }

void onStop() {
  super.onStop();
  getActivity().finish();
  System.exit(0);
}
