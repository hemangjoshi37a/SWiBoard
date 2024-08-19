// ignore_for_file: unnecessary_string_escapes, file_names
Map<String, Map<String, String>> mapOfGroupsOfSettings = {
  'Control Settings': controlSettingsCommandsJSON,
  'Management Settings': managementSettingsCommandsJSON,
  'WiFi Settings': wifiSettingsCommandsJSON,
  'MQTT Settings': mqttSettingsCommandsJSON,
  'Rules Settings': rulesSettingsCommandsJSON,
  'Timer Settings': timerSettingsCommandsJSON,
  'Sensors Settings': sensorsSettingsCommandsJSON,
  'Power Monitoring Settings': powerMonitoringSettingsCommandsJSON,
  'Light Settings': lightSettingsCommandsJSON,
  'Device Group Settings': deviceGroupSettingsCommandsJSON,
  'Set Options Settings': setOptionsSettingsCommandsJSON,
  'Tuya MCU Settings': tuyaMCUSettingsCommandsJSON,
  'Serial Bridge Settings': serialBridgeSettingsCommandsJSON,
  'RF Bridge Settings': rfBridgeSettingsCommandsJSON,
  'RF Transceiver Settings': rfTransceiverSettingsCommandsJSON,
  'RF Remote Settings': rfRemoteSettingsCommandsJSON,
  'Display Settings': displaySettingsCommandsJSON,
  'Dhutters Settings': shuttersSettingsCommandsJSON,
  'ZigBee Settings': zigbeeSettingsCommandsJSON,
  'ZigBee Debug Settings': zigbeeDebugSettingsCommandsJSON,
  'Bluetooth Settings': bluetoothSettingsCommandsJSON,
  'Stepper Motor Settings': stepperMotorSettingsCommandsJSON,
  'MP3 Player Settings': mp3PlayerSettingsCommandsJSON,
  'Thermostat Settings': thermostatSettingsCommandsJSON,
  'Domotics Settings': domoticsSettingsCommandsJSON,
  'Influx Settings': influxSettingsCommandsJSON,
  'KNX Settings': knxSettingsCommandsJSON,
  'ESP32 BLE Settings': esp32BLESettingsCommandsJSON,
  'BLE MI Sensor Settings': bleMIsensorSettingsCommandsJSON,
  'Camera Settings': cameraSettingsCommandsJSON,
  'Ethernet Settings': ethernetSettingsCommandsJSON,
};

Map<String, String> controlSettingsCommandsJSON = {
  'Backlog':
      'List of commands to be executed in sequence separated by; SeeUsing Backlogfor examples.',
  'Backlog0':
      'List of commands to be executed without any delay in sequence separated by; SeeUsing Backlogfor examples.',
  'BlinkCount':
      'Number of relay toggles (blinks)(does not control the status LED) 0= blink many times before restoring power state 1..32000= set number of blinks(default =10)',
  'BlinkTime':
      '2..3600set duration, in 0.1 second increments, toblinkaka toggle Power(does not control the status LED)',
  'Br':
      "Run the code from the console Example to download a file from a remote server into filesystem: br def urlfetch(url,file); if file==nil; import string; file=string.split(url,'/').pop(); end; var wc=webclient(); wc.begin(url); var st=wc.GET(); if st!=200 raise 'connection_error','status: '+str(st) end; st='Fetched '+str(wc.write_file(file)); print(url,st); wc.close(); return st; end; urlfetch('https://raw.githubusercontent.com/arendst/Tasmota/development/tasmota/zigbee/giex_water.zb')",
  'ButtonDebounce':
      'User control over button debounce timing 40..1000= set button debounce time in milliseconds(default =50)',
  'Buzzer':
      '0= stop active buzzer cycle <count>,<beep>,<silence>,<tune>=read more... 2,3= Beep twice with 300 milliseconds duration and 100 milliseconds pause 2,3,4= Beep twice with 300 milliseconds duration and 400 milliseconds pause 1,2,3,0xF54(0000 0000 0000 0000 0000 1111 0101 0100). Each1bit beeps for 200 milliseconds and each bounded0bit pauses for 300 milliseconds -1= infinite mode -2= follow LED mode',
  'BuzzerActive':
      'SetOption67			iFan03 Buzzer control 0= disable Sonoff iFan03 buzzer(default) 1= enable Sonoff iFan03 buzzer',
  'BuzzerPwm':
      'SetOption111			0=(default) 1= use frequency output for buzzer pin instead of on/off signal, for piezo buzzers',
  'DevGroupName<x>':
      '"0= clear device group <x> name and restart <value>= set device groupname and restart. If a device group name is not set for a group, the MQTT group topic (GroupTopic) is used (with the device group number appended for device group numbers > 1)."',
  'DevGroupSend<x>':
      """<item> = <value>[ ...]= send an update to device group <x>. The device group name must have been previously set with DevGroupName<x>. Multiple item/value pairs can be specified separated by a space. Spaces in<value>must be escaped with a backslash (\). The message sent is also processed on the local device as if it had been received from the network.  For items with numeric values,<value>can be specified as @<operator>[<operand>] to send a value after performing an operation on the current value. <operator> can be + (add), - (subtract), ^ (invert), & (bitwise AND) or | (bitwise OR). If <operand> is not specified, it defaults to 0xffffffff for the invert operator and 1 for other operators.  To indicate that an item should not be shared with the group until changed again, prefix the value with N.  3= Light fade (0 = Off, 1 = On) 4= Light speed (1..40) 5= Light brightness (0..255) 6= LightScheme 7= Light fixed color (0 = white (using CT channels), other values according toColor) 8= PWM dimmer low preset (0..255) 9= PWM dimmer high preset (0..255) 10= PWM dimmer power-on brightness (0..255) 128= Relay Power - bitmask with bits set for relays to be powered on. The number of relays can be specified in bits 24 - 31. If the number of relays is not specified, only relay 1 is set 129= No Status Share - DevGroupShare bitmask indicating which items should not be shared until changed. 192= Event - event name and arguments 193= Command - command and arguments 224= Light channels - comma separated list of brightness levels (0..255) for channels 1 - 5 (e.g. 255,128,0,0,0 will turn the red channel on at 100% and the green channel on at 50% on an RBG light) or hex color value (#RRGGBB, #RRGGBBWW, etc.)  Examples: DevGroupSend 5=90 128=1- send an update to set the light brightness to 90 and turn relay 1 on. DevGroupSend 193=Buzzer 2,3- send the Buzzer 2,3 command. DevGroupSend 6=@+ 5=@-10- set the next fixed color and decrease the brightness by 10. DevGroupSend 128=^- toggle all the relays. DevGroupSend 224=NFF0000- set the color to red locally and inform the group that light channel information is not to be shared until changed. DevGroupSend 129=@\|18- do not share light brightness or channel status until changed.'""",
  'DevGroupShare':
      '<in>,<out>= set incoming and outgoing shared items(default =0xffffffff,0xffffffff) <in> and <out> are bit masks where each mask is the sum of the values for the categories (listed below) to be shared. For example, to receive only power (1), light brightness (2) and light color (16) and send only power (1), enter the command DevGroupShare 19,1.  1= Power 2= Light brightness 4= Light fade/speed 8= Light scheme 16= Light color 32= Dimmer settings (presets) 64= Event',
  'DevGroupStatus<x>':
      'Show the status of device group <x> including a list of the currently known members.',
  'DevGroupTie<x>':
      '<relay>= Tie the relay to the device group <x>. Only applies when option 88 is enabled.',
  'FanSpeed':
      'Fan speed control(iFan02/iFan03 only) 0= turn fan OFF 1..3= set fan speed += increase fan speed -= decrease fan speed',
  'Interlock':
      'Relay interlock mode and group selection. 0= disable relay interlock for all relays (i.e., each relay is self-locking)(default) 1= set interlock mode for selected relays Add up to 8 relays in 1 to 4 interlock groups, each separated by a space. For example 1,2 3,4= Group Relay1 and Relay2 in group 1 and Relay3 and Relay4 in group 2 (note the space between the two groups) 1,2,3= group Relay1, Relay2 and Relay3 in a single interlock group 1 3 2,4= Relay1 is in group 1, Relay3 in group 2, Relay2 and Relay4 in group 3',
  'Json':
      'Input any command as valid JSON {<Tasmota commands>} example:cmnd/tasmota/json {"HSBColor":"360,100,100","Scheme": 1,"Dimmer": 10,"CT": 220}',
  'LedMask':
      'Set abitmaskspecifying which relays control the LED indicator.Read more... <bitmask>=bitwisevalue representing each relay. Values may be entered as either hexadecimal or decimal values (e.g., 0xFFFF = 65535). 0xFFFF(= 1111 1111 1111 1111) All relays control the power LED(default) LedStatemust be enabled (i.e.,!= 0) in order forLedMaskto take effect.',
  'LedPower':
      'LED power state as on or off 0= turn LED OFF and setLedState 0 1= turn LED ON and setLedState 8 2= toggle LED and setLedState 0 (UseBacklog LedPower 0; SetOption31 1to disable LED even when Wi-Fi or MQTT is not connected)',
  'LedPower<x>':
      'LED<x> power state control.Enabled only when LedLink(i) is configured 0= turn LED OFF and setLedState 0 1= turn LED ON and setLedState 0 2= toggle LED and setLedState 0',
  'LedState':
      'Manage LED state 0= disable use of LED as much as possible 1= show power state on LED (LED on when power on)(default)(inverted for Sonoff Touch/T1) 2= show MQTT subscriptions as a LED blink 3= show power state and MQTT subscriptions as a LED blink 4= show MQTT publications as a LED blink 5= show power state and MQTT publications as a LED blink 6= show all MQTT messages as a LED blink 7= show power state and MQTT messages as a LED blink 8= LED on when Wi-Fi and MQTT are connected. Cannotbe issued directly and is only activated whenLedPoweris switched from0to1due to a software function',
  'NoDelay':
      'Delay defined bySetOption34is omitted for any command in a backlog sequence following immediately afterNoDelay This must be used with care, and only for simple commands.Example',
  'Power0':
      'Control the power state simultaneously for all power outputs on the device 0/off= turn OFF 1/on= turn ON 2/toggle= if relay isONswitch toOFFand vice versa',
  'Power<x>':
      'Control the corresponding power state (1..8) (also restarts PulseTime)<x> 0/off/false= turn OFF 1/on/true= turn ON 2/toggle= if power state isONswitch toOFFand vice versa 3/blink= toggle power forBlinkCounttimes eachBlinkTimeduration (at the end ofblink, power state is returned to pre-blink state) 4/blinkoff= stop blink sequence and return power state to pre-blink state',
  'PowerOnState':
      'Control power state when the device ispowered up.More information 0/OFF= keep power(s) OFF after power up 1/ON= turn power(s) ON after power up 2/TOGGLE= toggle power(s) from last saved state 3= switch power(s) to their last saved state(default) 4= turn power(s) ON and disable further power control 5= after aPulseTimeperiod turn power(s) ON (acts as invertedPulseTimemode)',
  'PulseTime<x>':
      'Display the amount ofPulseTimeremaining on the corresponding Relay<x>(x =0..31) <value>Set the duration to keep Relay<x>ONwhenPower<x> ONcommand is issued. After this amount of time, the power will be turnedOFF. 0/OFF= disable use of PulseTime for Relay<x> 1..111= set PulseTime for Relay<x> in 0.1 second increments 112..64900= set PulseTime for Relay<x>, offset by 100, in 1 second increments. Add 100 to desired interval in seconds, e.g.,PulseTime 113= 13 seconds andPulseTime 460= 6 minutes (i.e., 360 seconds) Note if you have more than 8 relays: Defined PulseTime for relays <1-8> will also be active for correspondent Relay <9-16>.',
  'SwitchDebounce':
      'User control over switch debounce timing and method 40..1000= set switch debounce time in milliseconds(default =50). The granularity is 10 milliseconds, so the normally unnecessary last digit is used by the debouncing code to flag special handling: 0= no special handling 1= force_high: only a debounce time long LOW pulse could turn the switch off 2= force_low: only a debounce time long HIGH pulse could turn the switch on 3= force_high + force_low 4..8= unused 9=AC detectionfor switches / relays similar to MOES MS-104B / BlitzWolf SS5 etc. If the AC frequency is 50 Hz,SwitchDebounce 69will turn on the switch after three pulses and off after three missing one.',
  'SwitchMode<x>':
      'Switch mode 0= toggle(default) 1= follow (0 = off, 1 = on) 2= inverted follow (0 = on, 1 = off) 3= pushbutton (default 1, 0 = toggle) 4= inverted pushbutton (default 0, 1 = toggle) 5= pushbutton with hold (default 1, 0 = toggle, Hold = hold) 6= inverted pushbutton with hold (default 0, 1 = toggle, hold = hold) 7= pushbutton toggle (0 = toggle, 1 = toggle) 8= multi change toggle (0 = toggle, 1 = toggle, 2x change = hold) 9= multi change follow (0 = off, 1 = on, 2x change = hold) 10= inverted multi change follow (0 = on, 1 = off, 2x change = hold) 11= pushbutton with dimmer mode 12= inverted pushbutton with dimmer mode 13= pushon mode (1 = on, switch off usingPulseTime) 14= inverted pushon mode (0 = on, switch off usingPulseTime) 15= send only MQTT message on switch change (Example tele/tasmota/SENSOR ={"Time":"2021-01-01T00:00:00","Switch1":"OFF"})',
  'SwitchText<x>':
      'Show current JSON label ofSwitch<x>(1..8). OnlySwitchTextshows value for all 8 switches <text>- replace defaultSwitch<x>label in JSON messages with a custom text',
  'WebButton<x>':
      'Change the name of the toggle buttons of the WEB UI. This command accepts spaces in the name',
  'WebQuery<x>':
      'Command for GET, POST, PUT, and PATCH HTTP queries, complete with Request Headers and request body (when applicable) <url> GET|POST|PUT|PATCH [<headers>] <body> More information...',
};

Map<String, String> managementSettingsCommandsJSON = {
  'Delay':
      '2..3600= set a delay between two backlog commands with 0.1 second increment.Not recommended for precision timing!',
  'DeepSleepTime':
      'Time to enterdeep sleep mode 0= disable deep sleep mode(default) 11..86400= set deep sleep mode time period in seconds',
  'DeviceName':
      'Device name displayed in the webUI and used for HA autodiscovery. <value>= set device name(default =FriendlyName1value)',
  'Emulation':
      '0= disable emulation(default) 1= enable Belkin WeMo emulation forAlexa 2= enable Hue Bridge emulation forAlexa',
  'FriendlyName<x>':
      '	1= Reset friendly name to firmware default <value>= set friendly name (32 char limit)',
  'Gpios':
      'Show list of availablecomponentsby name and index 255/AllShow list of allcomponentsby name and index',
  'Gpio':
      "Show currentcomponentassignments of the Module's configurable GPIO 255/AllShowcomponentassignments for all the devices available GPIO",
  'Gpio<x>': '<component>= assign acomponenttoGpio<x>',
  'I2Cscan': 'Scan I2C bus and show addresses for found devices',
  'I2CDriver': 'Enable / Disable I2C sensor drivers.Read more...',
  'LogHost':
      '1= resetsysloghost to firmware default (SYS_LOG_HOST) <value>= set syslog host',
  'LogPort':
      '1= resetsyslogport to firmware default (SYS_LOG_PORT) 2..32766= set syslog port',
  'Modules': 'Show available modules by name and index',
  'Module':
      'Displays active module by name and index <value>= switch to module <value> and restart 0= switch to definedtemplateand restart',
  'Module2':
      'Displays activefast rebootfallback module by name and index <value>= set fast reboot fallback module to <value> 0= set fast reboot fallback module to definedtemplate',
  'MqttLog':
      '0= disable logging via MQTT(default) 1= show only error messages 2= show error and info messages 3= show error, info and debug messages 4= show error, info and more debug messsages',
  'NtpServer<x>':
      'NTP server setup (x=1..3) 0= clear NtpServer<x> settings 1= reset NtpServer<x> settings to firmware defaults <value>= set NtpServer<x> host or IP address (32 char limit)',
  'OtaUrl':
      'Display current OTA URL 1= Reset OtaUrl to firmware default url= set address for OTA (100 char limit)',
  'Pwm<x>	': '0..1023= set PWM value for channel (NOTE seeSetOption15)',
  'PwmFrequency':
      '1= reset PWM frequency to 223Hz 40..4000 or 40..50000= set PWM frequency (40Hz to 4kHz on ESP 82xx / 40-50kHz on ESP32) As of v8.3.0 the default frequency changed to 977Hz',
  'PwmRange':
      '1= reset maximum PWM range to 1023 255..1023= set maximum PWM range',
  'Reset':
      '1= reset device settings to firmware defaults and restart (see warning below) 2= erase flash, reset device settings to firmware defaults and restart 3= erase System Parameter Area in flash (Wi-Fi calibration and related data) and restart (see warning below) 4= reset device settings to firmware defaults but retain Wi-Fi credentials and restart 5= erase all flash and reset parameters to firmware defaults but keep Wi-Fi settings and restart 6= erase all flash and reset parameters to firmware defaults but keep Wi-Fi and MQTT settings and restart (Erase of flash can take a few seconds to complete and there is no output during the erase process on the serial or web console) 99= reset device bootcount to zero Forreset 3andreset 1, device must be power-cycled in order to load new Wifi System parameters.',
  'Restart':
      '1= restart device with configuration saved to flash 2= halt system (needs hardware reset or power cycle to restart) 99= force restart device without configuration save For debug and testing stack trace dumps only: -1= force an Exception (28) crash -2= force a Soft WDT reset (after a freeze of 2 seconds) -3= force an OS watchdog reset (after a freeze of 120 seconds,caution!)',
  'RtcNtpServer<x>':
      '		Use Tasmota NTP server when enabled by defineRTC_NTP_SERVER 0= disabled 1= enabled',
  'SaveData':
      '0= save parameter changes only manually, e.g. withRestart 1 1= save parameter changes every second(default) 2..3600= save parameter changes every x second',
  'SerialLog':
      'Disable hardware serial bridge and 0= disable serial logging 1= show only error messages 2= show error and info messages(default) 3= show error, info and debug messages 4= show error, info and more debug messages SerialLogwill be disabled automatically 10 minutes after the device reboots.',
  'SetSensor<x>': 'Enable / Disable individual sensor driver(x=1..127)',
  'Sleep':
      '0= turn sleep off 1..250= set sleep duration in milliseconds to enableenergy saving(default =50)',
  'State':
      'Display current device state and publish to%prefix%/%topic%/RESULTtopic',
  'Status':
      "	= show abbreviatedstatus information 0= show all status information (1 - 11) 1= show device parameters information 2= show firmware information 3= show logging and telemetry information 4= show memory information 5= show network information 6= show MQTT information 7= show time information 8= show connected sensor information(retained for backwards compatibility) 9= show power thresholds(only on modules with power monitoring) 10= show connected sensor information(replaces 'Status 8') 11= show information equal toTelePeriodstate message 12= in case of crash to dump the call stack saved in RT memory",
  'Status0': '0= show all status information in a single line',
  'SysLog':
      '0= disable syslog logging(default) 1= show only error messages 2= show error and info messages 3= show error, info and debug messages 4= show error, info and more debug messages',
  'Template':
      'Show currentTemplate 0= create template from active module x= create template from asupported module 255= merge current module and template settings into new template { ... }= store template in aJSON payload Does not activate the template. To activate useModule 0.',
  'Time':
      '0= enable NTP(default) 1= format JSON message timestamp in ISO format 2= format JSON message timestamp in both ISO and Epoch format 3= format JSON message timestamp in Epoch format 4= format JSON message timestamp in milliseconds <value>= disable NTP and set UTC time as epoch value if greater than1451602800(January 1, 2016)',
  'TimeStd':
      'TimeDst			Set policies for the beginning of daylight saving time (DST) and return back to standard time (STD) Use theTasmota timezone tableto find the commands for your time zone. 0= reset parameters to firmware defaults H,W,M,D,h,T H= hemisphere (0= northern hemisphere /1= southern hemisphere) W= week (0= last week of month,1..4= first .. fourth) M= month (1..12) D= day of week (1..71= Sunday7= Saturday) h= hour (0..23) inlocaltime T= time zone (-780..780) (offset from UTC inMINUTES- 780min / 60min=13hrs) Example:TIMEDST 1,1,10,1,2,660 _If time zone isNOT99, DST is not used (even if displayed)see',
  'Timezone':
      '13..+13= set time zone offset from UTC in hours -13:00..+13:00= set time zone offset from UTC in hours and minutes 99= use time zone configured withTimeDstandTimeStd Use theTasmota time zone tableto find the commands for your time zone.',
  'Ufs': 'Universal File System commandsread more...',
  'UfsDelete': 'Delete SD card or Flash FS file if only of them available',
  'UfsDelete2': 'Delete only Flash FS file if available',
  'UfsFree': 'Filesystem free size in kb',
  'UfsRename': 'Rename SD card or Flash FS file if only of them available',
  'UfsRename2': 'Rename only Flash FS file if available',
  'UfsRun': 'Run file',
  'UfsSize': 'Filesystem size in kb',
  'UfsType': 'Get filesystem type 0= none 1= SD card 2= Flash file 3= LittleFS',
  'Upgrade':
      '1= download firmware fromOtaUrland restart <value>= download firmware fromOtaUrlif <value> is higher than device version',
  'Upload':
      '1= download firmware fromOtaUrland restart <value>= download firmware fromOtaUrlif <value> is higher than device version',
  'WebGetConfig':
      '<url>= pull a configuration.dmpfile from a HTTP URL More information...',
  'WebLog':
      '0= disable web logging 1= show only error messages 2= show error and info messages(default) 3= show error, info and debug messages 4= show error, info and more debug messages',
  'WebTime':
      '<start_pos>,<end_pos>= show part of date and/or time in WebUI based on "2017-03-07T11:08:02-07:00"',
};
Map<String, String> wifiSettingsCommandsJSON = {
  'Ap':
      '0= switch to other Wi-Fi Access Point 1= select Wi-Fi Access Point 1 2= select Wi-Fi Access Point 2',
  'CORS':
      '"= disable CORS (Cross Origin Resource Sharing) (default) *= enable CORS for all locations value= Enable CORS for location. This needs to be complete url ex:http://tasui.shantur.com',
  'Hostname':
      '1= reset hostname toMQTT_TOPIC-<4digits>and restart <value>= set hostname (32 char limit) and restart. If hostname contains%it will be reset to the default instead. SeeFAQfor allowed characters. If using MQTT to issue this command, if it is used with the deviceGroupTopic, the command will not be executed.',
  'IPAddress<x>':
      'Set networking IP (XXX.XXX.XXX.XXX) addresses IPAddress1to set device IP address 0.0.0.0to use dynamic IP address (DHCP) XXX.XXX.XXX.XXXto set static IP address IPAddress2to set gateway IP address IPAddress3to set subnet mask IPAddress4to set DNS server IP address IPAddress5to set Secondary DNS server IP address  follow IPAddress commands withrestart 1to apply changes',
  'Password<x><x>':
      '<x>=1..2 <value>= set AP<x> Wi-Fi password and restart 1= reset AP<x> Wi-Fi password to firmware default (STA_PASS1orSTA_PASS2) and restart Passwords are limited to 64 characters.Do not use special characters or white spaces in the password. Note thatPasswordandPassword1are equivalent commands.',
  'Ping<x><x>':
      '<addr><x>=0..8= the number of ICMP packets to send,0uses the default (4) <addr>= address to send Ping, either in numerical format192.168.1.200or domain nametasmota.com  (requires#define USE_PING) ExamplePing4 192.168.1.203:RSL: tele/tasmota_xxx/RESULT = {"Ping":{"192.168.1.203":{"Reachable":true,"Success":4,"Timeout":0,"MinTime":59,"MaxTime":167,"AvgTime":116}}}',
  'Ssid<x><x>':
      '<x>=1..2 <value>= set AP<x> Wi-Fi SSID and restart 1= reset AP<x> Wi-Fi SSID to firmware default (STA_SSID1orSTA_SSID2) and restart SSID are limited to 32 characters.Do not use special characters or white spaces in the SSID',
  'TCPBaudRate':
      'Requires GPIOsTCP TxandTCP Rxand can work with hardware or software serial. 1200..115200= set the baudrate for serial (only 8N1 mode)',
  'TCPConnect': ', <port>= Port used for connection = IP address to connect to',
  'TCPConfig': '<value>= standard 3 characters mode such as 8N1, 7E1, etc ...',
  'TCPStart':
      'Requires GPIOsTCP TxandTCP Rxand can work with hardware or software serial. Also works withModBus Bridge <port>, [<ipaddress>]= Start listening to port. If<ipaddress>is defined only allows connections from the provided IPv4 address 0= Shut down TCP server and disconnect any existing connection Supports 2 parallel TCP connections, which can be useful if you need a terminal + a specific protocol (like XMODEM). The 3rd connection will disconnect a previous connection. The number of parallel connections is a compile-time option.',
  'UrlFetch':
      '<url> Download a url (http or https) an store the content in the filesystem ESP32 only',
  'WebColor<x>':
      'Configure Web GUI colors (x =1..19) #RRGGBB= Set color forWebColor<x> 1= Global text (Black) 2= Global background (White) 3= Form background (Greyish) 4= Input text (Black) 5= Input background (White) 6= Console text (Black) 7= Console background (White) 8= Warning text (Red) 9= Success text (Green) 10= Button text (White) 11= Button (Blueish) 12= Button hovered over (Darker blue-ish) 13= Restart/Reset/Delete button (Red-ish) 14= Restart/Reset/Delete button hover (Darker red-ish) 15= Save button (Green-ish) 16= Save button hover (Darker greenish) 17= Config timer tab text (White) 18= Config timer tab background (Light grey) 19= Module title and FriendlyName text (Whiteish) User themes',
  'WebPassword':
      'Show current web server password 0= disable use of password for web UI 1= reset password to firmware default (WEB_PASSWORD) <value>= set web UI password (32 char limit) for userWEB_USERNAME(Default WEB_USERNAME =admin)',
  'WebQuery':
      'Send HTTP GET, POST, PUT, and PATCH Requests <url> <method> [<header1Name:header1Value|header2Name:header2Value...>]<body> <url>= HTTP URL to query <method>= HTTP Request method. Must beGET,POST,PUT, orPATCH [<header1Name:header1Value\|header2Name:header2Value...>](optional)= HTTP Request Headers. <body>(optional)= HTTP Request Body. Ignored for GET requests  Examples WebQuery http://www.mysite.com/api/status GET: Simple HTTP GET Request WebQuery http://www.mysite.com/api/update POST [Authorization:Bearer xyz\|Content-Type:application/json]{"message":"body"}: Sends POST data with an authorization header and Content-Type WebQuery http://www.mysite.com/api/set PUT {"message":"body"}: Sends PUT request with a body, but no headers',
  'WebRefresh':
      'Web page refresh 1000..10000= set refresh time in milliseconds(default =2345)',
  'WebSend':
      'Send a command to Tasmota host over http. If a command starts with a/it will be used as a link. [<host>:<port>,<user>:<password>] <command> <host>= hostname or IP address. <port>= port for the device if not the default80 <user>= enter username of the device youre sending the command to <password>= enter password of the device youre sending the command to <command>= command and payload example 1:[<ip>] POWER1 ONsendshttp://<ip>/cm?cmnd=POWER1 ON example 2:WebSend [myserver.com] /fancy/data.php?log=1234sendshttp://myserver.com/fancy/data.php?log=1234',
  'WebGetConfig':
      '<url> Download a configuration (*.dmp) from an http URL. The URL can include%id%which will be substituted by the devices MAC address without the dots. A possible usage for ones that compile their own binary is to include the command in USER_BACKLOG for automatic reconfiguration after areset 1command.',
  'WebSensor<x>':
      'Control display of sensor telemetry in the web UI 0= Do not display sensors telemetry 1= Display sensors telemetry (default) <x>= number corresponding to the sensor - listed in thesnssection of thesupported sensor spreadsheet <x>=3Energy telemetry Issue aStatus 4to obtain a list of sensor types enabled in the firmware loaded on the device.',
  'WebServer':
      '			0= stop web server 1= start web server in user mode 2= start web server in admin mode',
  'Wifi':
      '			0= disable Wi-Fi 1= enable Wi-Fi(default) ESP8266 only: 2= Wi-Fi mode 802.11b 3= Wi-Fi mode 802.11b/g 4= Wi-Fi mode 802.11b/g/n When wifi is Off it is always returned On after a restart except for a wake-up from deepsleep.',
  'WifiConfig':
      '			0= disable Wi-Fi Manager and reboot (used with alternate AP) 2= setWi-Fi Manageras the current configuration tool and start Wi-Fi Manager (web server at 192.168.4.1) for 3 minutes, then reboot and try to connect Wi-Fi network 4= retry other AP without rebooting(default) 5= wait until selected AP is available again without rebooting 6= Wi-Fi parameters can only be entered via commands in the serial console 7= setWi-Fi Manager(web server at 192.168.4.1) as the current configuration tool restricted to reset settings only. This setting is recommended for devices without an external control/reset button. No longer supported 1= setSmartConfig(Android/iOS) for 3 minutes 3= setWPSfor 3 minutes',
  'WifiPower':
      '			set Wi-Fi transmit power level in decibel-milliwatts (dBm)(default =17)',
  'WifiScan':
      '			1= start a network scan. Results will be sent as a JSON payload.Read more...',
  'WifiTest':
      '<x>			Test whether the Wi-Fi SSId and Password are correct and Tasmota can connect to the network.<x>=0..2 0= test credentials, if successful save them in SSID slot 1, restart Tasmota 1= test credentials, if successful save them in SSID slot 1 without restart 2= test credentials, if successful save them in SSID slot 2 without restart ssid+password= credentials used for testing,+symbol is the separator since it is not allowed in an SSId name.*Read more...',
};
Map<String, String> mqttSettingsCommandsJSON = {
  'ButtonRetain':
      '0= disable use of MQTT retain flag(default) 1= enable MQTT retain flag on button press',
  'ButtonTopic':
      '<value>= set MQTT button topic 0= disable use of MQTT button topic 1= set MQTT button topic to device%topic% 2= reset MQTT button topic to firmware default (MQTT_BUTTON_TOPIC)(default =0) If using MQTT to issue this command, if it is published to the deviceGroupTopic, the command will not be executed.',
  'FullTopic':
      '1= reset MQTT fulltopic to firmware default (MQTT_FULLTOPIC) and restart <value>= set MQTT fulltopic and restart. Use ofoptional %prefix%, %topic%, %hostname%, and %id% substitution tokensis allowed. If using MQTT to issue this command, if it is published to the deviceGroupTopic,you must ensure uniqueness of the resulting fulltopic on each destination device by using one or more of these substitution tokens.',
  'GroupTopic<x>':
      '1= reset MQTT group <x> topic to firmware default (MQTT_GRPTOPIC) and restart <value>= set MQTT group <x> topic and restart',
  'InfoRetain':
      '0= disable use of info MQTT retain flag(default) 1= enable MQTT retain flag on messagetele/%topic%/INFO<x>',
  'MqttClient':
      '1= reset MQTT client to firmware config (MQTT_CLIENT_ID) and restart <value>= set MQTT client and restart. You can use the%06Xsubstitution token to replace with last six characters of MAC address. If using MQTT to issue this command, if it is used with the deviceGroupTopic, the command will not be executed.',
  'MqttFingerprint':
      'TLS needs to be enabled in firmware for this command <value>= set current fingerprint as 20 space separated bytes (59 chars max)',
  'MqttHost':
      '0= clear MQTT host field and allow mDNS to find MQTT host 1= reset MQTT host to firmware default (MQTT_HOST) and restart <value>= set MQTT host and restart (do NOT use.local)',
  'MqttKeepAlive': '1..100= set MQTT Keep Alive timer(default =30)',
  'MqttPassword':
      '0= clear MQTT password 1= reset MQTT password to firmware default (MQTT_PASS) and restart <value>= set MQTT password and restart (min 5 chars)',
  'MqttPort':
      '1= reset MQTT port to firmware default (MQTT_PORT) and restart <value>= set MQTT port between 2 and 32766 and restart',
  'MqttRetry':
      '10..32000= set MQTT connection retry timer in seconds(default =10)',
  'MqttTimeout': '1..100= set MQTT socket timeout(default =4)',
  'MqttUser':
      '0= clear MQTT user name 1= reset MQTT user name to firmware default (MQTT_USER) and restart <value>= set MQTT user name and restart',
  'MqttWifiTimeout':
      '100..20000= set MQTT Wi-Fi connection timeout in milliseconds(default =200)',
  'PowerRetain':
      'MQTTpower retain state 0/off= disable MQTT power retain on status update(default) 1/on= enable MQTT power retain on status update',
  'Prefix1':
      '1= reset MQTT command subscription prefix to firmware default (SUB_PREFIX) and restart <value>= set MQTT command subscription prefix and restart',
  'Prefix2':
      '1= reset MQTT status prefix to firmware default (PUB_PREFIX) and restart <value>= set MQTT status prefix and restart',
  'Prefix3':
      '1= Reset MQTT telemetry prefix to firmware default (PUB_PREFIX2) and restart <value>= set MQTT telemetry prefix and restart',
  'Publish': '<topic> <payload>= MQTT publish any topic and optional payload',
  'Publish2':
      '<topic> <payload>= MQTT publish any topic and optional payload with retain flag',
  'SensorRetain':
      '0= disable use of sensor MQTT retain flag(default) 1= enable MQTT retain flag on messagetele/%topic%/SENSOR',
  'StateRetain':
      '0= disable use of state MQTT retain flag(default) 1= enable MQTT retain flag on messagetele/%topic%/STATE',
  'StateText<x>':
      '<value>= set state text (<x>=1..4) 1 =OFFstate text 2 =ONstate text 3 =TOGGLEstate text 4 =HOLDstate text',
  'SwitchRetain':
      '0= disable use of MQTT retain flag(default) 1= enable MQTT retain flag on switch press',
  'Subscribe':
      'Subscribes to an MQTT topic without appended/#and assigns an Event name to it. <eventName>, <mqttTopic> [, <key>]=Read more... = list all topics currently subscribed',
  'Subscribe2':
      'Subscribes to an MQTT topic and assigns an Event name to it. <eventName>, <mqttTopic> [, <key>]=Read more... = list all topics currently subscribed',
  'SwitchTopic':
      '<value>= set MQTT switch topic 0= disable use of MQTT switch topic 1= set MQTT switch topic to device%topic% 2= reset MQTT switch topic to firmware default (MQTT_SWITCH_TOPIC)(default =0) Read moreabout this. If using MQTT to issue this command, if it is used with the deviceGroupTopic, the command will not be executed.',
  'TelePeriod':
      'See current value and force publish STATE and SENSOR message 0= disable telemetry messages 1= reset telemetry period to firmware default (TELE_PERIOD) 10..3600= set telemetry period in seconds(default =300)',
  'Topic':
      '1= reset MQTT topic to firmware default (MQTT_TOPIC) and restart <value>= set MQTT topicandButtonTopicand restart. When using MQTT to issue this command, if it is used with the deviceGroupTopic, the command will not be executed.Topic can not be identical toMqttClient',
  'Unsubscribe':
      'Unsubscribe from topics subscribed to withSubscribe = unsubscribe all topics <eventName>= unsubscribe from a specific MQTT topic',
};

Map<String, String> rulesSettingsCommandsJSON = {
  'Add<x>': '			<value>= add value to Var<x> (example)',
  'CalcRes':
      'Current calculation resolution 0..7= set number of decimal places to be used inAdd,Sub,MultandScale',
  'Event': 'Execute an event to trigger a rule asdocumented',
  'Mem<x>':
      'Manage up to 16 variables stored on flash (x =1..16) Memreturns all current values.Mem<x>returns the variables current value. <value>= store a string value in a variable "= clear stored value in Mem<x>',
  'Mult<x>': '<value>= multiply value to Var<x> (example)',
  'Rule<x>':
      'Rules.Read more... 0= disable Rule<x> 1= enable Rule<x> 2= toggle Rule<x> 4= disable one-shot detection (perform commands as long as trigger is met) 5= enable one-shot (e.g., sometimes used for slow changing sensors like temperature) detection 6= toggle one-shot detection 8= disable stop-on-error after exception restart 9= enable stop-on-error after exception restart 10= toggle stop-on-error after exception restart <value>= define Rule<x> +<value>= append to Rule<x> "= clear Rule<x>  Rule set one-shot: Each rule within the rule set will trigger only once until the trigger condition returns to a false condition. For example,ON Energy#Power<3: Without one-shot enabled, it will trigger anytimeEnergy#Powergets an update (i.e., thePowertelemetry value changes) and the value is<3. This can potentially trigger that rule multiple times. With one-shot enabled, the rule will trigger only the on the first transition to<3and not again until the trigger value goes>=3. In other words, the rule will trigger again, but it has to cross the conditional "boundary" before it will trigger again.',
  'Rule0': 'Same functionality as Rule<x> but affects all rulesets at once',
  'RuleTimer<x>':
      'Up to eight timers to be used as countdown event (x =1..8) 0..65535= set countdown rule timer in seconds RuleTimer0 0= stops and clear all timer simultaneously',
  'Scale<x>':
      'Scale value from a low and high limit to another low and high limits and save in Var<x> (example) v= value: the number to scale fl= fromLow: the lower bound of the value’s current range fh= fromHigh: the upper bound of the value’s current range tl= toLow: the lower bound of the value’s target range th= toHigh: the upper bound of the value’s target range',
  'Sub<x>': '<value>= subtract value to Var<x> (example)',
  'Var<x>':
      'Manage up to 16 variables stored in memory (x =1..16) Varreturns all current values.Var<x>returns the variables current value. <string>= store a string value in a variable "= clear stored value in Var<x>',
};

Map<String, String> timerSettingsCommandsJSON = {
  'Latitude':
      '<value>= set latitude in decimal degrees format, e.g. -33.893681',
  'Longitude':
      '<value>= set longitude in decimal degrees format, e.g. 18.619954',
  'Timers':
      'Timers control 0= disable all timers 1= enable all timers 2= toggle all timers',
  'Timer<x>':
      'Parameters for Timer<x> where x =1..16 0= clear parameters for Timer<x> 1..16= copy Timer<y> parameters to Timer<x> { "name":value ; .. }= set all or individual parameters using JSON payload with names and values of data pairs from thetable',
};

Map<String, String> sensorsSettingsCommandsJSON = {
  'AdcParam<x>':
      'ADCanalog input tuning parameters. On ESP32 x is channel1..8 <sensor>, <param1>, <param2>, <param3>, <param4> complete<sensor>values listedhere...',
  'Altitude': '-30000..30000= altitude in meters',
  'AmpRes': 'Current sensor resolution 0..3= maximum number of decimal places',
  'BH1750Resolution<x>':
      'BH1750resolution mode.x= BH1750 sensor number (1..2) 0..2= choose sensor resolution (0= high(default),1= high2,2= low)',
  'BH1750MTime<x>':
      'BH1750Measurement Time value.x= BH1750 sensor number (1..2) 30..255= set Measurement Time value. Not persistent after reboot.(default =69)',
  'Counter<x>':
      '0= reset Counter<x> 1..2,147,483,645= preset Counter<x> -1..-2,147,483,645= decrease Counter<x> +1..+2,147,483,645= increase Counter<x> In order to define and use a Counter,*you must configure one of the free device GPIO asCounter<x>. Countermodule configuration is using internal pull-up resistor while Countern does not. *',
  'CounterDebounce':
      '0= turn off counter debounce 1..32000= set counter debounce time in milliseconds. Counter is increased with every falling edge when CounterType=0 or time between successive falling edges is measured when CounterType=1. When CounterDebounceLow and CounterDebounceHigh are set to zero (default) only falling edges of the counters GPIO are checked. Any CounterDebounceLow or CounterDebounceHigh unequal zero checks are carried out before CounterDebounce check is done. As an example you can setCounterDebounce 500to allow a minimum distance between to successive valid falling edges equal to 500ms.',
  'CounterDebounceLow':
      '0= turn off counter debounce low 1..32000= set counter debounce low time in milliseconds. Allow individual debounce times for low pulse widths to discard non valid falling edges. These are checked before legacy CounterDebounce checks distance between two valid falling edges. When unequal zero tasmota will check falling and rising edges on the counters GPIO. For CounterDebounceLow any GPIO change from low to high hat happens after the GPIO was not low for at least CounterDebounceLow will be ignored. As an example you can setCounterDebounceLow 50to allow a valid minimum distance between a falling and rising edge equal to 50ms while having a final CounterDebounce 500 check between to successive valid falling edges equal to 500ms.',
  'CounterDebounceHigh':
      '0= turn off counter debounce high 1..32000= set counter debounce high time in milliseconds. Allow individual debounce times for high pulse widths to discard non valid falling edges. These are checked before legacy CounterDebounce checks distance between two valid falling edges. When unequal zero tasmota will check falling and rising edges on the counters GPIO. For CounterDebounceHigh any GPIO change from high to low hat happens after the GPIO was not high for at least CounterDebounceHigh will be ignored. As an example you can setCounterDebounceHigh 100to allow a valid minimum distance between a rising and falling edge equal to 100ms while having a final CounterDebounce 500 check between to successive valid falling edges equal to 500ms.',
  'CounterType<x>':
      '0= set Counter<x> as pulse Counter 1= set Counter<x> as pulse Timer',
  'GlobalHum':
      '0.0..100.0= Set global Humidity for some Sensors that uses global Humidity.',
  'GlobalHum2':
      '1..250= select Global Humidity source indexed from teleperiod occurence data.',
  'GlobalPress2':
      '1..250= select Global Pressure source indexed from teleperiod occurence data.',
  'GlobalTemp':
      '-50.0..100.0= Set global Temperature for some Sensors that uses global temperature.',
  'GlobalTemp2':
      '1..250= select Global Temperature source indexed from teleperiod occurence data.',
  'HumOffset':
      '-10.0..10.0= Set calibration offset value for reported humidity telemetry This setting affectsallhumidity sensors on the device.',
  'HumRes': 'Humidity sensor resolution 0..3= maximum number of decimal places',
  'PressRes':
      'Pressure sensor resolution 0..3= maximum number of decimal places',
  'NPCLRes': 'Neopool only <value>= number of digits in results for CL values',
  'NPIonRes':
      'Neopool only <value>= number of digits in results for ION values',
  'NPPHRes': 'Neopool only <value>= number of digits in results for PH values',
  'Sensor12':
      'ADS1115 mode selection (defaultS0). Note that Vdd (2.0-5.5v) must be >= analog voltage inputs. D0 .. D5= differential modes S0 .. S5= single-ended modes 0= +/- 6.144v 1= +/- 4.096v 2= +/- 2.048v 3= +/- 1.024v 4= +/- 0.512v 5= +/- 0.256v',
  'Sensor13':
      'INA219andISL28022low voltage current sensor configuration Predefined modes to use with standard 0.1 ohm resistor: 0= set INA219 calibration to max 32V and 2A 1= set INA219 calibration to max 32V and 1A 2= set INA219 calibration to max 16V and 0.4A In all cases, ISL28022 is set to 60V mode 10..255: Define custom shunt resistor encoded as a decimal numberRRMsuch thatRshunt = RR * 10^Mmilliohm Do not forget to choose a resistor adapted for the correct power dissipation and apply a 50% security margin ! Examples: 11= 1 * 10^1 = 10 milliohm (Imax=32A => Pres=15W) 21= 2 * 10^1 = 20 milliohm (Imax=16A => Pres=7W) 12= 1 * 10^2 = 100 milliohm (default, Imax=3.2A => Pres=2W) 13= 1 * 10^3 = 1000 milliohm = 1 ohm (Imax=0.320A => Pres=0,2W) The driver seamlessly detect INA219/ISL28022 and adapt configuration and readings accordingly. The component label in Web GUI and SENSOR message will automatically match the detected part. It is possible to mix INA219 and ISL28022 as far as addresses do not conflicts. Shunt resistor setting applies to all INA219/ISL28022.',
  'Sensor15':
      'Automatic Baseline CorrectionforMH-Z19BCO2sensor 0= disable 1= enable(default) 2= start manual calibration from 400 ppm of CO2 9= reset sensor to factory defaults 1000= sets measurement range to 1000ppm CO2 2000= sets measurement range to 2000ppm CO2 3000= sets measurement range to 3000ppm CO2 5000= sets measurement range to 5000ppm CO2 10000= sets measurement range to 10000ppm CO2',
  'Sensor18':
      'PMSx003 particle dust sensor 0..32000= control sensor polling interval to extend lifetime',
  'Sensor20':
      'Nova Fitness SDS011dust sensor. 1..255= number of seconds before TelePeriod to poll the sensor',
  'Sensor27':
      'APDS-9960sensor commands 0= enable light level and proximity sensor / disable gestures(default) 1= enable gesture mode/ disable light level and proximity sensor 2= enable gestures with half gain / disable light and proximity sensor 3..255= SetATIME registerfor different integration times',
  'Sensor29':
      'MCP23008 / MCP23017 I2C GPIO Expander configuration.Read more... Reset<x>= reset all pins x =1..6 1= INPUT mode, no reporting, no pull-up 2= INPUT mode, report on CHANGE, pull-up enabled 3= INPUT mode, report on LOW, pull-up enabled 4= INPUT mode, report on HIGH, pull-up enabled 5= OUTPUT mode (if enabled by#define USE_MCP230xx_OUTPUT) 6= inverted OUTPUT mode (if enabled by#define USE_MCP230xx_OUTPUT)  pin,pinmode{,intpullup|outstate{,repmode}} Continue reading...',
  'Sensor34':
      'HX711 load cellsensor calibration 1= reset display to 0 2= start calibration 2<value>= set reference weight in grams and start calibration 3= show reference weight in grams 3<value>= set reference weight in grams 4= show calibrated scale value 4<value>= set calibrated scale value 5= show max weight in gram 5<value>= set max weight in grams 6= show single item weight in grams 6<value>= set single item weight in grams. Once the item weight is set, when items are added to the scale, the telemetry message will reportCountas the number of items on the scale 7= save current weight to be used as start weight on restart 80/1 0= disable JSON message on weight change over 4 grams 1= enable JSON message on weight change (see below) 9<value>= set minimum delta to trigger JSON message (see above). 0= 4 grams (old default) 1..100= set delta to 0-99 grams 101-255= set delta to 110-1650 grams (10g increments)',
  'Sensor50':
      'PAJ7620gesture sensor 0= sensor muted, no readings in Tasmota 1= gesture mode 2= proximity mode 3= corner mode 4= PIN mode 5= cursor mode',
  'Sensor52':
      'iBeacon driver withHM10orHM17/HM16 1and2= required only once to initialize the module u<x>= sets update interval in seconds (scan tags every <x> seconds)(default = 10) t<x>= set timeout interval in seconds (send RSSI=0 if tag is not detected after <x> seconds)(default = 30) d1= enable debug mode (shows all serial traffic in console) d0= disable debug mode_(default = 30)_ c= clears iBeacon list s AT+<command>= send native AT commands',
  'Sensor53':
      'Smart Meter Interface r= reset the driver with a new descriptor specified with the TasmotaScriptinglanguage. c<x> <value>= preset counter (x =1..5) tovaluewhen the driver is set to counter mode d<x>= disable data decoding and dump meter (x =1..5) data to the Console. This is used to decipher the meters data format to define the variable encoding in the meters descriptor. d0= disable data dump mode and revert to decoding mode. l<x>= monitor the serial activity at a GPIO with a connected LED. x = GPIO of the LED. l255= disable monitoring (default) m<x>= serial meter number (x =1..5) to be monitored m0= monitor all serial meters (default)',
  'Sensor54':
      'INA226 Current Sensor 1= rescan for devices and return the number found. 2= save the configuration and restart 10= return channel 1 shunt resistance and full scale current 11 <resistance>= set INA226 channel 1 shuntin ohms, floating point 12 <current>= set INA226 channel 1 full scalein amperes, floating point 20= return channel 2 shunt resistance and full scale current 21 <resistance>= set INA226 channel 2 shuntin ohms, floating point 22 <current>= set INA226 channel 2 full scalein amperes, floating point 30= return channel 1 shunt resistance and full scale current 31 <resistance>= set INA226 channel 1 shuntin ohms, floating point 32 <current>= set INA226 channel 1 full scalein amperes, floating point 40= return channel 1 shunt resistance and full scale current 41 <resistance>= set INA226 channel 1 shuntin ohms, floating point 42 <current>= set INA226 channel 1 full scalein amperes, floating point',
  'Sensor60':
      'GPS 0= write to all available sectors, then restart and overwrite the older ones 1= write to all available sectors, then restart and overwrite the older ones 2= filter out horizontal drift noise 3= turn off noise filter 4= start recording, new data will be appended 5= start new recording, old data will lost 6= stop recording, download link will be visible in webUI 7= send mqtt on new position + TELE(consider to set TELE to a very high value) 8= only TELE message 9= start NTP server 10= deactivate NTP server 11= force update of Tasmota-system-UTC with every new GPS-time-message 12= do not update of Tasmota-system-UTC with every new GPS-time-message 13= set latitude and longitude in settings 14= open virtual serial port over TCP, usable for u-center 15= pause virtual serial port over TCP',
  'Sensor68':
      'WindMeter sensor - Analog (pulse count) anemometer 1, <value>= set radius length in millimeters (measured from center to the edge of one of the cups)0..65535(default =61mm) 2, <value>= set number of pulses for a complete turn1..255(default =1) 3, <value>= set pulse counter debounce time in milliseconds1..32000(default =10) 4, <value>= set speed compensation factor, a multiplication coefficient to adjust resulting speed-32.768..32.767three decimal places (default =1.180) 5, <value>= set minimum percentage change between current and last reported speed trigger a new tele message0..100,255= off (default =255)',
  'Sensor78':
      'EZO sensors - commands Ascii commands are sent directly to the sensor as-is. See your specificEZO device datasheetfor the list of commands available. By default, the specific command is sent to all EZO devices that are found. If using multiple EZO sensors, and the command should be issued to a single device, the index can be specified as part of the command: Sensor78-# where#represent the index of the device (ex: Sensor78-1 i). For more details please see Tasmotas support forEZO devices.',
  'Sensor80':
      'Set antenna gain for MFRC522 RFID Reader. Sensor80 1 <0..7> 0 18dB 1 23dB 2 18dB 3 23dB 4 33dB 5 38dB 6 43dB 7 48dB',
  'Sensor90':
      'Sendcommandsto Hydreon RG-15 Rain Sensor AReads accumulation data RRead all available data KRestart the rain sensor PSet to polling only mode (not supported) CSet to continuous mode, where data is sent when accumulation changes (default) HForce high resolution LForce low resolution IForce imperial (not supported) MForce metric (default) SRevert to jumper configured values OReset the accumulation counter',
  'SpeedUnit':
      'TX20/TX23and WindMeter anemometer speed unit 1= m/s 2= km/h 3= kn 4= mph 5= ft/s 6= yd/s',
  'TempRes':
      'Temperature sensor resolution 0..3= maximum number of decimal places',
  'TempOffset':
      '-12.6..12.6= Set calibration offset value for reported temperature telemetry This setting affectsalltemperature sensors on the device.',
  'VoltRes': 'Voltage sensor resolution 0..3= maximum number of decimal places',
  'WattRes': 'Power sensor resolution 0..3= maximum number of decimal places',
  'WeightRes':
      'Load cell sensor resolution 0..3= maximum number of decimal places',
  'Wiper':
      'DS3502 contains a single potentiometer whose wiper position is controlled by the value in the Wiper Register (WR) represented by x =0..3 POTI 0..127= set POTI for wiper x STATUS= get wiper position for wiper x RESET= reset settings for wiper x',
};

Map<String, String> powerMonitoringSettingsCommandsJSON = {
  'AmpRes': 'Current sensor resolution 0..3= maximum number of decimal places',
  'CurrentCal':
      '1000..32000(default =3500) Set calibration offset value for reportedCurrenttelemetry Allows finer calibration for energy monitoring devices',
  'CurrentHigh':
      '0= disable current high threshold(default) <value>= set current high threshold value in milliamps',
  'CurrentLow':
      '0= disable current low threshold(default) <value>= set current low threshold value in milliamps',
  'CurrentSet': '<value>=calibratecurrent to target value in mA',
  'EnergyExport<x>': 'Export energy values <x>= meter number (default is1)',
  'EnergyExportActive<x>':
      'ADE7880 only!Set/reset energy active values <x>= meter number (default is1)',
  'EnergyToday<x>':
      'Set Energy Today values, parameters: <x>= meter number (default is1) <value>= set new value in Wh,0for reset <time>=0..4294967295set StartTotalTime time as epoch value (optional 2nd parameter)',
  'EnergyTotal<x>':
      'Set or set Energy Total values, parameters: <x>= meter number (default is1) <value>= set new value in Wh,0for reset <time>=0..4294967295set StartTotalTime time as epoch value (optional 2nd parameter) The new value represents start of day, and output for total includes the today value.',
  'EnergyReset<x>':
      'x =1..5 1<value>{,<time>}= ((p)re)set values 2<value>{,<time>}= ((p)re)set values for Yesterday 3<value>{,<time>}= ((p)re)set values for Total <value>=0..42949672in watt-hours (Wh) <time>=0..4294967295set StartTotalTime time as epoch value 4<standard>{,<off-peak>} = ((p)re)set tariff period values for Totals 5<standard>{,<off-peak>} = ((p)re)set tariff period values for Exported With version 10, this command has been replaced, see above.',
  'EnergyRes':
      'Energy sensor resolution 0..5= maximum number of decimal places',
  'EnergyYesterday<x>':
      'Set Energy Yesterday values, parameters: <x>= meter number (default is1) <value>= set new value in Wh,0for reset <time>=0..4294967295set StartTotalTime time as epoch value (optional 2nd parameter)',
  'EnergyUsage':
      'Set energy usage values, parameters: <value>= set energy usage value,0for reset',
  'FreqRes':
      'Frequency sensor resolution 0..3= maximum number of decimal places',
  'FrequencySet': '<value>=calibratefrequency to a target value in Hz',
  'MaxPower':
      '0= disable use maximum power monitoring <value>= set maximum allowed power in watts',
  'MaxPowerHold':
      '1= set default time to 10 seconds to stay over MaxPower before power off <value>= set time in seconds to stay over MaxPower before power off',
  'MaxPowerWindow':
      '1= set default time to 30 seconds to stay power off before re-applying power up to 5 times <value>= set time in seconds to stay power off before re-applying power up to 5 times',
  'ModuleAddress':
      'Set the address of a PZEM module 1..3= the last octet of the PZEM-004T serial address <address>= the last octet of the address on MODBUS PZEM energy monitoring modules Prior to setting the module address, the PZEMmust be connectedtobothRX and TX,andAC voltage. Connect one PZEM at a time and issue this command. Repeat for each PZEM to be connected for multi-phase monitoring. The command without an argument cannot be used to read the address of the connected PZEM.',
  'PowerCal':
      '1000..32000(default =12530) Set calibration offset value for reportedPowertelemetry reading Allows finer calibration for energy monitoring devices',
  'PowerDelta<x>':
      'Set maximum delta of phase a<x> in energy monitoring devices to report on active power load change while the power is ON.PowerDeltawill not report when the power turns off. 0= disable reporting on power change 1..100= set reporting on percentage power change to send an MQTT telemetry message 101..32000= set reporting on absolute power change to send an MQTT telemetry message (offset by 100, e.g.,101=1W,207=107W)',
  'PowerHigh':
      '0= disable power high threshold(default) <value>= set power high threshold value in watts to send an MQTT telemetry message',
  'PowerLow':
      '0= disable power low threshold(default) <value>= set power low threshold value in watts to send an MQTT telemetry message',
  'PowerSet': '<value>=calibratepower to a target value in watts',
  'Status': '8= show power usage 9= show power thresholds',
  'Tariff<x>':
      'P1 Smart Meter tariff configuration x =1, 2, 9 1STD,DSTStart times for off-peak tariff 2STD,DSTEnd times for off-peak tariff 90/1 0= use Start/End times also on weekends. 1= use off-peak tariff all weekend. STDandDSTmay be specified as: <hour>=0..23or <time>=00:00..23:59or <minutes>=0..1439(since midnight) If bothTariff1STD andTariff2STD are equal, all tariffs are disabled.',
  'VoltageCal':
      'Set calibration offset value for reportedVoltagetelemetry reading 1000..32000(default =1950) Allows finer calibration for energy monitoring devices',
  'VoltageHigh':
      '0= disable voltage high threshold(default) <value>= set voltage high threshold value in V',
  'VoltageLow':
      '0= disable voltage low threshold(default) <value>= set voltage low threshold value in V',
  'VoltageSet': '<value>=calibratevoltage to a target value in V',
  'VoltRes': 'Voltage sensor resolution 0..3= maximum number of decimal places',
  'WattRes': 'Power sensor resolution 0..3= maximum number of decimal places',
};
Map<String, String> lightSettingsCommandsJSON = {
  'SetOption82':
      'AlexaCTRange Reduce the CT range from153..500to200..380to accommodate with Alexa range 0= CT ranges from 153 to 500(default) 1= CT ranges from 200 to 380 (although you can still set in from 153 to 500)',
  'Channel<x>':
      '0..100= set PWM channel dimmer value from 0 to 100% += increase by 10 -= decrease by 10 WhenSetOption68is set to1Channel<x>will followPower<x>numbering with Relays first then PWM. Example: 2 Relays and 3 PWM: Relay1 =Power1; Relay2 =Power2; PWM1 =Power3andChannel3; PWM2 =Power4andChannel4; PWM3 =Power5andChannel5',
  'SetOption37':
      '  ChannelRemap 	Color remapping for led channels, also provides an option for allowing independent handling of RGB and white channels. Setting changes require a device reboot. 0= disable 1..119= according tothis table 120..127= invalid (results in same as0) 128..255= same as0..127but with independent channel handling enabled',
  'Color<x>':
      'x =1..6 1= Set color 2= Set color adjusted to currentDimmervalue 3= Set clock seconds hand color(Scheme5only) 4= Set clock minutes hand color(Scheme5only) 5= Set clock hour hand color(Scheme5only) 6= Set clock hour marker color <value> r,g,b= set color by decimal value (0..255) #CWWW= set hex color value for CT lights #RRGGBB= set hex color value for RGB lights #RRGGBBWW= set hex color value for RGBW lights #RRGGBBCWWW= set hex color value for RGBCCT lights (5 PWM channels) Note: Just append an=instead of the remaining color codes, this way they wont get changed. For example a command likeColor #00ff=would update the RGB part to disable red and enable green, but would omit to update blue or any white channel.Set color to 1= red 2= green 3= blue 4= orange 5= light green 6= light blue 7= amber 8= cyan 9= purple 10= yellow 11= pink 12= white (using RGB channels) += next color -= previous color',
  'CT':
      '153..500= set color temperature from 153 (cold) to 500 (warm) for CT lights += increase CT value by 10 -= decrease CT value by 10',
  'CTRange':
      'Specify CT range of the bulb. The slider will still allow to set CT from 153 to 500, but the rendering will be done within the new range. <ct_min>,<ct_max>= set color temperature from 153 (cold) to 500 (warm) for CT lightsdefault =153,500 This settings is not persisted in flash',
  'Dimmer':
      '0..100= set dimmer value from 0 to 100% += increase byDimmerStepvalue(default =10) -= decrease byDimmerStepvalue(default =10) Use of these parameters withFadeon enables dimmer level "move down," "move up," and "stop" commands(#11269) <= decrease to 1 >= increase to 100 != stop any dimmer fade in progress at current dimmer level',
  'Dimmer<x>':
      'Commands available only whenSetOption37 >= 128(#6819) <value>same as inDimmer Dimmer0 <value>= set dimming for all channels Dimmer1 <value>= set dimming for RGB channels Dimmer2 <value>= set dimming for white channels Dimmer4 <value>= allow retaining brightness ratio between white and color channels when setting dimmer for linked lights',
  'DimmerRange':
      'Change dimming range. <dimmerMin>,<dimmerMax>= set the internal dimming range from minimum to maximum value (0..255, 0..255) Does not changeDimmercommand behavior',
  'DimmerStep': '1..50- setDimmer +/-step value.(default =10)',
  'Fade': '0= do not use fade(default) 1= use fade See alsoSetOption91',
  'HsbColor': '<hue>,<sat>,<bri>= set color by hue, saturation and brightness',
  'HsbColor1': '0..360= set hue',
  'HsbColor2': '0..100= set saturation',
  'HsbColor3': '0..100= set brightness',
  'L1MusicSync':
      'Only for Sonoff L1 (Lite) and Spider Z LED controllers <power,sensitivity,speed> power=0- off,1- on,2- toggle sensitivity=1..10(default:5) speed=1..100(default:50) Can be used with onlypowerargument',
  'Led<x>':
      '#RRGGBB= set hex color value where<x>is the pixel number of the LED. A blank-delimited list of colors sets multiple successive pixels. (applies only to addressable LEDs)',
  'LedPwmMode<x>':
      'Control status LED light mode (x =0..4) 0= digital on/off mode(default) 1= PWM mode 2= toggle between modes',
  'LedPwmOff': '0..255= set LED brightness when OFF',
  'LedPwmOn': '0..255= set LED brightness when ON',
  'LedTable':
      '0= do not useLED gamma correction(default «6.5.0.9) 1= use gamma correction(default »6.5.0.9)',
  'SetOption68 Mu':
      'ltiPwm SetOption68			Multi-channel PWM instead of a single light 0= TreatPWMas a single light(default) 1= TreatPWMas separate channels. In this mode, usePower<x>to turn lights on and off, andChannel<x>to change the value of each channel. Colorstill works to set all channels at once. Requires restart after change',
  'Palette':
      '0= Clear color palette [ ...]= Set list of colors used byColor<1,2>andScheme<2,3,4>commands with each color separated by a space. The palette setting is not saved to flash. Use a boot-time rule such as ON System#Boot DO Palette xxxxx ENDON to set it back at each restart.',
  'Pixels':
      '1..512= set amount of pixels in strip or ring and resetRotation(applies only to addressable LEDs)',
  'SetOption91':
      ' PowerOnFade 			EnableFadeat boot and power on. By default fading is not enabled at boot because of stuttering caused by wi-fi connection 0= dont Fade at startup(default) 1= Fade at startup',
  'SetOption92':
      '  PWMCT 			Alternative toModule 38: for Cold/Warm white bulbs, enable the second PWM as CT (Color Temp) instead of Warm White, as required for Philips-Xiaomi bulbs. 0= normal Cold/Warm PWM(default) 1= Brightness/CT PWM SeePWM CT in Lights',
  'RGBWWTable':
      'Control light intensity of unbalanced PWM channels PWM1,PWM2,PWM3,PWM4,PWM5= channel range with values0..255(default =255,255,255,255,255) Range adjustment is computedafterGamma correction.',
  'Rotation':
      '<value>= set amount of pixels to rotate (up toPixelsvalue)(applies only to addressable LEDs)',
  'Scheme':
      'Light effects += next scheme -= previous scheme 0= single color for LED light(default) 1= start wake up sequence (same asWakeup) 2= cycle up through colors using Speed option 3= cycle down through colors using Speed option 4= random cycle through colors using Speed and Fade Use<value>, <startcolor>if you want to set the starting color of selected scheme. Following schemes are usable only with addressable LEDs, e.g. WS281X, Neopixel 5= clock mode (example) 6= candlelight pattern 7= RGB pattern 8= Christmas pattern 9= Hanukkah pattern 10= Kwanzaa pattern 11= rainbow pattern 12= fire pattern 13= stairs pattern',
  'Speed':
      '1..40= set fade speed from fast1to very slow40 += increase speed -= decrease speed TheSpeedvalue represents the time in 0.5s to fade from 0 to 100% (or the reverse). Example:Speed 4takes 2.0s to fade from full brightness to black, or 0.5s to move from 75% to 100%.',
  'Speed2':
      'Same asSpeedbut settings arent stored. != can be used to cancel the use of a precedingSpeed2command.Use example...',
  'StepPixels': '(Scheme5only) <value>= define the number of LEDs in each step',
  'VirtualCT':
      'Precisely specify color rendering of the bulb for Color Temperature. NeedsSetOption106 1and works for 3, 4 or 5 channel lights {"<minct>":"<color1>","midct":"<color2>","maxct":"<color3"} Example:VirtualCT {"200":"FFFFFF0000","400":"000000FF00"} The first and last CT values indicate the min and max CT and are equivalent toCTRange.Read more... This settings is not persisted in flash',
  'Wakeup':
      'Start wake up sequence from OFF to storedDimmervalue 0..100= Start wake up sequence from OFF to providedDimmervalue',
  'WakeupDuration': '1..3000= set wake up duration in seconds',
  'White':
      '1..100= set white channel brightness in single white channel lights (single W or RGBW lights)',
  'SetOption105':
      '  WhiteBlend 			White Blend Mode 0= disable(default) 1= enable',
  'Width<x>':
      'x =1..4 1=0..4= LED group width(Scheme6..12only) 2=0..32= seconds hand width(Scheme5only) 3=0..32= minutes hand width(Scheme5only) 4=0..32= hour hand width(Scheme5only)',
};

Map<String, String> deviceGroupSettingsCommandsJSON = {
  'DevGroupName<x>':
      '0= clear device group <x> name and restart <value>= set device group <x> name and restart. Prior to 8.2.0.3,GroupTopicwas used to specify the device group name.',
  'DevGroupSend<x>':
      '<item>=<value>[ ...]= send an update to device group <x>. The device group name must have been previously set with DevGroupName<x>. Multiple item/value pairs can be specified separated by a space. Spaces in<value>must be escaped with a backslash (\). The message sent is also processed on the local device as if it had been received from the network.  For items with numeric values,<value>can be specified as @<operator>[<operand>] to send a value after performing an operation on the current value. <operator> can be + (add), - (subtract) or ^ (invert). If <operand> is not specified, it defaults to 0xffffffff for the invert operator and 1 for other operators.  Examples: DevGroupSend 4=90 128=1- send an update to set the light brightness to 90 and turn relay 1 on. DevGroupSend 193=Buzzer\\ 2,3- send the Buzzer 2,3 command. DevGroupSend 6=@+ 4=@-10- set the next fixed color and decrease the brightness by 10. DevGroupSend 128=^- toggle all the relays.  2= Light fade (0 = Off, 1 = On) 3= Light speed (1..40) 4= Light brightness (0..255) 5= LightScheme 6= Light fixed color (0 = white (using CT channels), other values according toColor) 7= PWM dimmer low preset (0..255) 8= PWM dimmer high preset (0..255) 9= PWM dimmer power-on brightness (0..255) 128= Relay Power - bitmask with bits set for relays to be powered on. The number of relays can be specified in bits 24 - 31. If the number of relays is not specified, only relay 1 is set 192= Event - event name and arguments 193= Command - command and arguments 224= Light channels - comma separated list of brightness levels (0..255) for channels 1 - 5 (e.g. 255,128,0,0,0 will turn the red channel on at 100% and the green channel on at 50% on an RBG light)',
  'DevGroupShare':
      '<in>,<out>= set incoming and outgoing shared items(default =0xffffffff,0xffffffff) <in> and <out> are bit masks where each mask is the sum of the values for the categories (listed below) to be shared. For example, to receive only power (1), light brightness (2) and light color (16) and send only power (1), enter the command DevGroupShare 19,1.  1= Power 2= Light brightness 4= Light fade/speed 8= Light scheme 16= Light color 32= Dimmer settings (presets) 64= Event',
  'DevGroupStatus<x>':
      'Show the status of device group <x> including a list of the currently known members.',
};

Map<String, String> setOptionsSettingsCommandsJSON = {
  'SetOption0':
      'Save power state and use after restart (=SaveState) 0= disable (see note below) 1= enable(default) Note: Power state means on/off state of eg. relays or lights. Other parameters like color, color temperature, brightness, dimmer, etc. are still saved when changed. To disable saving other parameters seeSaveData.',
  'SetOption1':
      'Setbutton multipressmode to 0= allow all button actions(default) 1= restrict to single to penta press and hold actions (i.e., disable inadvertent reset due to long press)',
  'SetOption2':
      'Set display of global temperature/humidity/pressure info to JSON sensor message 0= disable(default) 1= enable',
  'SetOption3': 'MQTT 0= disable MQTT 1= enable MQTT(default)',
  'SetOption4':
      'Return MQTT response as 0= RESULT topic(default) 1= %COMMAND% topic',
  'SetOption8': 'Show temperature in 0= Celsius(default) 1= Fahrenheit',
  'SetOption10':
      'When the device MQTT topic changes 0= remove retained message on old topic LWT(default) 1= send "Offline" to old topic LWT',
  'SetOption11':
      'Swap button single and double pressfunctionality 0= disable(default) 1= enable',
  'SetOption12':
      'Configuration saving to flash option 0= allow dynamic flash save slot rotation(default) 1= use fixed eeprom flash slot',
  'SetOption13':
      'Allow immediate action on single button press 0= single, multi-press and hold button actions(default) 1= only single press action for immediate response (i.e., disable multipress detection). Disable by holding for 4 x button hold time (seeSetOption32).',
  'SetOption15':
      'Set PWM control for LED lights 0= basic PWM control 1= control withColororDimmercommands(default)',
  'SetOption16':
      'Set addressable LED Clock scheme parameter 0= clock-wise mode(default) 1= counter-clock-wise mode',
  'SetOption17':
      'ShowColorstring as 0= hex string(default) 1= comma-separated decimal string',
  'SetOption18':
      'Set status of signal light paired withCO2sensor 0= disable light(default) 1= enable light The light will be green belowCO2_LOWand red aboveCO2_HIGH(transition yellow/orange between). The default levels are: 800ppm for low and 1200ppm for high but these can be set inuser_config_override.h.',
  'SetOption19':
      'Tasmota discovery protocolused in Home AssistantTasmota integration 0= enable Tasmota discovery(default) 1= use deprecated MQTT discovery (only with#define USE_HOME_ASSISTANT, does not exist in release binaries)',
  'SetOption20':
      'Update of Dimmer/Color/CT without turning power on 0= disable(default) 1= enable',
  'SetOption21':
      'Energy monitoring when power is off 0= disable(default) 1= enable',
  'SetOption24': 'Set pressure units 0= hPa(default) 1= mmHg',
  'SetOption26':
      'Use indexes even when only one relay is present 0= messages use POWER(default) 1= messages use POWER1',
  'SetOption28': 'RF received data format 0= hex(default) 1= decimal',
  'SetOption29': 'IR received data format 0= hex(default) 1= decimal',
  'SetOption30':
      'Enforce Home Assistant auto-discovery as light 0= relays are announced as a switch and PWM as a light(default) 1= both relays and PWM are announced as light',
  'SetOption31':
      'Set status LED blinking during Wi-Fi and MQTT connection problems. LedPowermust be set to0for this feature to work 0= Enabled(default) 1= Disabled',
  'SetOption32':
      'Number of 0.1 seconds to hold button before sendingHOLDaction message. 1..100to set button hold time(default =40). This option also affects the time required to perform a firmware defaults reset (10xHOLDaction time). There is no firmware reset on using the HOLD action with shutterbuttons.',
  'SetOption33':
      'Number of seconds for which the maximum power limit can be exceeded before the power is turned off 1..250= set number of seconds(default =5)',
  'SetOption34':
      '0..255= setBackloginter-command delay in milliseconds(default =200)',
  'SetOption36':
      'Boot loop defaults restoration control. 0= disable boot loop control 1..200= set number of boot loops (a restart caused by any exception or watchdog timer within less thanBOOT_LOOP_TIME(default 10 seconds) before beginning to restore settings(default =1). Once this number is reached, subsequent restarts will: 1strestart: disable ESP8285 generic GPIOs interfering with flash SPI 2ndrestart: disable rules causing boot loop 3rdrestart: disable all rules (andautoexec.bat) 4threstart: reset user defined GPIOs to disable any attached peripherals 5threstart: reset module to Sonoff Basic (1)',
  'SetOption38':
      '6..255= set IRReceive protocol detection sensitivity minimizing UNKNOWN protocols',
  'SetOption39':
      'Control handling of invalid power measurements.Read more... 0= reset to default on next restart 1..255= number of invalid power readings before reporting no load(default =128).',
  'SetOption40':
      'Stop detecting input change on the button GPIO. Solves#5449 Active only whenSetOption1 1andSetOption13 0.This disables all long press functionality. 0..250= button hold time in 0.1 seconds after which button functionality is disabled.(default =1) Example:Backlog SetOption1 1; SetOption13 0; SetOption40 10= discard any button press over 1 second',
  'SetOption41':
      '0= Disable ARP <x>= Force sending gratuitous ARP (Wi-Fi keep alive) every<x>seconds(default =60) If<x>is below100it is the number of seconds, if<x>is above100, it is the number of minutes after substracting 100. Ex:105is every 5 minutes, while90is every 90 seconds.',
  'SetOption42':
      '0..255= set over-temperature (Celsius only) threshold resulting in power off on all energy monitoring devices(default =90)',
  'SetOption43': '0..255= to control Rotary step. Details#10407',
  'SetOption44':
      '1..100= set base tolerance percentage for matching incoming IR messages(default =25)',
  'SetOption45':
      '1..250= change bi-stable latching relay pulse length in milliseconds(default =40)',
  'SetOption51':
      'Enable GPIO9 and GPIO10 component selections in Module Configuration WARNINGDo not use on ESP8266 devices! 0= disable(default) 1= enable',
  'SetOption52':
      'Control display of optional time offset from UTC in JSON payloads 0= disable(default) 1= enable',
  'SetOption53':
      'Display hostname and IP address in GUI 0= disable(default) 1= enable',
  'SetOption54':
      'ApplySetOption20settings to commands from Tuya device 0= disable(default) 1= enable',
  'SetOption55': 'mDNS service 0= disable(default) 1= enable',
  'SetOption56':
      'Wi-Fi network scan to select strongest signal on restart (network has to be visible) 0= disable(default) 1= enable',
  'SetOption57':
      'Wi-Fi network re-scan every 44 minutes with alternate to +10dB stronger signal if detected (only visible networks) 0= disable 1= enable(default)',
  'SetOption58': 'IR Raw data in JSON payload 0= disable(default) 1= enable',
  'SetOption59':
      'Sendtele/%topic%/STATEin addition tostat/%topic%/RESULTfor commands:State,Powerand any command causing a light to be turned on. 0= disable(default) 1= enable',
  'SetOption60': 'Set sleep mode 0=dynamic sleep(default) 1= normal sleep',
  'SetOption61':
      'Forcelocal operationwhenButtonTopicorSwitchTopicis set. 0= disable(default) 1= enable',
  'SetOption62':
      'Set retain on Button or Switch hold messages 0= disable(default) 1= dont use retain flag onHOLDmessages',
  'SetOption63':
      'Set relay state feedback scan at restart (#5594,#5663) 0= Scan power state at restart(default) 1= Disable power state scanning at restart',
  'SetOption64':
      'Switch between-or_as sensor name separator 0= sensor name index separator is-(hyphen)(default) 1= sensor name index separator is_(underscore) Affects DS18X20, DHT, BMP and SHT3X sensor names in tele messages',
  'SetOption65':
      'Device recovery usingfast power cycle detection 0= enabled(default) 1= disabled',
  'SetOption66':
      'Set publishing TuyaReceived to MQTT 0= disable publishingTuyaReceivedover MQTT(default) 1= enable publishingTuyaReceivedover MQTT',
  'SetOption69':
      'Deprecatedin favor ofDimmerRange By default Tuya dimmers wont dim below 10% because some dont function very well that way. 0= disable Tuya dimmer 10% lower limit 1= enable Tuya dimmer 10% lower limit(default)',
  'SetOption71':
      'Set DDS238 Modbus register for active energy 0= set primary register(default) 1= set alternate register',
  'SetOption72':
      'Set reference used for total energy 0= use firmware counter(default) 1= use energy monitor (e.g., PZEM-0xx, SDM120, SDM630, DDS238, DDSU666) hardware counter',
  'SetOption73':
      'Detach buttons from relays and send multi-press and hold MQTT messages instead 0= disable(default) 1= enable Example message:{"Button1":{"Action":"SINGLE"}}',
  'SetOption74':
      'Enable internal pullup for single DS18x20 sensor 0= disable(default) 1= internal pullup enabled',
  'SetOption75':
      'Set grouptopic behaviour (#6779) 0= GroupTopic using FullTopic replacing %topic%(default) 1= GroupTopic iscmnd/%grouptopic%/',
  'SetOption76':
      'Boot count incrementing whenDeepSleepis enabled (#6930) 0= disable boot count incrementing(default) 1= enable boot count incrementing',
  'SetOption77':
      'Do not power off if a slider is moved to far left 0= disable(default) 1= enable',
  'SetOption78': 'OTA compatibility check 0= enabled(default) 1= disabled',
  'SetOption79':
      'Reset counters at TelePeriod time 0= disable(default) 1= enable',
  'SetOption80':
      'Blinds and shutterssupport 0= disable blinds and shutters support(default) 1= enable blinds and shutters support',
  'SetOption81':
      'SetPCF8574component behavior for all ports 0= set as regular state(default) 1= set as inverted state',
  'SetOption82':
      'Reduce the CT range from 153..500 to 200.380 to accommodate with Alexa range 0= CT ranges from 153 to 500(default) 1= CT ranges from 200 to 380 (although you can still set in from 153 to 500)',
  'SetOption83':
      'Uses Zigbee device friendly name instead of 16 bits short addresses as JSON key when reporting values and commands 0= JSON key as short address 1= JSON key as friendly name SeeZbName <device>,<name>',
  'SetOption84':
      '''Experimental) When using AWS IoT, sends a device shadow update (alternative to retained) 0= dont update device shadow (default) 1= update device shadow Note: if theTopiccontains'/'they are replaced with'_''',
  'SetOption85': 'Device groupsupport 0= disable(default) 1= enable',
  'SetOption86':
      'PWM Dimmer only!Turn brightness LEDs off 5 seconds after last change 0= disable(default) 1= enable',
  'SetOption87':
      'PWM Dimmer only!Turn red LED on when powered off 0= disable(default) 1= enable',
  'SetOption88':
      'Make each relay part of a separate device group. Relay 1 updates are sent to/received from device group 1, relay 2 updates are sent to/received from device group 2, etc. For the PWM Dimmer module, make each button be associated with a different device group. 0= disable(default) 1= enable',
  'SetOption90':
      'Disable sending MQTT with non-JSON messages 0= send all MQTT(default) 1= send only MQTT messages with JSON payloads',
  'SetOption93':
      'Control caching of compressed rules 0= Disable memory caching of uncompressed rules 1= Keep uncompressed rules in memory to avoid CPU load of uncompressing at each tick(default)',
  'SetOption94':
      'Select MAX31855 or MAX6675 thermocouple support 0= Use MAX31855 protocol(default) 1= Use simpler MAX6675 protocol instead of MAX31855',
  'SetOption97':
      'Set TuyaMCU serial baudrate 0= 9600 bps(default) 1= 115200 bps',
  'SetOption98':
      'Provide rotary dimmer rule triggers 0= disable(default) 1= enable',
  'SetOption99':
      'Enable zero-cross capable AC dimmer 0= no zero-cross AC dimmer connected(default) 1= zero-cross AC dimmer attached. Focus on raising edge and sync frequency',
  'SetOption101':
      'Add Zigbee source endpoint as suffix to attributes 0= disable(default) 1= enable e.g.Power3instead ofPowerif sent from endpoint3.',
  'SetOption103': 'Set TLS mode 0= disable TLS 1= enable TLS',
  'SetOption104':
      'Disable MQTT retained messages (some brokers dont support them) 0= retained messages enabled(default) 1= retained messages disabled',
  'SetOption107':
      'Set virtual CT channel light type (experimental feature) 0= Warm White 1= Cold White',
  'SetOption108':
      '0= Teleinfo telemetry only sent into Energy MQTT JSON(default) 1= Each Teleinfo received frame is also sent by MQTT (mainly to be able to display real time data)',
  'SetOption109':
      '0=(default) 1= force gen1 Alexa mode, for Echo Dot 2nd gen devices only',
  'SetOption113':
      'works only with rotary dial button 0=(default) 1= set dimmer low on rotary dial after power off',
  'SetOption114':
      'Detach switches from relays and send MQTT messages instead 0= disable(default) 1= enable Example result:{"Switch1":{"Action":"ON"}}',
  'SetOption115': 'ESP32 MI32 BLE 0= disable(default) 1= enable',
  'SetOption116': 'Auto-query of lights and devices 1= disable',
  'SetOption117':
      'Run fade at fixed duration instead of fixed slew rate 1= enable',
  'SetOption123': 'Wiegand tag number output in hex format 1= enable',
  'SetOption124':
      'Wiegand key pad stroke format 0= one tag (ending char # or) *(default) 1= one key',
  'SetOption125':
      'ZbBridge onlyHide bridge topic from zigbee topic (use withSetOption89) 1= enable',
  'SetOption126':
      'Enable arithmetic mean over teleperiod for JSON temperature for DS18x20 sensors 1= enable',
  'SetOption127':
      'Force Wi-Fi in no-sleep mode even if Sleep 0 is not enabled 1= enable',
  'SetOption128':
      'Web referrer check for HTTP API commands 0= disabled 1= enabled(default)',
  'SetOption129': 'Enable split total energy results#13030 1= enable',
  'SetOption130':
      'Add heap size (and ESP32 fragmentation) to logging timestamp for debugging 1= enable',
  'SetOption131': '(Tuya) Allow save dimmer = 0 received by MCU 1= enable',
  'SetOption132':
      'When MQTT TLS is enabled, forces fingerprint validation of server identity instead of checking the identify against a certificate authority (CA) 1= Fingerprint,0= CA',
  'SetOption134':
      'PWM force phases to be synced (ESP32 only). On ESP32, PWM phases are by default distributed one after the other to minimize effect on power supply. This is also mandatory for H-Bridge devices. 0= phases are automatically aligned one after the other,1= phases all start at the same time (default behavior for ESP8266).',
  'SetOption135':
      'Disables Display Splash screen (for all drivers, universal & LVGL) 1= Splash screen disabled,0= Splash screen displayed',
  'SetOption136':
      '1= Disable single sensor reports from Tuya devices while keeping teleperiod reports 0= Publish an immediatetele/%topic%/SENSORTuyaSNS message at each reception of individual value(default)',
  'SetOption137':
      '1= following Tuya responses will not be forwarded to MQTT whenSetOption66is enabled - heartbeat every 10 seconds,TUYA_CMD_HEARTBEAT - the WiFi state during start-up and Wi-Fi events,TUYA_CMD_WIFI_STATE - the local time info query of the MCU every minute,TUYA_CMD_SET_TIME - the received update package info from MCU during firmware update of Tuya MCU,TUYA_CMD_UPGRADE_PACKAGE',
  'SetOption138':
      'Align GUI energy multicolumn layout in webUI 0= left/center(default) 1= right',
  'SetOption139':
      'WhenSetOption24 1switch pressure unit to: 0= mmHg(default) 1= inHg',
  'SetOption140':
      '0= open clean MQTT session(default) 1= open persistent MQTT session',
  'SetOption141': '1= disable display of model name in webUI header',
  'SetOption142':
      '1= wait 1 second for WiFi connection solving some FRITZ!Box modem issues',
  'SetOption143':
      '1= disables ZigBee auto-probing and configure back attribute reporting',
  'SetOption144': '1= include a timestamp inZbReceivedmessages',
};

Map<String, String> tuyaMCUSettingsCommandsJSON = {
  'TuyaEnum<x>':
      'Send value to an Enum (fnId 61, 62, 63 and 64) where<x>= number of Enum <value>= must be from a range set inTuyaEnumList',
  'TuyaEnumList':
      'Declare the range an Enum (fnId 61, 62, 63 and 64) must respect (0 is always the first item in range) <enum>,<range>=<enum>isEnum<x>declared using TuyaMCU and<range>can be0..31 Without payload returns the configuration of all the Enums',
  'TuyaMCU':
      'Used to map functions in TuyaMCU <fnId>,<dpId>=read more... <fnId>,0= remove setting for fnId',
  'TuyaRGB':
      'Set correct format of color reporting by tuyaMCU 0- Type 1, 12 characters uppercase. Example:00DF00DC0244(default) 1- Type 1, 12 characters lowercase. Example:008003e8037a 2- Type 2, 14 characters uppercase. Example:00FF00FFFF6464 3- Type 2, 14 characters lowercase. Example:00e420ffff6464',
  'TuyaSend<x>':
      'Send data to MCU withTuyaMCU x =0..4,8 TuyaSend0= send a query command to the MCU TuyaSend1 <dpId>,<boolean>= send boolean (0/1) data type to dpId (1 byte max length) TuyaSend2 <dpId>,<int>= send integer data to dpId (4 bytes max length) TuyaSend2 <dpId>,<0xAABBCCDD>= send 4 byte data to dpId (4 bytes max length) TuyaSend3 <dpId>,<value>= send an ASCII string to dpId (unknown max length) TuyaSend4 <dpId>,<enum>= send enumerated (0/1/2/3/4/5) data type to dpId (1 byte max length) TuyaSend5 <dpId>,<value>= send an HEX string to dpId -0xprefix NOT needed - (unknown max length) TuyaSend6 <dpId>,<value>= send an HEX raw value to dpId -0xprefix NOT needed, but will be processed correctly - (unknown max length) TuyaSend8= request dpId states if supported',
  'TuyaTempSetRes':
      'Set resolution only for Tuya Set Temperature sensor (fnId 72). 0..3= maximum number of decimals shown',
};

Map<String, String> serialBridgeSettingsCommandsJSON = {
  'Baudrate':
      '1= set hardware serial bridge to default baud rate of 115200 bps <value>= set baud rate. The set rate will be a multiple of 300. The maximum baud rate possible is 19,660,500.',
  'SBaudrate':
      '1= set software serial bridge to default baud rate of 9600 bps <value>= set baud rate. The set rate will be a multiple of 300. The maximum baud rate possible is 19,660,500.',
  'SerialBuffer':
      '256..520= set the serial buffer size. This option willnot be persisted, usea rule with a triggerlikePower1#Bootwhen you want this to survive a reboot. Sometimes,serial buffer overrunscan be mitigated by setting this to a large value such as520.',
  'SerialConfig':
      'value= set serial protocol usingdata/parity/stopconventional notation (example:8N1or702) 0..23= set serial protocol (3equals8N1)',
  'SerialDelimiter':
      '<value>= set serial delimiter toescape character codeor ASCII character 1..127= set serial delimiter todecimal ASCII 128= only allow ASCII characters 32 to 127 in response text 254= disable serial delimiter & post HEX string 129..253or255= disable serial delimiter (default = 255)',
  'SerialSend<x>':
      '<string> Disable serial logging and send using hardware serial x =1..5 1= send appending\n(newline) () 2= send 3= replace escape characters and send 4= send as binary. Data in serial response messages is encoded as binary strings 5= send as hex. Data in serial response messages is encoded as hex strings 6= send as comma-delimited string of decimal numbers',
  'SSerialConfig':
      'value= set serial protocol usingdata/parity/stopconventional notation (example:8N1or702) 0..23= set serial protocol (3equals8N1)',
  'SSerialSend<x>':
      '<string> Send using software serial protocol x =1..5 1= send appending\n(newline) () 2= send 3= replace escape characters and send 4= send as binary data. Data in serial response messages is encoded as binary strings 5= send as hex. Data in serial response messages is encoded as hex strings 6= send as comma-delimited string of decimal numbers 9= enable Serial Bridge console Tee for debugging purposes (payload1to enable)',
};

Map<String, String> rfBridgeSettingsCommandsJSON = {
  'RfCode':
      'Show last sent 24-bit user code 1..8388607= send 24-bit user code #1..#7FFFFF= send 24-bit hexadecimal user code using RfSync, RfLow and RfHigh timing',
  'RfHigh':
      '1= reset high pulse time to 840 microseconds 2..32767= set high pulse time in microseconds #2..#7FFF= set high pulse time in hexadecimal microseconds',
  'RfHost':
      'Show 16-bit host part of user code 1= reset 16-bit host part of user code to 11802 (#2E1A) 2..32767= set 16-bit host part of user code #2..7FFF= set 16-bit host part of user code in hexadecimal',
  'RfKey<x>':
      'Send learned or default RF data for RfKey<x> (x =1 – 16) 1= send default RF data for RfKey<x> using RfSync, RfLow, RfHigh and RfHost parameters 2= learn RF data for RfKey<x> 3= unlearn RF data for RfKey<x> 4= save RF data using RfSync, RfLow, RfHigh and last RfCode parameters 5= show default or learned RF data 6= send learned RF data',
  'RfLow':
      '1= reset low pulse time to 270 microseconds 2..32767= set low pulse time in microseconds #2..#7FFF= set low pulse time in hexadecimal microseconds',
  'RfRaw':
      'This command only works when the firmware has been updated withPortisch firmware.Refer to thePortisch wikifor details. Learning and Decoding RF Codes with Portisch Firmware 0= Set iTead default firmware support and messages(default on restart) 1= set Portisch firmware support and messages 166orAAA655= start sniffing/reading RF signals disabling iTead default RF handling 167orAAA755= stop sniffing/reading RF signals enabling iTead default RF handling 168orAAA855= transmitting iTead default RF protocols 169orAAA955= start sniffing and learning predefined protocols 176orAAB055= bucket Transmitting using command 0xB0 177orAAB155= start Bucket sniffing using command 0xB1 192orAAC000C055= beep (00C0is the length of the sound) 255orAAFF55= show Rf firmware version (result AA02FF means Version 02) <value>= hexadecimal data to be sent to RF chip. This must be immediately followed by theRfRaw 0command (e.g.,Backlog RfRaw <value>; RfRaw 0',
  'RfSync':
      '1= reset start sync pulse time to 8470 microseconds 2..32767= set start sync pulse time in microseconds #2..#7FFF= set start sync pulse time in hexadecimal microseconds',
  'RfTimeout':
      'change timeout inRfReceive 100..60000= disable duplicate RfReceive (default=1000)',
};

Map<String, String> rfTransceiverSettingsCommandsJSON = {
  'RFsend':
      '<value>= code decimal or JSON. Data value is required and can be decimal or hexadecimal (using the 0x prefix), other values are optional.  JSON {"Data":"<value>","Bits":<value>,"Protocol":<value>,"Pulse":<value>} "Data":"<value>"= hexadecimal code "Bits":<value>= required number of data bits(default =24) "Protocol":<value>= protocol number(default =1) "Repeat":<value>= repeat value(default =10) "Pulse":<value>= pulse value(350= default for protocol 1)  e.g.,RFsend {"Data":"0x7028DC","Bits":24,"Protocol":1,"Pulse":238}  Decimal data, bits, protocol, repeat, pulse  e.g.,RFsend 7350492, 24, 1, 10, 238orRFsend 0x7028DC, 24, 1, 10, 238'
};
Map<String, String> rfRemoteSettingsCommandsJSON = {
  'IRsend<x>':
      'Send an IR remote control code as a decimal or hexadecimal string in a JSON payload. In order to send IR data,you must configure at least one of the free device GPIOs asIRsend (8). GPIO01 nor GPIO03 can be used. <x>[optional] = number of times the IR message is sent. If not specified or0..1, the message is sent only once (i.e., not repeated)(default) >1= emulate a long-press on the remote control, sending the message<x>times, or sending a repeat message for specific protocols (like NEC)  {"Protocol":"<value>","Bits":<value>,"Data":<value>, "Channel":<value>}  "Protocol"(select one of the following): "NEC" "RC5" "RC6" "Bits":1..32= required number of data bits for PANASONIC protocol this parameter is the the address, not the number of bits  "Data":1..(2^32)-1= data frame as 32 bit decimal. e.g.,IRsend {"Protocol":"NEC","Bits":32,"Data":2170978686} or "Data":0x1..0xFFFFFFFF= data frame as 32 bit hexadecimal. e.g.,IRsend {"Protocol":"NEC","Bits":32,"Data":0x8166817E} "Channel":1..16= IRSend GPIO to be used to send the message.  Alternatively, you can send IR remote control codes usingRAW command encoding.  Read more...',
  'IRhvac':
      'Send HVAC IR remote control code as JSON payload  IRHVAC {"Vendor":"Mitsubishi_Heavy_152", "Power":"On","Mode":"Hot","FanSpeed":3,"Temp":22.5}  "Protocol"or"Vendor"(select one of the following): COOLIX, DAIKIN, KELVINATOR, MITSUBISHI_AC, GREE, ARGO, TROTEC, TOSHIBA_AC, FUJITSU_AC, MIDEA, HAIER_AC, HITACHI_AC, HAIER_AC_YRW02, WHIRLPOOL_AC, SAMSUNG_AC, ELECTRA_AC, PANASONIC_AC, DAIKIN2, VESTEL_AC, TECO, TCL112AC, MITSUBISHI_HEAVY_88, MITSUBISHI_HEAVY_152, DAIKIN216, SHARP_AC, GOODWEATHER, DAIKIN160, NEOCLIMA, DAIKIN176, DAIKIN128  "Model":Some HVAC have variants in protocols, this field allows to specify the variant, seedetailed list. Fujitsu_AC:ARRAH2E|ARDB1 Panasonic_AC:LKE|NKE|DKE|JKE|CKP|RKR Whirlpool_AC:DG11J13A|DG11J104|DG11J1-04|DG11J191 "Power": On, Yes, True, 1 Off, No, False, 0 "Mode": Off, Stop Auto, Automatic Cool, Cooling Heat, Heating Dry, Drying, Dehumidify Fan, Fanonly, Fan_Only "FanSpeed": Auto, Automatic Min, Minimum, Lowest, 1 Low, 2 Med, Medium, Mid, 3 High, Hi, 4 Max, Maximum, Highest, 5 "SwingV": vertical swing of Fan Auto, Automatic, On, Swing Off, Stop Min, Minimum, Lowest, Bottom, Down Low Mid, Middle, Med, Medium, Centre, Center High, Hi Highest, Max, Maximum, Top, Up "SwingH": horizontal swing of Fan Auto, Automatic, On, Swing Off, Stop LeftMax, Left Max, MaxLeft, Max Left, FarLeft, Far Left Left Mid, Middle, Med, Medium, Centre, Center Right RightMax, Right Max, MaxRight, Max Right, FarRight, Far Right Wide "Celsius": temperature is in Celsius ("On") of Farenheit ("Off") "Temp": Temperature, can be float if supported by protocol "Quiet": Quiet mode ("On"/"Off") "Turbo": Turbo mode ("On"/"Off") "Econo": Econo mode ("On"/"Off") "Light": Light ("On"/"Off") "Filter": Filter active ("On"/"Off") "Clean": Clean mode ("On"/"Off") "Beep": Beep active ("On"/"Off") "Sleep": Timer in seconds "StateMode": SendOnly(default) StoreOnly SendStore'
};

Map<String, String> displaySettingsCommandsJSON = {
  'Display': 'Show current display setting as a JSON payload',
  'DisplayAddress': '0..255Set display module address',
  'DisplayDimmer':
      '0= Turn the display off 1..100= Set display luminosity(only on 8x8 Dot-Matrix displays) 13..100maps to1..7levels of brightness forTM1637, TM1638 and MAX7219seven-segment display modules',
  'DisplayInvert': '1- Invert display where implemented.More info...',
  'DisplayMode':
      '0..5Set to displaypredefined contentaccording to display type 0..3forTM1637, TM1638 and MAX7219seven-segment display modules',
  'DisplayModel':
      'Set display model: 1=I2C LCD Display(default addresses0x27,0x3F) 2=SSD1306OLED 128x32/128x64/68x48 (default I2C addresses0x3C,0x3D) 3=HT16K338x8 Dot-Matrix 4=ILI9341TFT LCD 5=2.9 inch E-Paper Display296x128 (software 3-wire SPI) 6=4.2 inch E-Paper Display400x300 (software 3-wire SPI) 7=SH1106OLED 128x64 (default I2C address0x3c) 8=ILI9488TFT 480x320 (capacitive touch, hardware 3-wire SPI) 9=SSD1351color OLED 128x128 (hardware 3-wire SPI) 10=RA8867TFT LCD 1024x600 (capacitive touch, hardware 4-wire SPI) 15=TM16377-segment, 4-,6- and 8-digit displays (TM1637, TM1638 and MAX7219), hardware 2- and 3-wire I2C-like interface 16=LilyGO T5-4.7E-Paper display board 17=Universal Display Driverpowered displays',
  'DisplayRefresh':
      '1..7Set time in seconds to update predefined content when usingDisplayMode≠0',
  'DisplaySize': '1..4Set display scale-up size(SSD1306 and ILI9341 only)',
  'DisplayRotate': 'Set rotation angle 0= 0° 1= 90° 2= 180° 3= 270°',
  'DisplayText':
      '<value>= SeeDisplayText use For TM1637, TM1638 and MAX7219, and for (TM1637, TM1638 and MAX7219)			text[,position[,length]] Clears and then displays basic text on the 7-segment display.  lengthcan be1toNUM_DIGITS, positioncan be0(left-most) toNUM_DIGITS-1(right-most)  A caret(^) symbol in the text input is displayed as the degrees(°) symbol. This is useful for displaying Temperature (or angle)! SeeTM163xfor details.',
  'DisplayTextNC':
      '(TM1637, TM1638 and MAX7219)			text[,position[,length]] Clears first, then displays text. Usage is same as above. SeeTM163xfor details.',
  'DisplayType':
      'Select display sub-modules.More info... For usage of this command with TM163x, seeTM163xfor details.',
  'DisplayCols': '1..44Set number of display columns(for display modes>0)',
  'DisplayRows': '1..32Set number of display rows(for display modes>0)',
  'DisplayFont':
      'Specify the current font 0use classic GFX font 1= 12 2= 24 3= 8 (opt) 7use RA8876 internal font',
  'DisplayWidth':
      'Specify the display width in pixels(SSD1306 only) -or- Specify number of digits inTM163xseven-segment display module',
  'DisplayHeight': 'Specify the display height in pixels(SSD1306 only)',
  'DisplayClear':
      '(TM1637, TM1638 and MAX7219)			Clears the display. SeeTM163xfor details.',
  'DisplayNumber':
      '(TM1637, TM1638 and MAX7219)			num[,position[,leading_zeros[,length]]] Clears and then displays numbernumwithout decimal.  leading zeroscan be1or0(default), lengthcan be1toNUM_DIGITS(4 or 6), positioncan be0(left-most) toNUM_DIGITS(right-most). SeeTM163xfor details.',
  'DisplayNumberNC':
      '(TM1637, TM1638 and MAX7219)			num[,position[,leading_zeros[,length]]] Display integer number as above, but without clearing first. Usage is same as above. SeeTM163xfor details.',
  'DisplayFloat':
      '(TM1637, TM1638 and MAX7219)			num[,position[,precision[,length]]] Clears and then displays float (with decimal point).  precisioncan be0toNUM_DIGITS(default), lengthcan be1toNUM_DIGITS(4 or 6), positioncan be0(left-most) toNUM_DIGITS(right-most). SeeTM163xfor details.',
  'DisplayFloatNC':
      '(TM1637, TM1638 and MAX7219)			num[,position[,precision[,length]]] Displays float (with decimal point) as above, but without clearing first. Usage same as above. SeeTM163xfor details.',
  'DisplayRaw':
      '(TM1637, TM1638 and MAX7219)			position,length,num1[,num2[,num3[,num4[, ...uptoNUM_DIGITSnumbers]]...] Takes uptoNUM_DIGITScomma-separated integers (0-255) and displays raw segments.  lengthcan be1toNUM_DIGITS(4 or 6), positioncan be0(left-most) toNUM_DIGITS(right-most). num1,num2, ... are numbers representing a 7-segment digit. Each number represents all segments of one digit. Segment a=1, b=2, c=4, d=8, e=16, f=32, g=64 and h (decimal point)=128. To turn on all segments, the number would be 1+2+4+8+16+32+64+128 = 255. SeeTM163xfor details.',
  'DisplayScrollText':
      '(TM1637, TM1638 and MAX7219)			text[,num_iterations] Displays scrolling text, upto 50 characters. Ifnum_iterationsis not specified, it scrolls indefinitely, until anotherDisplay-command is issued. Optionally, specifyingnum_iterationscauses the scrolling to stop after the specified number of iterations. SeeTM163xfor details.',
  'DisplayScrollDelay':
      '(TM1637, TM1638 and MAX7219)			0..15Sets the speed of text scroll. Smaller delay implies faster scrolling.  SeeTM163xfor details.',
  'DisplayLevel':
      '(TM1637, TM1638 and MAX7219)			0..100Display a horizontal bar graph.  SeeTM163xfor details.',
  'DisplayClock':
      '(TM1637, TM1638 and MAX7219)			Displays a clock. 1= displays a clock in 12-hour format. 2= displays a clock in 24-hour format. 0= turns off the clock and clears the display SeeTM163xfor details.',
};

Map<String, String> shuttersSettingsCommandsJSON = {
  'ShutterMode<x>':
      '			1..5(default =0) Defines the mode the shutter will operates the relays, steppers and/or servos. 0=autodetect based on INTERLOCK and GPIO defined. STATUS 13 show the mode. 1=normal two relay up/off down/off. 2=two relay on/off up/down. 3=one relay garage mode. 4=one relay plus stepper motor. 5=one relay and position servo.',
  'ShutterButton<x>':
      '			<button> <func> <mqtt>  Assign a button to control the shutter. For more details please refer toBlinds and Shutterssupport  <button>  0: disable buttons for this shutter  1..4: Button number <func>up/down/updown/toggle: function to assign to the button <mqtt>1/0: enable/disable MQTT publish for button hold action  For example: To control shutter #1 by two buttons:Backlog ShutterButton1 1 up 1; ShutterButton1 2 down 1assigns button #1 to act as an "up" button (1x press open, 2x press 50% position, 3x press 74% position) and button #2 to act as an "down" button (1x press close, 2x press 50% position, 3x press 24% position) for shutter #1 including MQTT publish. To control shutter #1 by a single button:ShutterButton1 1 updown 0assigns button #1 to act as an "up and down" button (1x press up, 2x press down). To control shutter #1 by a single button:ShutterButton1 1 toggle 0assigns button #1 to act as a "toggle" button (1x press toggle, 2x press 50% position).',
  'ShutterCalibration<x>':
      '			Granular shutter position calibration. The measured opening position of the shutter at the 30, 50, 70, 90, and 100 percent opened locations. For example:ShutterCalibration<x> 23 38 56 74 82',
  'ShutterChange			':
      '-100..100Moves the shutter from the current position relatively in %. If the resulting position is below 0 or above 100 it will be capped. Command can also be executed during movement and will change the target position.',
  'ShutterCloseDuration<x>':
      '			1.0 ..240.0(default =10.0) time, in seconds, it takes to fully close the shutter. A fraction of a second can be specified (e.g.45.7).',
  'ShutterClose<x>':
      '			Engage the relay to close the shutter. This action can be requested at any time. Number of shutter can be the index or the argument',
  'ShutterFrequency<x>':
      '			0..10,000Hz(default =1000) the maximum frequency at which the stepper motor can operate reliably. Typically this is up to 2,000Hz with a 12V power supply and up to 5,000Hz with a 24V power supply.',
  'ShutterEnableEndStopTime<x>':
      '			0= no additional shutter end stop time(default) 1= 1 s additional shutter end stop time',
  'ShutterInvert<x>':
      '			0= use default shutter positioning (0= Closed,100= Open) 1= invert shutter positioning (100= Closed,0= Open) (e.g., if used with KNX)',
  'ShutterInvertWebButtons<x>':
      '			0= use default button icons (▲ for open, ▼ for close) 1= invert button icons (▼ for open, ▲ for close) (e.g., if used with horizontal awning: where open means rolling-down fabric material and close rolling-up in a protect position)',
  'ShutterLock<x>':
      '			0= unlock shutter positioning(default) 1= lock shutter positioning',
  'ShutterMotorDelay<x>':
      '			-12.75 .. 12.75(default =0) time, in seconds, it takes the motor to start moving once power is turned on; i.e., motor lag time. You can use negative numbers if your motor stops to late after power OFF  When used with stepper motors, this setting defines the ramp up/down speed (i.e., acceleration/deceleration) before the motor reaches its target speed for gradual starting and stopping. In this case only positive numbers are allowed.',
  'ShutterOpenDuration<x>':
      '			1.0 ..240.0(default =10.0) time, in seconds, it takes to fully open the shutter. A fraction of a second can be specified (e.g.45.7).',
  'ShutterOpen<x>':
      '			Engage the relay to open the shutter. This action can be requested at any time. Number of shutter can be index or the argument',
  'ShutterPosition<x>':
      '			0..100,UP,OPEN,DOWN,CLOSE,STOP,TOGGLE,TOGGLEDIR,, A shutter position change can be requested at any time. The shutter will stop and revert or update to the requested position. The shutters actual position will be savedafterthe movement is completed. In this case, the position will be restored during reboot. An interruption during shutter movement (e.g., a device restart) will lose the current position.',
  'ShutterPWMRange<x>':
      '			0..1023,0..1023 For servo motors the min and max position is defined by the length of the duty cycle signal. Because every servo is different the min and max PWM value must be set for each servo type. The value is also dependant on thePWMfrequency. Servos normally use50..200asPWMfrequency.',
  'ShutterRelay<x>':
      '			<value> 0= disable this and all higher numbered shutters Relay<value>component used to open the shutter. This relays mate, the next higher numbered relay, closes the shutter. Depending on the shutter mode, the relays may need to be interlocked using theInterlockcommand. TheShutterRelaycommand must be executed first before any other shutter commands forShutter<x>can be executed.',
  'ShutterSetClose<x>':
      '			shutter closed position.ShutterPositionwill be reset to fully closed value (e.g.,0whenShutterInvert = 0,100otherwise). This does not work with Servos. min and max of servos are always defined throughShutterPWMRange.',
  'ShutterSetOpen<x>':
      '			shutter opened position.ShutterPositionwill be reset to fully opened value (e.g.,100whenShutterInvert = 0,0otherwise). This does not work with Servos. min and max of servos are always defined throughShutterPWMRange.',
  'ShutterSetHalfway<x>':
      '			0..100(default =50) Define shutter half open position (in percent)',
  'ShutterStop<x>':
      '			Disengage the relays to stop the shutter. Number of shutter can be the index or the argument',
  'ShutterStopClose<x>':
      '			Stop the shutter when currently moving, close it otherwise',
  'ShutterStopOpen<x>':
      '			Stop the shutter when currently moving, open it otherwise',
  'ShutterStopPosition<x>':
      '			Stop the shutter when currently moving, set it to position0..100,UP,DOWN,STOP,TOGGLEotherwise',
  'ShutterStopToggle<x>':
      '			Stop the shutter when currently moving, doShutterToggleotherwise',
  'ShutterStopToggleDir<x>':
      '			Stop the shutter when currently moving, doShutterToggleDirotherwise',
  'ShutterToggle<x>':
      '			Toggle the shutter - close the shutter when its position is >50, open it otherwise',
  'ShutterToggleDir<x>':
      '			Toggle the shutter - close the shutter when it previously moved to open, open it otherwise',
  'ShutterTiltConfig<x>':
      '			<min> <max> <Tiltduration> <openposition> <closeposition>(default =0 0 0 0 0) Configure the tilt for venetian blinds. Min/man values must be in the range of -90° to 90°. Open and Close position must be part of the defined range between min and max. Tiltduration defines the time the shutter needs to change the tilt from min to max value. This time has to been multiplied by 20. E.g. 1.2sec = 1.2 x 20 = 24. Example defines tilt on shutter 2:shuttertiltconfig2 -90 90 24 0 90',
  'ShutterTilt<x>':
      '			Set the tilt position<value>(between min and max),OPEN,CLOSE. Definition please seeshuttertiltconfig',
  'ShutterTiltChange<x>':
      '			-100..100Moves the shuttertilt from the current position relatively in %. If the resulting tilt is below min or above max it will be capped. Command can also be executed during movement and will change the tilt at target position.',
};

Map<String, String> zigbeeSettingsCommandsJSON = {
  '<device>':
      'As<device>in following commands you can use interchangeably: <shortaddr>= short address of the Zigbee device on the network, example:0x1234 <longaddr>= permanent IEEE address of the Zigbee device (64 bits), example:0x00158D00041160C5 <index>= number of the device in the internal list (starts at 1), ideal for enumerating devices, example:3for third device in the list <name>= friendly name.Only when previously set withZbName',
  'ZbBind':
      'Binds one Zigbee device to another device or to a group. This allows one device to directly send commands (f.e. a remote to a bulb) without any action on the coordinator. Command structure:{"Device":"<device>", "Endpoint":<endpoint>, "Cluster":<cluster>, "ToDevice":"<to_device>", "ToEndpoint":<to_endpoint>, "ToGroup":<to_group> } <device>= device sending messages(mandatory) <endpoint>= source endpoint(mandatory) <cluster>= source cluster id(mandatory) <to_device>= target device (optional) <to_endpoint>= target endpoint  (optional if it can be inferred fromZbStatus3) <to_group>= target group id (optional) You must specify either"ToDevice"or"ToGroup"but not both Zigbee2Tasmota must know the IEEE address of target device, seeZbStatus2to verify andZbProbeto have Zigbee2Tasmota query the address (EZSP ZBBridge only) If you bind devices to groups you should also use ZbListen to that group, otherwise MQTT messages will not be published',
  'ZbBindState<x>':
      'Asks the device for its internal binding states <device>the device to query <n>the start index for the request,1is the default. This is used to scan through all bindings.',
  'ZbCIE':
      'Configure on the ZigBee device the CIE address using the IEEE address of the ZigBee Bridge. The ZigBee Bridge will act as the CIE device for the ZigBee Network. See IAS Cluster in the ZigBee specification for more information. Usage: ZbCIE <device>,<endpoint> <device>is the ZigBee device to configure <endpoint>is the endpoint in the ZigBee device where the IAS Cluster is. Example: ZbCIE 1,44',
  'ZbEnroll':
      'Enroll the the ZigBee device to the ZigBee Bridge for reporting security sensors data, panels, etc. The ZigBee Bridge will act as the CIE device for the ZigBee Network. Usage: ZbEnroll <device>,<endpoint> <device>is the ZigBee device to configure <endpoint>is the endpoint in the ZigBee device where the IAS Cluster is. Example: ZbEnroll 1,44',
  'ZbConfig':
      'display the current Zigbee configuration Example or result:{"ZbConfig":{"Channel":11,"PanID":"0x1A63","ExtPanID":"0xCCCCCCCCCCCCCCCC","KeyL":"0x0F0D0B0907050301","KeyH":"0x0D0C0A0806040200"}}',
  'ZbConfig<json>':
      'change the configuration and restart if any change was applied.Warning: change in configuration causes a reset of the CC2530/ZBBridge and requires devices to be re-paired. "Channel":<channel>: Zigbee radio channel (11-26) "PanID":<panid>: identifier of the Zigbee Network "ExtPanID":<extpanid>: unique identifier of the Zigbee Network (ExtPanID features are not supported in Z2T but this parameter needs to be set) "KeyL":<key_l>,"KeyH":<key_h>: 128 bits encryption key, split into 2 64 bits values (Low and High) "TXRadio":<txradio>: radio power in dBm (1-20) only for ZBBridge All parameters are optional and only the ones specified are changed. The command always displays the complete configuration after the change Example of command:ZbConfig {"Channel":22,"PanID":"0x1A69","ExtPanID":"0xDDCCCCCCCCCCCCCC","KeyL":"0xFF0D0B0907050301","KeyH":"0xED0C0A0806040200"} The following command creates a highly secure Network key based on a hardware random generator: ZbConfig {"KeyL":"","KeyH":""}',
  'ZbData': 'feature in development',
  'ZbDeviceTopic':
      'SetOption89 Configure MQTT topic for Zigbee devices (also seeSensorRetain) 0= singletele/%topic%/SENSORtopic(default) 1= unique device topic based on Zigbee device ShortAddr Example:tele/Zigbee/5ADF/SENSOR = {"ZbReceived":{"0x5ADF":{"Dimmer":254,"Endpoint":1,"LinkQuality":70}}}',
  'EndpointTopic':
      'SetOption101			Add Zigbee source endpoint as suffix to attributes 0= disable(default) 1= enable e.g.Power3instead ofPowerif sent from endpoint3.',
  'ZbEndpointSuffix':
      'SetOption120			Add the Zigbee endpoint as suffix in topic when usingSetOption89 1 0= disable(default) 1= enable',
  'ZbForget':
      'Used for devices that are unused but still visible inZbStatus <device>= Remove a device from the Tasmota flash memory. It does not un-pair the device nor deleting the device information in the CC2530/ZBBridge.',
  'ZbLight':
      'Sets or reads the light type to be emulated in Zigbee Hue Emulation with Alexa. <device>,<light_type>sets the light type using an integer0..5corresponding to the number of channels (from one channel (on/off) to 5 channel (RGBCCT) lights) <device>,-1removes the device from Philips Hue emulation <device>displays the current status of the Light (Zigbee2Tasmota tracks all changes to the light)',
  'ZbListen<x>':
      '<group>			(EZSP ZBBridge only)Listens to a multicast group address. By default EZSP will not report group messages unless you subscribe to the group. <x>: slot in the array of group addresses, 1..15 <group>: group address to listen to, 0..0xFFFF At start-up, Z2T automatically listens to group 0 in slot 0. CC2530 does not need this command and always report all group messages.',
  'ZbLeave':
      '<device>= request a device to leave the network. If the device is offline or sleeping, this will have no effect. It is not 100% guaranteed that the device will never connect again',
  'ZbInfo':
      '<device>= display all information known about a device, equivalent toZbStatus3with a simpler JSON output',
  'ZbMap<x>':
      'Asks the device for its view of the Zigbee topology <device>the device to query <n>the start index for the request,1is the default. This is used to scan through all values since devices usually return only 3 values per request.',
  'ZbName':
      'Sets or reads the Zigbee device friendly name (up to 32 characters). <device>,<name>sets the new friendly name <device>,(empty name) clears the friendly name <device>displays the current friendly name Also seeSetOption83 1to enable friendly names as JSON keys instead of ShortAddr.',
  'ZbNameKey':
      'SetOption83			Uses Zigbee device friendly name instead of 16 bits short addresses as JSON key when reporting values and commands 0= JSON key as short address 1= JSON key as friendly name SeeZbName <device>,<name>',
  'ZbNameTopic':
      'SetOption112			0=(default) 1= use friendly name in Zigbee topic (use withZbDeviceTopic)',
  'ZbNoAutoBind':
      'SetOption110			0=(default) 1= disable Zigbee auto-binding and auto-attribute reporting when pairing a new device. Use only if you want to manually configure devices',
  'ZbNoPrefix':
      'SetOption100			remove ZigbeeZbReceivedvalue from{"ZbReceived":{xxx:yyy}}JSON message 0= disable(default) 1= enable',
  'ZbOccupancy':
      'Configure the time-out after"Occupancy":1to send a synthetic"Occupancy":0for Zigbee motion sensors <device>,<x>- set occupancy timeout for<device> Possible values for<x> 0: no time-out, the device actually generates "Occupancy":0 n: the number of seconds. The possible values are 15, 30, 45, 60, 75, 90, 105, 120. If the number is different, it is rounded up -1: apply the default of 90 seconds',
  'ZbOmitDevice':
      'SetOption119			Remove device addr from JSON payload 0= disable(default) 1= enable',
  'ZbPermitJoin':
      'Sets pairing mode for new device discovery 0= disable pairing mode 1= enable pairing mode for 60 seconds 99= enable pairing until device reboots (CC2530 only) Leaving Zigbee network open to join will allow any Zigbee device to connect and retrieve your network encryption key. This can lead to a compromise of your Zigbee network.',
  'ZbPing':
      '<device>= test availability of Zigbee device. If the device is connected and not sleeping, you should receive aZbPingmessage within the next second. Example:ZbPing 0x5ADFresponds with: {"ZbPing":{"Device":"0x5ADF","IEEEAddr":"0x90FD9FFFFE03B051"}}',
  'ZbReceivedTopic':
      'SetOption118			Move ZbReceived from JSON message into the subtopic replacing "SENSOR" default 0= disable(default) 1= enable',
  'ZbSend':
      'Command structure:{"Device":"<shortaddr>", "Endpoint":"<endpoint>", "Manuf":<manuf>, "Send":{"<sendcmd>":<sendparam>}} <shortaddr>= short address of the Zigbee device on the network <endpoint>= target endpoint on the device (understanding endpoints) <manuf>= (optional) forces a specific ManufacturerId in the ZCL frame (required by some Xiaomi devices) "<sendcmd>":<sendparam>= command and parameters to send (Zigbee Device Commands) _UseZbZNPSendto send a raw form low-level message on CC253x gateways _ Example:ZbSend { "Device":"0x1234", "Endpoint":"0x03", "Send":{"Power":"on"} }',
  'ZbScan': 'Do an energy scan on each radio channel',
  'ZbStatus<x>':
      'Display Zigbee devices seen on the network since boot <device>(optional) = all devices This command provides three levels of increasing detail according to<x> ZbStatus1Display Short Address, and Friendly Name ZbStatus2Also include Manufacturer ID and Model ID ZbStatus3Also include a list of endpoints and the clusterIds supported by each endpoint Example:ZbStatus3 1requests all details for device number 1 Requested information may exceed maximum result size allowed by Tasmota. In this case, the output will be truncated. To get all of the desired information, request results for a specific device individually.',
  'ZbUnbind':
      'Unbinds one Zigbee device from another or from a group. {"Device":"<device>", "Endpoint":<endpoint>, "Cluster":<cluster>, "ToDevice":"<to_device>", "ToEndpoint":<to_endpoint>, "ToGroup":<to_group> } <device>= the device sending the messages(mandatory) <endpoint>= the source endpoint(mandatory) <cluster>= the source cluster id(mandatory) <to_device>= the target device (optional) <to_endpoint>= the target endpoint (optional if it can be inferred fromZbStatus3) <to_group>= the target group id (optional) You must specify either"ToDevice"or"ToGroup"but not both Zigbee2Tasmota must know the IEEE address of the target device, useZbStatus2to verify andZbProbeto query the address.',
};

Map<String, String> zigbeeDebugSettingsCommandsJSON = {
  'ZbModelId':
      'Manually force theModelIdfield of a Zigbee device. This is used to simulate devices not physically present on the network, for debugging only. <device>,<modelid>= set new ModelId <device>,= (empty ModelId) clear ModelId <device>= display current ModelId (also displayed inZbStatus2)',
  'ZbProbe':
      '<device>= probe a Zigbee device to get additional information including its IEEEaddress, vendor and model names, endpoints, and supported clusters per endpoint. Device probe is performed automatically when a new Zigbee device connects. Battery powered Zigbee devices can not be probed in general because they are usually in sleep mode.',
  'ZbRead': 'Removedin favor ofZbSendwith "Read" attribute.',
  'ZbReset':
      '1= perform a factory reset and reconfiguration of the CC2530 chip. You will need to re-pair all Zigbee devices',
  'ZbRestore':
      'Restores a device configuration previously dumped withZbStatus2. This command does not pair a device, but lets you get back device configuration like ModelId or IEEEAddress. <json>= json contains the fields dumped withZbStatus2.<json>can contain multiple devices (if they fit).',
  'ZbSave<hex>':
      '			Forces saving the Zigbee device information to Flash. Auto-saving happens 10 seconds after a new Device parameter was changed, this command is normally not useful',
  'ZbZNPSend<hex>':
      '			(CC2530 only) Send a raw ZCL message to a Zigbee device. This is a low-level command, and requires to manually build the ZCL parameters. Most common usage will be provided as high-level functions.',
  'ZbZNPReceive':
      '(CC2530 only) Simulates a received message <hex>= hex string of the simulated message, same format asZbZNPReceiveddebug logs',
  'ZbEZSPSend<x><hex>':
      ' 			(EZSP only) Send a raw EZSP message. This is a low-level command, and requires to manually build the ZCL parameters. Most common usage will be provided as high-level functions. <x>:1=high-level EZSP command,2=low-level EZSP frame,3=low-level EZSP/ASH frame <hex>= hex string of the message',
  'ZbEZSPReceive<x><hex>':
      ' 			(EZSP only) Simulates a received message <x>:1=high-level EZSP command,2=low-level EZSP frame,3=low-level EZSP/ASH frame <hex>= hex string of the simulated message, same format asZbZNPReceiveddebug logs',
};

Map<String, String> bluetoothSettingsCommandsJSON = {
  'HM10Scan': 'Start a new device discovery scan',
  'HM10Period':
      'Show interval in seconds between sensor read cycles. Set to TelePeriod value at boot.',
  'HM10Baud':
      'Show ESP8266 serial interface baudrate (Not HM-10 baudrate) <value>= set baudrate',
  'HM10AT': '<command>= send AT commands to HM-10. Seelist',
  'HM10Time':
      '<n>= set time time of aLYWSD02 onlysensor to Tasmota UTC time and time zone.<n>is the sensor number in order of discovery starting with 0 (topmost sensor in the webUI list).',
  'HM10Auto':
      '<value>= start an automatic discovery scan with an interval of<value>seconds to receive data in BLE advertisements periodically. This is an active scan and it should be usedonly if necessary. At the moment that is the case just with MJ_HT_V1. This can change if a future HM-10 firmware starts supporting passive scan.',
  'NRFBeacon':
      'Set a BLE device as a beacon using the (fixed) MAC-address <value>(1-3 digits) = use beacon from scan list <value>(12 characters) = use beacon given the MAC interpreted as an uppercase stringAABBCCDDEEFF',
  'NRFIgnore':
      '0= all known sensor types active_(default)_ <value>= ignore certain sensor type (1= Flora,2= MJ_HT_V1,3= LYWSD02,4= LYWSD03,5= CGG1,6= CGD1',
  'NRFKey':
      'Set a "bind_key" for a MAC-address to decrypt (LYWSD03MMC & MHO-C401). The argument is a 44 uppercase characters long string, which is the concatenation of the bind_key and the corresponding MAC. <00112233445566778899AABBCCDDEEFF>(32 characters) = bind_key <112233445566>(12 characters) = MAC of the sensor <00112233445566778899AABBCCDDEEFF112233445566>(44 characters)= final string',
  'NRFMjyd2s':
      'Set a "bind_key" for a MAC-address to decrypt sensor data of the MJYD2S. The argument is a 44 characters long string, which is the concatenation of the bind_key and the corresponding MAC. <00112233445566778899AABBCCDDEEFF>(32 characters) = bind_key <112233445566>(12 characters) = MAC of the sensor <00112233445566778899AABBCCDDEEFF112233445566>(44 characters)= final string',
  'NRFNlight':
      'Set the MAC of an NLIGHT <value>(12 characters) = MAC interpreted as an uppercase stringAABBCCDDEEFF',
  'NRFPage':
      'Show the maximum number of sensors shown per page in the webUI list. <value>= set number of sensors(default = 4)',
  'NRFScan':
      'Scan for regular BLE-advertisements and show a list in the console 0= start a new scan list 1= append to the scan list 2= stop running scan',
};

Map<String, String> stepperMotorSettingsCommandsJSON = {
  'MotorMIS':
      '1,2,4,8,16Set micro stepping increment - 1/1 (full steps) to 1/16(default =1)',
  'MotorSPR':
      'integerSet the number of steps the given motor needs for one revolution(default =200) This is dependent on the type of motor and micro stepping. Most common motors are 1.8° per step.',
  'MotorRPM': '1..300Set revolutions per minute(default =30)',
  'MotorMove':
      'integerMove the motor the given number of steps (positive values: clockwise, negative values: counterclockwise)',
  'MotorRotate':
      'integerRotate the motor the given number of degrees (positive values: clockwise, negative values: counterclockwise)',
  'MotorTurn':
      'floatSpin the motor the given number of turns (positive values: clockwise, negative values: counterclockwise)',
};

Map<String, String> mp3PlayerSettingsCommandsJSON = {
  'MP3DAC': '0= DAC on(default) 1= DAC off',
  'MP3Device':
      'Specify playback device 1= USB 2= SD Card(default (also defaults on reset or power cycle))',
  'MP3EQ':
      'Set equalizer mode: 0= normal 1= pop 2= rock 3= jazz 4= classic 5= bass)',
  'MP3Pause': 'Pause',
  'MP3Play':
      'Play, works as a normal play on a real MP3 Player, starts at first MP3 file',
  'MP3Reset': 'Reset the MP3 player to defaults',
  'MP3Stop': 'Stop',
  'MP3Track': 'x= play track <x>',
  'MP3Volume': '0..100= set Volume',
};

Map<String, String> thermostatSettingsCommandsJSON = {
  'ThermostatModeSet':
      'Sets the thermostat mode 0= Thermostat Off (controller inactive, default) 1= Thermostat in automatic mode (controller active) 2= Thermostat in manual mode (output switch follows the input switch, used to follow an existing wall thermostat)',
  'ClimateModeSet':
      'Sets the climate mode 0= Heating mode (default) 1= Cooling mode',
  'ControllerModeSet':
      'Sets the controller mode (used for thermostat in automatic mode) 0= Hybrid controller (Predictive ramp-up controller and PI, default) 1= PI controller 2= Predictive ramp-up controller',
  'TempFrostProtectSet':
      'Sets the frost protection temperature. The controller, if in automatic mode, will never allow the temperature to sink below this value <0..12>= Temperature value in degrees Celsius/Fahrenheit (default 4.0° Celsius)',
  'InputSwitchSet':
      'Sets the number of the input used in case in manual control <1..4>= Number of the input (default 1)',
  'InputSwitchUse':
      'Switch to decide if the input shall be used to automatically switch to manual mode and assign it to the output (useful if using a serially connected wall thermostat) 0= Input not used (default) 1= Input used',
  'SensorInputSet':
      'Sets the temperature sensor to be used 0= MQTT (default) 1= Local sensor (can be changed by define, default DS18B20)',
  'OutputRelaySet':
      'Sets the output switch to be used for the thermostat <1..8>= Number of the output (default 1)',
  'EnableOutputSet':
      'Enables or disables the physical output 0= Output disabled 1= Output enabled (default)',
  'TimeAllowRampupSet':
      'Sets the minimum time in minutes since the last control action to be able to switch to the predictive ramp-up controller phase (applicable just in case of Hybrid controller, used normally in case of big deltas between the setpoint and the room temperature) <value>= Minutes (default 300 minutes)',
  'TempFormatSet':
      'Sets the temperature format 0= Degrees Celsius (default) 1= Degrees Fahrenheit',
  'TempMeasuredSet':
      'Sets the temperature measured by the sensor (for MQTT sensor mode) <TempFrostProtectSet..100>= Temperature (default 18.0° Celsius)',
  'TempTargetSet':
      'Sets the target temperature for the controller (setpoint) <TempFrostProtectSet..100>= Temperature (default 18.0° Celsius)',
  'TempMeasuredGrdRead':
      'Returns the calculated temperature gradient <value>= Temperature gradient in degrees Celsius/Fahrenheit',
  'StateEmergencySet':
      'Sets the thermostat emergency flag 0= Emergency flag off (default) 1= Emergency flag on (thermostat switches to off state)',
  'TimeManualToAutoSet':
      'Sets the time in manual mode after the last active input action (f.e. last action from serial connected wall thermostat) to switch to automatic mode 0..1440= time in minutes (default 60 minutes)',
  'PropBandSet':
      'Sets the value of the proportional band of the PI controller 0..20= value in degrees Celsius (default 4 degrees Celsius)',
  'TimeResetSet':
      'Sets the value of the reset time of the PI controller 0..86400= value in seconds (default 12000 seconds)',
  'TimePiProportRead':
      'Returns the proportional part of the PI controller calculation in seconds value= value in seconds',
  'TimePiIntegrRead':
      'Returns the integral part of the PI controller calculation in seconds value= value in seconds',
  'TimePiCycleSet':
      'Sets the value of the cycle for the PI controller 0..1440= value in minutes (default 30 minutes)',
  'TempAntiWindupResetSet':
      'Sets the value of the delta between controlled temperature and setpoint above which the integral part of the PI controller will be set to 0, in degrees Celsius/Fahrenheit 0..10= value in degrees (default 0.8° Celsius)',
  'TempHystSet':
      'Sets the value of the temperature hysteresis for the PI controller, in degrees Celsius/Fahrenheit -10..10= value in degrees (default 0.1° Celsius)',
  'TimeMaxActionSet':
      'Sets the maximum duty cycle of the PI controller in minutes 0..1440= value in minutes (default 20 minutes)',
  'TimeMinActionSet':
      'Sets the minimum duty cycle of the PI controller in minutes 0..1440= value in minutes (default 4 minutes)',
  'TimeSensLostSet':
      'Sets the maximum time without a temperature sensor update to mark it as lost in minutes 0..1440= value in minutes (default 30 minutes)',
  'TimeMinTurnoffActionSet':
      'Sets the minimum time in minutes within a cycle for the PI controller to switch off the output, below it, it will stay on 0..1440= value in minutes (default 3 minutes)',
  'TempRupDeltInSet':
      'Sets the minimum delta between controlled temperature and setpoint for the controller to switch to ramp-up controller phase (applicable just in Hybrid controller mode) 0..10= value in degrees Celsius/Fahrenheit (default 0.4° Celsius)',
  'TempRupDeltOutSet':
      'Sets the maximum delta between controlled temperature and setpoint for the controller to switch to the PI controller phase (applicable just in Hybrid controller mode) 0..10= value in degrees Celsius/Fahrenheit (default 0.2° Celsius)',
  'TimeRampupMaxSet':
      'Sets the maximum time in minutes for the controller to stay in the ramp-up phase (applicable just in Hybrid controller mode 0..1440= value in minutes (default 960 minutes)',
  'TimeRampupCycleSet':
      'Sets the value of the cycle for the ramp-up controller 0..1440= value in minutes (default 30 minutes)',
  'TempRampupPiAccErrSet':
      'Sets the initial accumulated error when switching from ramp-up to the PI controller phase if the target temperature has not been reached (applicable just in Hybrid controller mode) 0..25= value in degrees Celsius/Fahrenheit (default 2° Celsius)',
  'CtrDutyCycleRead':
      'Returns the duty cycle of the controller 0..100= value in %',
  'DiagnosticModeSet':
      'Enables/disables the diagnostics flag 0= Diagnostics disabled 1= Diagnostics enabled (default)',
};

Map<String, String> domoticsSettingsCommandsJSON = {
  'DzIdx<x>':
      'Show Domoticz Relay idx <x> (x =1..4) 0= disable use of Relay idx <x>(default) <value>= Show Relay idx <x>',
  'DzKeyIdx<x>':
      'Show Domoticz Key idx <x> (x =1..4) 0= disable use of Key idx <x>(default) <value>= Show Key idx <x> (to use enableButtonTopic)',
  'DzSend<type>':
      'send values or state to Domoticz <index>,<value1(;value2)|state>',
  'DzSensorIdx<x>':
      'Show Domoticz Sensor idx <x> (x =1..5) 0= disable use of Sensor idx <x>(default) <value>= Show Sensor idx <x>',
  'DzSwitchIdx<x>':
      'Show Domoticz Switch idx <x> (x =1..4) 0= disable use of Switch idx <x>(default) <value>= Show Switch idx <x> (to use enableSwitchTopic)',
  'DzUpdateTimer':
      'Show current update timer value in seconds 0= disable sending interim Domoticz status(default) 1..3600= send status to Domoticz in defined intervals',
};

Map<String, String> influxSettingsCommandsJSON = {
  'Ifx': 'InfluxDB state 0= off 1= on',
  'IfxHost': '<value>= set Influxdb host name or IP address',
  'IfxPort': '<value>= set Influxdb port',
  'IfxDatabase': '<value>= set Influxdb V1 and database name',
  'IfxUser': '<value>= set Influxdb V1 and userid',
  'IfxPassword': '<value>= set Influxdb V1 and password',
  'IfxBucket': '<value>= set Influxdb V2 and bucket name',
  'IfxOrg': '<value>= set Influxdb V2 and organization',
  'IfxSensor': 'Set Influxdb sensor logging 0= off 1= on',
  'IfxToken': '<value>= set Influxdb V2 and token',
  'IfxPeriod':
      '<value> =0= useTeleperiodvalue as publication interval(default) 10..3600= set a different publication interval Even whenIfxPeriod 0is used, publication is not necessarily performed at the same time as the telemetry message.',
  'IfxRp':
      '<value>= set Influxdb retention policy(optional) If blank, default is used as defined by the InfluxDB service.Retention policy must exist in InfluxDB, otherwise http post will fail.',
};

Map<String, String> knxSettingsCommandsJSON = {
  'KnxTx_Cmnd<x>':
      '0or1= send command using slot <x> set in KNX Menu at KNX_TX',
  'KnxTx_Val<x>':
      '<value>= send float value using slot <x> set in KNX Menu at KNX_TX',
  'KnxTx_Scene': '<value>= send scene number to the GA set in KNX Menu',
  'KNX_ENABLED':
      'Status of KNX Communications 0= set to Disable 1= set to Enable',
  'KNX_ENHANCED':
      'Status of Enhanced mode for KNX Communications 0= set to Disable 1= set to Enable',
  'KNX_PA':
      'KNX Physical Address 0.0.0= address not set x.x.x= set the device address (example1.1.0)',
  'KNX_GA':
      'Return the amount of Group Address to Send Data/Commands configured',
  'KNX_GA<x>':
      'Setup Group Address to Send Data/Commands (<x> = KNX Group Address number) 1= return configuration of GA<x> <option>, <area>, <line>, <member>to set configuration of GA<x> <option>= see table below for OPTION list <area>, <line>, <member>= KNX Address to Send Data/Commands',
  'KNX_CB':
      'Return the amount of Group Address to Receive Data/Commands configured',
  'KNX_CB<x>':
      '''Setup Group Address to Receive Data/Commands 1= return configuration of CB<x> <option>, <area>, <line>, <member>to set configuration of CB<x> <option>= see table below for OPTION list <area>, <line>, <member>= KNX Address to Receive Data/Commands OPTION	OPTION Value	OPTION		OPTION Value
1	Relay 1	17		TEMPERATURE
2	Relay 2	18		HUMIDITY
3	Relay 3	19		ENERGY_VOLTAGE
4	Relay 4	20		ENERGY_CURRENT
5	Relay 5	21		ENERGY_POWER
6	Relay 6	22		ENERGY_POWERFACTOR
7	Relay 7	23		ENERGY_DAILY
8	Relay 8	24		ENERGY_START
9	Button 1	25		ENERGY_TOTAL
10	Button 2	26		KNX_SLOT1
11	Button 3	27		KNX_SLOT2
12	Button 4	28		KNX_SLOT3
13	Button 5	29		KNX_SLOT4
14	Button 6	30		KNX_SLOT5
15	Button 7	255		EMPTY
''',
};

Map<String, String> esp32BLESettingsCommandsJSON = {
  'BLEAddrFilter':
      'Set BLE Address type filter. BLEAddrFilter= show filter level BLEAddrFilter n= set BLE address type filter 0..3 - default 3. Ignores BLE address types > filter value. Set 0 to ONLY see public addresses.',
  'BLEAlias':
      'Set Alias names for devices. A device may be referred to by its alias in subsequent commands BLEAlias mac=alias mac=alias ...= set one or more aliases from devices. BLEAlias2= clear all aliases.',
  'BLEDebug':
      'Set BLE debug level. BLEDebug= show extra debug information BLEDebug0= suppress extra debug',
  'BLEDetails':
      'Display details about received adverts BLEDetails0= disable showing of details. BLEDetails1 mac/alias= show the next advert from device mac/alias BLEDetails2 mac/alias= show all advert from device mac',
  'BLEDevices':
      'Cause a list of known devices to be sent on MQTT, or Empty the list of known devices. BLEDevices0= clear the known devices list. BLEDevices= Cause the known devices list to be published on stat/TASName/BLE.',
  'BLEMaxAge':
      'Set the timeout for device adverts. BLEMaxAge n= set the devices timeout to n seconds. BLEMaxAge= display the device timeout.',
  'BLEMode':
      'Change the operational mode of the BLE driver. BLEMode0= disable regular BLE scans. BLEMode1= BLE scan on command only. BLEMode2= regular BLE scanning (default).',
  'BLEName':
      'Read or write the name of a BLE device. BLEName mac|alias= read the name of a device using 1800/2A00. BLEName mac|alias= write the name of a device using 1800/2A00 - many devices are read only.',
  'BLEOp':
      'Perform a simple active BLE operation (read/write/notify). see separate description in source code',
  'BLEPeriod':
      'Set the period for publish of BLE data <value>= set interval in seconds',
  'BLEScan':
      'Cause/Configure BLE a scan BLEScan0 0..1= enable or disable Active scanning. (an active scan will gather extra data from devices, including name) BLEScan= Trigger a 20s scan now if in BLEMode1 BLEScan n= Trigger a scan now for n seconds if in BLEMode1',
  'iBeacon': 'Show or set enable for the iBeacon driver iBeacon= Display 0',
  'iBeaconClear': 'Clear iBeacon list',
  'iBeaconOnlyAliased':
      'Show or set OnlyAliased for the iBeacon driver iBeaconOnlyAliased= Display 0',
  'iBeaconPeriod':
      'Display or Set the period for publish of iBeacon data iBeaconPeriod= display interval iBeaconPeriod ss= set interval in seconds',
  'iBeaconTimeout':
      'Display or Set the timeout for iBeacon devices iBeaconTimeout= display timeout iBeaconTimeout ss= set timeout in seconds',
};

Map<String, String> bleMIsensorSettingsCommandsJSON = {
  'MI32Battery':
      'Trigger an active read of battery values. MI32Battery= request the driver read the battery from all sensors which have active battery read requirements.',
  'MI32Block':
      'Block or unblock a sensor device. MI32Block= list blocked devices by mac. MI32Block <mac or blealias>= Block one mac/alias.',
  'MI32Key':
      'Add a decryption key. MI32Key hexkey= add a 44 character decryption key to the keys list.',
  'MI32Keys':
      'Add one or more decryption keys by mac or alias. MI32Keys= list keys. MI32Keys <mac or blealias>=<bind_key> <mac or blealias>=<bind_key> ...= add keys for MAC or ble_alias. MI32Keys <mac or blealias>=- remove keys for one mac',
  'MI32Option<x>':
      ' n			Set driver options at runtime x=0- 0 -> sends only recently received sensor data, 1 -> aggregates all recent sensors data types x=1- 0 -> shows full sensor data at TELEPERIOD, 1 -> shows no sensor data at TELEPERIOD x=2- 0 -> sensor data only at TELEPERIOD (default and "usual" Tasmota style), 1 -> direct bridging of BLE-data to mqtt-messages x=5- 0 -> show all relevant BLE sensors, 1 -> show only sensors with a BLEAlias x=6 (from v 9.0.2.1) 1 -> always use MQTT Topic liketele/tasmota_ble/<name>containing only one sensor',
  'MI32Page':
      'Display/Set the sensors per page in the web view. MI32page= show sensors per page. MI32page n= Set sensors per page to n.',
  'MI32Period':
      'Display/Set the active scan and tele period for the MI32 driver. MI32Period= display the period in seconds. MI32Period n= Set the MI driver active read and tele period to n seconds.',
  'MI32Time<x>': '    = set the time on the device in slotx.',
  'MI32Unit<x>':
      '     = set the current Tasmota temperature unit as the temp unit for sensor in slotx.',
};

Map<String, String> cameraSettingsCommandsJSON = {
  'Wc': 'Query all camera settings',
  'WcBrightness': '-2..+2= set picture brightness',
  'WcContrast': '-2..+2= set picture contrast',
  'WcFlip': 'Flip camera image. 0= disable(default) 1= enable',
  'WcMirror': 'Mirror camera image. 0= disable(default) 1= enable',
  'WcResolution':
      'Set camera resolution. 0= 96x96 (96x96) 1= QQVGA2 (128x160) 2= QCIF (176x144) 3= HQVGA (240x176) 4= QVGA (320x240) 5= CIF (400x296) 6= VGA (640x480) 7= SVGA (800x600) 8= XGA (1024x768) 9= SXGA (1280x1024) 10= UXGA (1600x1200)',
  'WcSaturation': '-2..+2= set picture saturation',
  'WcStream': 'Control streaming 0= stop 1= start',
};

Map<String, String> ethernetSettingsCommandsJSON = {
  'Ethernet':
      'Only for ESP32 boards with additional LAN chip 0= disable Ethernet 1= enable Ethernet(default)',
  'EthAddress': '0..31= PHYxx address',
  'EthClockMode':
      'Ethernet clock mode. 0= ETH_CLOCK_GPIO0_IN(default) 1= ETH_CLOCK_GPIO0_OUT 2= ETH_CLOCK_GPIO16_OUT 3= ETH_CLOCK_GPIO17_OUT',
  'EthType':
      'Ethernet type. 0= ETH_PHY_LAN8720(default) 1= ETH_PHY_TLK110 2= ETH_PHY_IP101',
  'EthIpAddress':
      'Set device Ethernet IP address (for Wi-Fi, seeIpAddress) 0.0.0.0= use dynamic IP address (DHCP) XXX.XXX.XXX.XXX= set static IP address  Follow any IP configuration commands withrestart 1to apply changes',
  'EthGateway': 'Set gateway IP address',
  'EthSubnetmask': 'Set subnet mask',
  'EthDnsServer1': 'Set DNS servers IP address',
  'EthDnsServer2': 'Set DNS servers IP address',
};
