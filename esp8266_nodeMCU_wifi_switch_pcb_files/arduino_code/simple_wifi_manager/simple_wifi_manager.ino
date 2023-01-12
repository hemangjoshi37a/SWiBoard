#include <WiFiManager.h>

void setup() {
  Serial.begin(115200);
  WiFiManager wm;
  bool res;
  res = wm.autoConnect();

  if (!res) {
    Serial.println("Failed to connect");
  }
  else {
    Serial.println("connected...yeey :)");
  }

}

void loop() {
}
