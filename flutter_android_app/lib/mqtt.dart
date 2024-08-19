import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'main.dart';

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

MqttServerClient client = MqttServerClient(
    mqttBrokerAddress, generateRandomString(15),
    maxConnectionAttempts: 3);

sendMQTTmessageToTopic({required String topic, required String msg}) {
  final newbuilder = MqttPayloadBuilder();
  newbuilder.addString(msg);
  client.publishMessage(topic, MqttQos.atLeastOnce, newbuilder.payload!);
}

Stream<List<MqttReceivedMessage<MqttMessage>>> mqttStream =
    client.updates.asBroadcastStream();

// ########### MAIN MQTT FUNCTION #########################################
Future<int> mainmqtt(StreamingSharedPreferences pref) async {
  //######### ADD PARAMETERS TO MQTT CLIENT ################
  client.logging(on: false);
  client.keepAlivePeriod = 20;
  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  client.onSubscribed = onSubscribed;
  client.port = mqttBrokerPort;
  // //########## GET MQTT CONNECTION MESSSAGE ##############
  // final connMess = MqttConnectMessage()
  //     .withClientIdentifier('Mqtt_MyClientUniqueId')
  //     .withWillTopic('willtopic') // If you set this you must set a will message
  //     .startClean() // Non persistent session for testing
  //     .withWillQos(MqttQos.atLeastOnce);
  // client.connectionMessage = connMess;

  //########## CONNECT TO MQTT BROKER ###################
  if (client.connectionStatus!.state == MqttConnectionState.disconnected) {
    try {
      String defaultMqttBroker = pref
          // .getString('defaultMqttBroker', defaultValue: '103.228.144.77')
          .getString('defaultMqttBroker', defaultValue: 'broker.hivemq.com')
          .getValue();
      String defaultMqttPort =
          pref.getString('defaultMqttPort', defaultValue: '1883').getValue();

      client = MqttServerClient.withPort(defaultMqttBroker,
          generateRandomString(15), int.parse(defaultMqttPort),
          maxConnectionAttempts: 3);

      await client.connect();
    } on MqttConnectionException catch (e) {
      if (kDebugMode) {
        print('MQTT MqttConnectionException $e');
      }
      // client.disconnect();
    } on MqttNoConnectionException catch (e) {
      if (kDebugMode) {
        print('MQTT MqttNoConnectionException $e');
      }
      // client.disconnect();
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('MQTT SocketException $e');
      }
      // client.disconnect();
    }
  }

  // //####### CHECK MQTT CONNECTION ########################
  // if (client.connectionStatus!.state == MqttConnectionState.connected) {
  // } else {
  //   client.disconnect();
  //   exit(-1);
  // }

  //######### UTILITY FUNCTIONS ########################
  client.published!.listen((MqttPublishMessage message) {});
  // await MqttUtilities.asyncSleep(60);
  // client.unsubscribe(topicResult);
  // await MqttUtilities.asyncSleep(2);
  // client.disconnect();
  return 0;
}
//############################################################################

void onSubscribed(MqttSubscription topic) {}
void onConnected() {}

void onDisconnected() {
  if (kDebugMode) {
    print('mqtt onDisconnect executed');
  }
}

// void onDisconnected() {
//   if (client.connectionStatus!.disconnectionOrigin ==
//       MqttDisconnectionOrigin.solicited) {
//   } else {
//     exit(-1);
//   }
// }

//######### MQTT UPDATES STREAM PROVIDER (firebase userdata)################
StreamProvider<List<MqttReceivedMessage<MqttMessage>>>
    mqttUpdatesStreamProvider = StreamProvider((ref) {
  Stream<List<MqttReceivedMessage<MqttMessage>>> mqttMessagesSubscription =
      client.updates.asBroadcastStream();
  return mqttMessagesSubscription;
});
//##########################################################################

checkMqttConnectioAndConnectIfDisconnected(
    MqttClient client, StreamingSharedPreferences pref) async {
  if (client.connectionStatus!.state == MqttConnectionState.disconnected) {
    if (kDebugMode) {
      print('mqtt executing manimqtt()');
    }
    await mainmqtt(pref);
  }

  while (client.connectionStatus!.state == MqttConnectionState.connecting) {
    if (kDebugMode) {
      print('mqtt wating to connect ....');
    }
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  if (kDebugMode) {
    print('client.connectionStatus!.state : ${client.connectionStatus!.state}');
  }
}

//#######################################
class MqttRawDataConvertClass {
  MqttPublishMessage mqttPublishMessageObject = MqttPublishMessage();
  Map<String, dynamic>? jsonDecodedMQTT;
  MqttReceivedMessage<MqttMessage>? rawdata;
  String stringData = '';
  String? topic = '';

  MqttRawDataConvertClass(MqttReceivedMessage<MqttMessage> rawdataip) {
    rawdata = rawdataip;
    mqttPublishMessageObject = rawdata?.payload as MqttPublishMessage;
    stringData = MqttUtilities.bytesToStringAsString(
        mqttPublishMessageObject.payload.message!);

    topic = mqttPublishMessageObject.variableHeader?.topicName;

    try {
      String stringData1 = MqttUtilities.bytesToStringAsString(
          mqttPublishMessageObject.payload.message!);
      jsonDecodedMQTT = jsonDecode(stringData1);
    } on FormatException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  MqttPublishMessage get getRawToMQTTPublishMessageObject {
    mqttPublishMessageObject = rawdata?.payload as MqttPublishMessage;
    return mqttPublishMessageObject;
  }

  String get getRawToStringOfData {
    stringData = MqttUtilities.bytesToStringAsString(
        mqttPublishMessageObject.payload.message!);
    return stringData;
  }

  Map<String, dynamic>? get getRawToJSONOfData {
    try {
      String stringData1 = MqttUtilities.bytesToStringAsString(
          mqttPublishMessageObject.payload.message!);
      jsonDecodedMQTT = jsonDecode(stringData1);
    } on FormatException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return jsonDecodedMQTT;
  }
}
