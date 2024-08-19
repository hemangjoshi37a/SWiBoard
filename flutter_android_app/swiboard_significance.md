# SWiBoard - A Tasmota MQTT5 Flutter Firebase App

Your Own WiFi Switch Board

## The significance for SWiBoard App

### Why App when I have web access to tasmota device?

- For the most use cases one might not be under the same wifi network. And need remote access to the device from internet.

### I can easily forward port from my local network and can access it from internet. Then why App?

- One might not have access to static IP considering where one is living or may be very costly to have static IP. So we need MQTT5 for connecting device with internet.

### There are already many apps available on playstore for tasmota then why SWiBoard?

- Most if not all of them only use web socket to connect to tasmota device and not MQTT, and that's why they are not suitable for use from internet connection. Also configuring all the apps with tasmota device is quite tricky in some cases. But in SWiBoard you need to onyl enter the device topic of your tasmota device and it automatically configures your app and adds the device and UI componets of the configures device like switches and sliders and color selector etc.

- Also nice to have is we are using google firebase databse to store the configurations of the users so that if they somehow uninstall the app or change the device that all they need to do is just install the app and login with google account to get all the configuration back and don't need to reconfigure all the devices.

## Also in near future we are trying to give as many options as possible in the app to configure the device using MQTT5 to configure from the internet

## Here is the link to The app : [SWiBoard :Tasmota MQTT Control](https://play.google.com/store/apps/details?id=in.hjlabs.swiboard)
