import 'dart:ui';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// import 'homepagelocal.dart';
import 'mqtt.dart';
import 'tasmotaDeviceClassLocal.dart';

class TasmotaSwitchButton {
  int id = 1;
  int iconDataNumber = 58235;
  String iconDataFontFamily = 'MaterialIcons';
  String switchOnOffState = 'OFF';
  Color switchColor = Colors.black;
  String deviceTopic;
  String powerTopicSUB = '';
  String powerTopicCMND = '';
  StreamingSharedPreferences? pref;
  String switchName = 'Power 1';

  TasmotaSwitchButton({
    required this.id,
    required this.deviceTopic,
    required this.pref,
    required this.switchName,
    required this.iconDataNumber,
  }) {
    powerTopicSUB = 'stat/$deviceTopic/POWER$id';
    powerTopicCMND = 'cmnd/$deviceTopic/POWER$id';
    pref = pref;
  }

  Color decideSwitchColor(String thisSwitchState) {
    if (thisSwitchState == 'ON') {
      switchColor = Colors.white;
    } else {
      switchColor = Colors.black;
    }
    return switchColor;
  }

  toggleState(AdmobInterstitial interstitialAd, AdmobReward rewardAd,
      BuildContext context) async {
    sendMQTTmessageToTopic(topic: 'cmnd/$deviceTopic/POWER$id', msg: 'TOGGLE');

// //###### SHOW REWARDS AD############
//     rewardADwaitingCounter += 1;
//     if (rewardADwaitingCounter > 13) {
//       if (await rewardAd.isLoaded) {
//         rewardAd.show();
//         rewardADwaitingCounter = 0;
//       }
//     }

// //### SHOW INTERSTITIAL AD############
//     interstitialADwaitingCounter += 1;
//     if (interstitialADwaitingCounter > 5) {
//       final isLoaded = await interstitialAd.isLoaded;
//       if (isLoaded ?? false) {
//         interstitialAd.show();
//         interstitialADwaitingCounter = 0;
//       } else {}
//     }
  }

  setSwitchStateTo(String newstate) {
    sendMQTTmessageToTopic(topic: 'cmnd/$deviceTopic/POWER$id', msg: newstate);
  }

  pickIcon(BuildContext context, Function setState) async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context);
    iconDataNumber = icon!.codePoint;
    iconDataFontFamily = icon.fontFamily!;
    pref!.setInt('IconData_${deviceTopic}_$switchName', iconDataNumber);
    setState(() {});
    debugPrint('Picked Icon:  $icon');
  }

  // ############## EDIT RENAME DEVICE NAME DIALOGUE BOX ###############
  Future<dynamic> editSwitchDialogueBox(
      BuildContext context, Function setState) async {
    TextEditingController newNametextfieldcontroller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: newNametextfieldcontroller,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Enter new name',
                  border: OutlineInputBorder(),
                  hintText: "i.e. : Fridge"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    await pickIcon(context, setState);
                  },
                  child: const Text('Edit Icon')),
              ElevatedButton(
                  onPressed: () {
                    sendMQTTmessageToTopic(
                        topic: 'cmnd/$deviceTopic/FriendlyName$id',
                        msg: newNametextfieldcontroller.text);
                    sendMQTTmessageToTopic(
                        topic: 'cmnd/$deviceTopic/STATUS', msg: 'STATUS');
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

// ### DECIDE TO DISPLAY SHIMMER ICON OR BLACK ICON (AND SWITCHFRIENDLYNAME)#
  decideOnOffShimmerEffect(AsyncSnapshot<String> snapshot) {
    Column defaultColumn = Column(
      key: ValueKey('Column${Timestamp.now().toString()}'),
      children: [
        Icon(
          IconData(iconDataNumber, fontFamily: 'MaterialIcons'),
          color: decideSwitchColor(snapshot.data!),
          size: 60,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
        Text(switchName)
      ],
    );
    Color thisDecidedColor = decideSwitchColor(snapshot.data!);
    if (thisDecidedColor == Colors.white) {
      var brightness = PlatformDispatcher.instance.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      return Shimmer.fromColors(
          key: ValueKey('shimmer${Timestamp.now().toString()}'),
          baseColor: Colors.white,
          period: const Duration(milliseconds: 1500),
          highlightColor:
              isDarkMode ? Colors.blue.shade600 : Colors.blue.shade300,
          child: Column(
            key: ValueKey('Column${Timestamp.now().toString()}'),
            children: [
              GlowIcon(
                IconData(iconDataNumber, fontFamily: 'MaterialIcons'),
                color: isDarkMode ? Colors.blue.shade600 : Colors.blue.shade300,
                glowColor: thisDecidedColor == Colors.white
                    ? (isDarkMode ? Colors.blue.shade600 : Colors.blue.shade300)
                    : Colors.transparent,
                size: 64,
                blurRadius: 9,
              ),
              Text(switchName)
            ],
          ));
    } else {
      return defaultColumn;
    }
  }

//############### SWITCH WIDGET ####################
  Widget widget(Function setState, AdmobReward rewardAd,
      AdmobInterstitial interstitialAd) {
    return StreamBuilder(
        key: ValueKey('switchwisget${Timestamp.now().toString()}'),
        stream: pref!.getString('stat/$deviceTopic/POWER${id.toString()}',
            defaultValue: ''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.blue.shade400,
              ),
              key: ValueKey('ElevatedButton${Timestamp.now().toString()}'),
              onPressed: () {
                toggleState(interstitialAd, rewardAd, context);
              },
              onLongPress: () async {
                await editSwitchDialogueBox(context, setState);
              },
              child: Container(
                  key: ValueKey('Container${Timestamp.now().toString()}'),
                  margin: EdgeInsets.all(paddingamount),
                  padding: EdgeInsets.all(paddingamount),
                  child: decideOnOffShimmerEffect(snapshot)),
            );
          } else {
            return Shimmer.fromColors(
              key: ValueKey('shimmer${Timestamp.now().toString()}'),
              baseColor: Colors.white,
              highlightColor: Colors.blue,
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Loading...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        });
  }
}
