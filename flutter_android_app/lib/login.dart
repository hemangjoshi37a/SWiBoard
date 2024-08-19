import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swiboard/ourdatabase_class.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepagelocal.dart';
import 'mqtt.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignInAccount googleUser = googleUser;
GoogleSignInAuthentication googleAuth = googleAuth;
AuthCredential credential = credential;

//################ FUTURE handleGoogleSingin #####################
Future<User> handleSignIn(BuildContext context) async {
  User user;
  try {
    googleUser = (await googleSignIn.signIn())!;
    googleAuth = await googleUser.authentication;
    credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
  } on PlatformException catch (e) {
    e.hashCode;
    Toast.show('Sign In Error (P)', duration: Toast.lengthLong);
  } on AssertionError catch (e) {
    Toast.show(
      'Sign In Error (A)',
      duration: Toast.lengthLong,
    );
    e.hashCode;
  }
  UserCredential ipauthresult = await auth.signInWithCredential(credential);
  user = ipauthresult.user!;

  DocumentSnapshot<Map<String, dynamic>> thisUserDoc =
      await OurDatabase.db.collection('swiboard_users').doc(user.email).get();
  bool checkUserExistInFirestoreDB = thisUserDoc.exists;

  if (!checkUserExistInFirestoreDB) {
    OurDatabase.create('swiboard_users', user.email!, {
      'email': user.email,
      'devices': [],
      'lastseen': Timestamp.fromDate(DateTime.now())
    });
  }

  return user;
}
//###############################################################

//################### FirebaseSwiboardUser Class ########################
class FirebaseSwiboardUser {
  String? email;
  Timestamp? lastseen;
  List<dynamic>? listOfDevicesNamesFromFirestore;
  Map<String, dynamic>? usermap;
  BuildContext? context;
  TextEditingController textfieldcontroller = TextEditingController();
  StreamingSharedPreferences pref;
  FirebaseSwiboardUser(this.usermap,this.pref) {
    email = usermap?['email'];
    lastseen = usermap?['lastseen'];
    listOfDevicesNamesFromFirestore = usermap?['devices'];
    sunbscribeToDevicesAndSendStatusCMNDevery5Seconds(
        listOfDevicesNamesFromFirestore);
  }
  Future sunbscribeToDevicesAndSendStatusCMNDevery5Seconds(
      List<dynamic>? listOfDevicesNamesFromFirestore) async {
    if (listOfDevicesNamesFromFirestore!.isNotEmpty) {
      for (int i = 0; i < listOfDevicesNamesFromFirestore.length; i++) {
        String deviceTopic = listOfDevicesNamesFromFirestore[i] as String;
        String statusTopic = 'stat/$deviceTopic/STATUS';
        String resultsTopic = 'stat/$deviceTopic/RESULT';
        String stateCmndTopic = 'cmnd/$deviceTopic/STATE';
        String statusCmndTopic = 'cmnd/$deviceTopic/STATUS';
        subscribeToStatusAndResults(statusTopic, resultsTopic, deviceTopic,pref);
        publishEvery5secondStateAndStatusTopic(
            statusCmndTopic, stateCmndTopic, deviceTopic, 3, pref);
      }
    }
  }

//############### ADD NEW DEVICE DIALOGUES BOX ##########################
  void addDeviceFirestore(
    String deviceTasmotaName,
    List<dynamic>? devicesList,
  ) async {
    devicesList?.add(deviceTasmotaName);
    await OurDatabase.db
        .collection('swiboard_users')
        .doc(email)
        .update({'devices': devicesList});
  }

  Future<dynamic> addDeviceDialogueBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter New Device Tasmota Topic (Tasmota)'),
            content: TextField(
              controller: textfieldcontroller,
              decoration:
                  const InputDecoration(hintText: "i.e. : tasmota_3B02RC"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  addDeviceFirestore(
                    textfieldcontroller.text,
                    listOfDevicesNamesFromFirestore,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

void publishEvery5secondStateAndStatusTopic(
    String statusCmndTopic,
    String stateCmndTopic,
    String deviceTopic,
    int timeDelta,
    StreamingSharedPreferences pref) async {
  if (!(fiveSecondUpdateSubList.contains(deviceTopic))) {
    fiveSecondUpdateSubList.add(deviceTopic);

    if (kDebugMode) {
      print('mqtt every 5 sec executed for $deviceTopic');
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      Timer.periodic(Duration(seconds: timeDelta), (Timer t) async {
        if (kDebugMode) {
          print('mqtt publishing to $statusCmndTopic');
        }
        await checkMqttConnectioAndConnectIfDisconnected(client, pref);
        sendMQTTmessageToTopic(topic: statusCmndTopic, msg: 'STATUS');
      });

      Timer.periodic(Duration(seconds: timeDelta), (Timer t) async {
        if (kDebugMode) {
          print('mqtt publishing to $stateCmndTopic');
        }

        await checkMqttConnectioAndConnectIfDisconnected(client,pref);
        sendMQTTmessageToTopic(topic: stateCmndTopic, msg: 'STATE');
      });
    }
  }
}

Future<void> subscribeToStatusAndResults(
    String statusTopic, String resultsTopic, String deviceTopic,StreamingSharedPreferences pref) async {
  //########## SUBSCRIBE TO DEVICES AND SWITCHES ##########
  await checkMqttConnectioAndConnectIfDisconnected(client,pref);
  if (kDebugMode) {
    print('mqtt sunscribing to $deviceTopic');
  }
  client.subscribe(statusTopic, MqttQos.atLeastOnce);
  client.subscribe(resultsTopic, MqttQos.atLeastOnce);
  for (int i = 0; i <= 10; i++) {
    client.subscribe('stat/$deviceTopic/POWER$i', MqttQos.atLeastOnce);
  }
}
//##########################################################################