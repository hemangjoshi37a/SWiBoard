import 'dart:convert';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'custom_elements.dart';
import 'text_element.dart';
import 'firebase_options.dart';
import 'ad_helper.dart';
import 'homepagelocal.dart';
import 'login.dart';
import 'mqtt.dart';
import 'package:wiredash/wiredash.dart';

// String mqttBrokerAddress = '103.228.144.77';
String mqttBrokerAddress = 'broker.hivemq.com';
int mqttBrokerPort = 1883;
const kWebRecaptchaSiteKey = 'YOUR_RECAPTCHA_SITE_KEY';
//Manage debug tokens :  A67DF24E-3AC7-4DC7-B1DE-AADFBDE37640
// hjlabs.in  reCAPTCH SITE KEY : 6LexYT0iAAAAAOAYEAHkcyZcVL38_2dNa_VmyvPG
// hjlabs.in  reCAPTCH SECRET KEY : 6LexYT0iAAAAABfyb2IFxE26F5KQqCO4KB8gjAxb

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StreamingSharedPreferences pref = await StreamingSharedPreferences.instance;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: kWebRecaptchaSiteKey);
  Admob.initialize(
      testDeviceIds: [AdHelper.myTestDeviceID, AdHelper.myTestDeviceID2]);
  await initialMqttSetup(pref);
  runApp(ProviderScope(child: MyApp(pref: pref)));
}

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key, required pref});
  @override
  Widget build(BuildContext context) {
    try {
      return Wiredash(
        projectId: 'swibaord-b7fz4dh',
        secret: 'uZRH4xYL1vJO1OfSt9NinSMm_cAXRj6Q',
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SWiBoard',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: FutureBuilder(
            future: StreamingSharedPreferences.instance,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == false) {
                return const CircularProgressIndicator();
              }

              return MyHomePage(title: 'SWiBoard', pref: snapshot.data);
            },
          ),
        ),
      );
    } on StackOverflowError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const Center(child: CircularProgressIndicator());
    }
  }
}

initialMqttSetup(StreamingSharedPreferences pref) async {
  await mainmqtt(pref);
  List<String> gotTasmotaDevicesList = pref.getStringList(
      tasmotaDeviceListSharedPrefKey,
      defaultValue: []).getValue();

  Set<String> allkeys = pref.getKeys().getValue();
  if (allkeys.contains('mqttBroker')) {
    mqttBrokerAddress =
        // pref.getString('mqttBroker', defaultValue: '103.228.144.77').getValue();
        pref
            .getString('mqttBroker', defaultValue: 'broker.hivemq.com')
            .getValue();
  }

  if (allkeys.contains('mqttPort')) {
    mqttBrokerPort = pref.getInt('mqttPort', defaultValue: 1883).getValue();
  }

  for (final deviceTopic in gotTasmotaDevicesList) {
    String statusTopic = 'stat/$deviceTopic/STATUS';
    String resultsTopic = 'stat/$deviceTopic/RESULT';
    await subscribeToStatusAndResults(
        statusTopic, resultsTopic, deviceTopic, pref);
  }

  mqttStream.listen(((listOfMqttReceivedMessages) {
    MqttRawDataConvertClass mqttDataObj =
        MqttRawDataConvertClass(listOfMqttReceivedMessages.first);
    String thisMsgTopicName = mqttDataObj.topic!;
    if (mqttDataObj.getRawToStringOfData != 'ON' &&
        mqttDataObj.getRawToStringOfData != 'OFF') {
      try {
        pref.setString(
            thisMsgTopicName, jsonEncode(mqttDataObj.getRawToJSONOfData));
      } on FormatException catch (e) {
        pref.setString(thisMsgTopicName, mqttDataObj.getRawToStringOfData);
        if (kDebugMode) {
          print('The provided string is not valid JSON errro : $e');
        }
      }
    } else {
      pref.setString(thisMsgTopicName, mqttDataObj.getRawToStringOfData);
    }

    if (kDebugMode) {
      print(
          'mqtt received listener : stored ==topic==: $thisMsgTopicName  ==data== : ${mqttDataObj.getRawToStringOfData}');
    }

    List<String> customElementsList =
        pref.getStringList('customElements', defaultValue: []).getValue();
    for (String oneElement in customElementsList) {
      String thisElementGotJSONString =
          pref.getString(oneElement, defaultValue: '').getValue();
      try {
        Map<String, dynamic> jsonDecodedMap =
            jsonDecode(thisElementGotJSONString);

        if (jsonDecodedMap['subTopic'] == mqttDataObj.topic) {
          TextElement thisTextElement = TextElement(
              jsonDecodedMap['title'],
              mqttDataObj.stringData,
              CustomElementType.text,
              jsonDecodedMap['subTopic'],
              jsonDecodedMap['pubTopic'],
              jsonDecodedMap['deviceTopic'],
              client,
              pref,
              () => {});
          thisTextElement.saveConfig();
        }
      } on FormatException catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }));
}
