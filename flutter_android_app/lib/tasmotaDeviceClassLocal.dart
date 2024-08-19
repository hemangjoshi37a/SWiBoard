// ignore_for_file: file_names
import 'dart:convert';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swiboard/mqtt.dart';
import 'custom_elements.dart';
import 'loading_shimmer_wdiget.dart';
import 'tasmota_switch_button.dart';
import 'text_element.dart';
import 'deviceSettingsPage.dart';
import 'homepagelocal.dart';

double paddingamount = 4;
Map<String, TasmotaDevice> tasmotaDeviceMap = {};

class TasmotaDevice {
  late String mqttBrokerAddress;
  int numOfSwitches = 4;
  List<TasmotaSwitchButton> listOfTasmotaSwitch = [];
  String? deviceTopic = '';
  String commonNameFromMQTT = '';
  String? stateTopic;
  String? stateCmndTopic;
  String? resultsTopic;
  String? resultsCmndTopic;
  String? statusTopic;
  String? statusCmndTopic;
  StreamingSharedPreferences? pref;

  TasmotaDevice(
      {required String deviceTopic1,
      required StreamingSharedPreferences pref1}) {
    deviceTopic = deviceTopic1;
    stateTopic = 'stat/$deviceTopic/STATE';
    stateCmndTopic = 'cmnd/$deviceTopic/STATE';
    resultsTopic = 'stat/$deviceTopic/RESULT';
    resultsCmndTopic = 'cmnd/$deviceTopic/RESULT';
    statusTopic = 'stat/$deviceTopic/STATUS';
    statusCmndTopic = 'cmnd/$deviceTopic/STATUS';
    pref = pref1;
  }

// ## GET SWITCH-ICON-NUMBERS BY SWITCH-FRIENDLY NAME FROM SAVED-SSP  #####
  Map<String, dynamic> switchNameToIconDataNumberMapFx(
      List<dynamic> listOfSwitchesFrendlyNames) {
    Set<String> prefListOfKeys = pref!.getKeys().getValue();
    Map<String, dynamic> switchNameToIconDataNumberMap = {};
    for (var oneSwitchName in listOfSwitchesFrendlyNames) {
      String thisSwitchIconSaveSSPKey =
          'IconData_${deviceTopic}_$oneSwitchName';
      if (prefListOfKeys.contains(thisSwitchIconSaveSSPKey)) {
        int gotIconDataNumber = pref!
            .getInt(thisSwitchIconSaveSSPKey, defaultValue: 58235)
            .getValue();
        switchNameToIconDataNumberMap[oneSwitchName] = gotIconDataNumber;
      } else {
        switchNameToIconDataNumberMap[oneSwitchName] = 58235;
        pref!.setInt(thisSwitchIconSaveSSPKey, 58235);
      }
    }
    return switchNameToIconDataNumberMap;
  }

//################# TASMOTA DEVICE SSP STREAM BUILDER ##########
  Widget widgetCardFromSSP(BuildContext context, Function setState,
      AdmobReward rewardAd, AdmobInterstitial interstitialAd) {
    return StreamBuilder(
        key: ValueKey('StreamBuilder${Timestamp.now().toString()}'),
        stream: pref!.getString(statusTopic!, defaultValue: '{}'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty &&
                jsonDecode(snapshot.data!) != null) {
              Map<String, dynamic> readPrefMQTTdata =
                  jsonDecode(snapshot.data!);
              if (readPrefMQTTdata['Status'] != null) {
                List listOfSwitchesFrendlyNames =
                    readPrefMQTTdata['Status']['FriendlyName'];
                numOfSwitches =
                    readPrefMQTTdata['Status']['FriendlyName'].length;
                Map<String, dynamic> gotSwitchNameToIconDataNumberMap =
                    switchNameToIconDataNumberMapFx(listOfSwitchesFrendlyNames);
                listOfTasmotaSwitch = [];
                for (int i = 0; i < numOfSwitches; i++) {
                  listOfTasmotaSwitch.add(TasmotaSwitchButton(
                      id: i + 1,
                      deviceTopic: deviceTopic!,
                      pref: pref,
                      switchName: listOfSwitchesFrendlyNames[i].toString(),
                      iconDataNumber: gotSwitchNameToIconDataNumberMap[
                          listOfSwitchesFrendlyNames[i].toString()]));
                }
                return deviceCardWidget(readPrefMQTTdata, context, setState,
                    rewardAd, interstitialAd, pref!);
              } else {
                if (kDebugMode) {
                  return loadingShimmerWidget(
                      deleteTasmotaDeviceButton(context, false),
                      '''readPrefMQTTdata['Status'] != null''');
                } else {
                  return loadingShimmerWidget(
                      deleteTasmotaDeviceButton(context, false), '');
                }
              }
            } else {
              if (kDebugMode) {
                return loadingShimmerWidget(
                    deleteTasmotaDeviceButton(context, false),
                    '''snapshot.data!.isNotEmpty''');
              } else {
                return loadingShimmerWidget(
                    deleteTasmotaDeviceButton(context, false), '');
              }
            }
          } else {
            if (kDebugMode) {
              return loadingShimmerWidget(
                  deleteTasmotaDeviceButton(context, false),
                  '''snapshot.hasData''');
            } else {
              return loadingShimmerWidget(
                  deleteTasmotaDeviceButton(context, false), '');
            }
          }
        });
  }

//#################### ALL SWITCHES WRAP ########################
  Widget switchesWrapWidget(Function setState, AdmobReward rewardAd,
      AdmobInterstitial interstitialAd) {
    List<Widget> switchesWidgetList = listOfTasmotaSwitch.map((oneSwitch) {
      return oneSwitch.widget(setState, rewardAd, interstitialAd);
    }).toList();

    List<Widget> allWidgets = switchesWidgetList;

    List<String> customElementsList =
        pref!.getStringList('customElements', defaultValue: []).getValue();

    for (String oneElement in customElementsList) {
      String gotJSONString =
          pref!.getString(oneElement, defaultValue: '').getValue();

      try {
        Map<String, dynamic> jsonDecodedMap = jsonDecode(gotJSONString);
        switch (jsonDecodedMap['elementType']) {
          case 'CustomElementType.text':
            TextElement thisTextElement = TextElement(
                jsonDecodedMap['title'],
                jsonDecodedMap['value'],
                CustomElementType.text,
                jsonDecodedMap['subTopic'],
                jsonDecodedMap['pubTopic'],
                jsonDecodedMap['deviceTopic'],
                client,
                pref!,
                setState);
            if (deviceTopic == jsonDecodedMap['deviceTopic']) {
              allWidgets.add(thisTextElement.widget);
            }
        }
      } on FormatException catch (e) {
        allWidgets.add(Text(e.toString()));
      }
    }

    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      runSpacing: 15,
      spacing: 15,
      crossAxisAlignment: WrapCrossAlignment.center,
      clipBehavior: Clip.antiAlias,
      children: allWidgets,
    );
  } /////

// ############## EDIT RENAME DEVICE NAME DIALOGUE BOX ###############
  Future<dynamic> editDeviceDialogueBox(
      BuildContext context, String oldName, Function setState) async {
    TextEditingController newNametextfieldcontroller =
        TextEditingController(text: oldName);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: newNametextfieldcontroller,
              // textCapitalization: TextCapitalization.characters,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Enter new name',
                  border: OutlineInputBorder(),
                  hintText: "i.e. : My Living Room"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    sendMQTTmessageToTopic(
                        topic: 'cmnd/$deviceTopic/DeviceName',
                        msg: newNametextfieldcontroller.text);
                    sendMQTTmessageToTopic(
                        topic: statusCmndTopic!, msg: 'STATUS');
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

//############## ONE TASMOTA DEVICE NAME GESTURE DETECTOR  #####################
  Widget tasmotaDeviceCardTitleWidget(Map<String, dynamic> readPrefMQTTdata,
      BuildContext context, Function setState) {
    String oldName = readPrefMQTTdata['Status']['DeviceName'];
    return GestureDetector(
      onLongPress: () async {
        await editDeviceDialogueBox(context, oldName, setState);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(
          oldName,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

//############# ONE TASMOTA DEVICE ACTION BUTTONS ##################
  Widget tasmotaDeviceCardThreeDotMenu(BuildContext context,
      StreamingSharedPreferences pref, Function setState) {
    return Column(
      children: [
        refreshTasmotaDeviceButton(context),
        deviceSettingsTasmotaButton(context, pref),
        addNewWidgetButton(context, setState, deviceTopic!, pref),
        deleteTasmotaDeviceButton(context, true)
      ],
    );

    // decideButton(String selectedButtonName) {
    //   if (selectedButtonName == 'Refresh') {
    //     return refreshTasmotaDeviceButton(context);
    //   }
    //   if (selectedButtonName == 'Settings') {
    //     return deviceSettingsTasmotaButton(context, pref);
    //   }
    //   if (selectedButtonName == 'New Widget') {
    //     return addNewWidgetButton(context, setState, deviceTopic!, pref);
    //   }
    //   if (selectedButtonName == 'Delete') {
    //     return deleteTasmotaDeviceButton(context, true);
    //   }
    // }

    // Widget threeDotMenu = PopupMenuButton<String>(
    //   onSelected: (sting) {},
    //   itemBuilder: (BuildContext context) {
    //     return {'Refresh', 'Settings', 'New Widget', 'Delete'}
    //         .map((String choice) {
    //       return PopupMenuItem<String>(
    //           value: choice,
    //           child: SizedBox(width: 150, child: decideButton(choice)));
    //     }).toList();
    //   },
    // );
    // return threeDotMenu;
  }

// ############ ONE TASMOTA DEVICE CARD ############################
  Widget deviceCardWidget(
      Map<String, dynamic> readPrefMQTTdata,
      BuildContext context,
      Function setState,
      AdmobReward rewardAd,
      AdmobInterstitial interstitialAd,
      StreamingSharedPreferences pref) {
    return Container(
      alignment: Alignment.center,
      // width: 275,
      child: Card(
        key: ValueKey('${deviceTopic!}key'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          alignment: Alignment.center,
          // width: 275,
          child: Stack(alignment: Alignment.topRight, children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  tasmotaDeviceCardTitleWidget(
                      readPrefMQTTdata, context, setState),
                  Row(
                    children: [
                      Column(
                        children: [
                          tasmotaDeviceCardThreeDotMenu(
                              context, pref, setState),
                        ],
                      ),
                      Expanded(
                          child: switchesWrapWidget(
                              setState, rewardAd, interstitialAd)),
                    ],
                  ),
                  SizedBox(height: paddingamount),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  //  ################### Delete tasmota device Button ####################
  Card deleteTasmotaDeviceButton(BuildContext context, bool isFromPopup) {
    return Card(
      key: const ValueKey('deleteTasmotaDeviceButton'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        // height: 40,
        // width: 40,
        child: IconButton(
          icon: const Icon(Icons.delete, size: 25),
          onPressed: () {
            List<String>? thisgotlist = pref?.getStringList(
                tasmotaDeviceListSharedPrefKey,
                defaultValue: []).getValue();
            thisgotlist?.remove(deviceTopic);
            pref?.setStringList(tasmotaDeviceListSharedPrefKey, thisgotlist!);
            if (isFromPopup) {
              // Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }

  //  ################### Perticular tasmota device settings page ####################
  Card deviceSettingsTasmotaButton(
    BuildContext context,
    StreamingSharedPreferences pref,
  ) {
    return Card(
      key: const ValueKey('deviceSettingsTasmotaButtonnew'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        // height: 40,
        // width: 40,
        child: IconButton(
          icon: const Icon(Icons.settings, size: 25),
          onPressed: () async {
            // Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TasmotaDeviceSettingsWid(deviceTopic: deviceTopic!),
                ));
          },
        ),
      ),
    );
  }

  //  ################### Refresh All Switches States ####################
  Card refreshTasmotaDeviceButton(BuildContext context) {
    return Card(
      key: const ValueKey('refreshTasmotaDeviceButtonnew21'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        child: IconButton(
          icon: const Icon(Icons.refresh, size: 25),
          onPressed: () {
            sendMQTTmessageToTopic(
                topic: 'cmnd/$deviceTopic/POWER0', msg: 'POWER0');
            sendMQTTmessageToTopic(topic: statusCmndTopic!, msg: 'STATUS');
            sendMQTTmessageToTopic(topic: stateCmndTopic!, msg: 'STATE');
            // Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
