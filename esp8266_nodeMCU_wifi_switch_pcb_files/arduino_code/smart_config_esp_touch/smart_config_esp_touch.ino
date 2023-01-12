#include <ESP8266WiFi.h>;

void setup() {
  Serial.begin(115200);
  delay(10);

  WiFi.mode(WIFI_AP_STA);
  delay(500);

  WiFi.beginSmartConfig();

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    Serial.println(WiFi.smartConfigDone());
  }

  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

int value = 0;

void loop() {

}
