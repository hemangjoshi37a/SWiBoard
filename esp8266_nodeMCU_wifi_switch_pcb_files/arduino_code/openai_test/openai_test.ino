#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <ESP8266HTTPUpdateServer.h>
#include <WiFiManager.h>

const char* host = "esp8266-webupdate";

ESP8266WebServer httpServer(80);
ESP8266HTTPUpdateServer httpUpdater;

void setup() {
  Serial.begin(115200);
  Serial.println();
  Serial.println();
  Serial.println("Booting Sketch...");

  WiFiManager wifiManager;
  wifiManager.autoConnect("AutoConnectAP");

  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  if (MDNS.begin(host)) {
    Serial.println("MDNS responder started");
  }

  httpUpdater.setup(&httpServer);
  httpServer.begin();

  MDNS.addService("http", "tcp", 80);
  Serial.printf("HTTPUpdateServer ready! Open http://%s.local/update in your browser", host);
}

void loop() {
  httpServer.handleClient();
}
