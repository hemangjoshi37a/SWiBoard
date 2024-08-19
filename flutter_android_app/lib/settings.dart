import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:shimmer/shimmer.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swiboard/main.dart';
import 'package:url_launcher/url_launcher.dart';
import './login.dart';
import 'homepagelocal.dart';
import 'mqtt.dart';
import 'ourdatabase_class.dart';
import 'tasmotaDeviceClassLocal.dart';

class Sidebarwid extends StatefulWidget {
  final Function mainsetstate;
  final StreamingSharedPreferences pref;
  const Sidebarwid(this.mainsetstate, this.pref, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarwidState createState() => _SidebarwidState();
}

class _SidebarwidState extends State<Sidebarwid> {
  @override
  Widget build(BuildContext context) {
    String accountEmail = googleSignIn.currentUser == null
        ? 'Please Login'
        : googleSignIn.currentUser!.email;

    String? accountName = googleSignIn.currentUser == null
        ? 'Please Login'
        : googleSignIn.currentUser!.displayName;

    String? currentAccountPicture = googleSignIn.currentUser == null
        ? 'https://via.placeholder.com/350x150"'
        : googleSignIn.currentUser!.photoUrl;

//############ SAVE MQTT SETTING Fx #######################
    saveBrokerButtonFx(
        StreamingSharedPreferences pref,
        TextEditingController brokerNameTextFieldController,
        TextEditingController portTextFieldController) async {
      if (brokerNameTextFieldController.text.isNotEmpty &&
          portTextFieldController.text.isNotEmpty) {
        MqttServerClient oldClient = client;
        String oldMqttBoker = brokerNameTextFieldController.text;
        client.disconnect();
        client = MqttServerClient.withPort(brokerNameTextFieldController.text,
            generateRandomString(15), int.parse(portTextFieldController.text),
            maxConnectionAttempts: 3);
        //########## CONNECT TO MQTT BROKER ###################
        if (client.connectionStatus!.state ==
            MqttConnectionState.disconnected) {
          try {
            await client.connect();
            widget.pref
                .setString('mqttBroker', brokerNameTextFieldController.text);
            widget.pref
                .setInt('mqttPort', int.parse(portTextFieldController.text));
            await initialMqttSetup(widget.pref);
            // ignore: use_build_context_synchronously
            showSnackBar(
                'MQTT Connection Successful to ${brokerNameTextFieldController.text}',
                context);

            List<String> mqttBrokersList = pref.getStringList(
              'mqttBrokersList',
              defaultValue: [''],
            ).getValue();

            List<String> mqttPortsList = pref.getStringList(
              'mqttPortsList',
              defaultValue: [''],
            ).getValue();

            if (!mqttBrokersList.contains(brokerNameTextFieldController.text)) {
              mqttBrokersList.add(brokerNameTextFieldController.text);
              mqttPortsList.add(portTextFieldController.text);
              pref.setStringList('mqttBrokersList', mqttBrokersList);
              pref.setStringList('mqttPortsList', mqttPortsList);
            }

            await pref.setString(
                'defaultMqttBroker', brokerNameTextFieldController.text);
            await pref.setString(
                'defaultMqttPort', portTextFieldController.text);

            setState(() {});
          } on MqttConnectionException catch (e) {
            showSnackBar('MQTT MqttConnectionException $e', context);
            brokerNameTextFieldController.text = oldMqttBoker;
            client = oldClient;
            setState(() {});
          } on MqttNoConnectionException catch (e) {
            showSnackBar('MQTT MqttConnectionException $e', context);
            brokerNameTextFieldController.text = oldMqttBoker;
            client = oldClient;
            setState(() {});
          } on SocketException catch (e) {
            showSnackBar('MQTT MqttConnectionException $e', context);
            brokerNameTextFieldController.text = oldMqttBoker;
            client = oldClient;
            setState(() {});
          }
        }
      }
    }

// ############# SAVE MQTT BROKER BUTTON #############
    Widget saveMQTTbrokerButton(
        TextEditingController brokerNameTextFieldController,
        TextEditingController portTextFieldController) {
      return FloatingActionButton(
        mini: true,
        key: ValueKey('saveMQTTbrokerButton${Timestamp.now().toString()}'),
        heroTag: Text('saveMQTTbrokerButton${Timestamp.now().toString()}'),
        onPressed: () {
          saveBrokerButtonFx(widget.pref, brokerNameTextFieldController,
              portTextFieldController);
        },
        child: const Icon(Icons.check_box),
      );
    }

//############ DELETE MQTT SETTING Fx #######################
    deleteBrokerButtonFx(
        StreamingSharedPreferences pref,
        TextEditingController brokerNameTextFieldController,
        TextEditingController portTextFieldController) async {
      List<String> mqttBrokersList =
          pref.getStringList('mqttBrokersList', defaultValue: ['']).getValue();
      List<String> mqttPortsList =
          pref.getStringList('mqttPortsList', defaultValue: ['']).getValue();
      int thisMqttBrokerIndex =
          mqttBrokersList.indexOf(brokerNameTextFieldController.text);
      mqttBrokersList.remove(brokerNameTextFieldController.text);
      mqttPortsList.removeAt(thisMqttBrokerIndex);
      await pref.setStringList('mqttBrokersList', mqttBrokersList);
      await pref.setStringList('mqttPortsList', mqttPortsList);
      setState(() {});
    }

    Widget deleteMQTTbrokerButton(
        TextEditingController brokerNameTextFieldController,
        TextEditingController portTextFieldController) {
      return FloatingActionButton(
        mini: true,
        key: ValueKey('deleteMQTTbrokerButton${Timestamp.now().toString()}'),
        heroTag: Text('deleteMQTTbrokerButton${Timestamp.now().toString()}'),
        onPressed: () async {
          await deleteBrokerButtonFx(widget.pref, brokerNameTextFieldController,
              portTextFieldController);
        },
        child: const Icon(Icons.delete),
      );
    }

    Widget mqttBrokerAddressTextFieldWidget(
        String thisMqttBroker,
        TextEditingController brokerNameTextFieldController,
        TextEditingController portTextFieldController) {
      brokerNameTextFieldController.text = thisMqttBroker;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            // Expanded(
            //   child:

            TextField(
          controller: brokerNameTextFieldController,
          textCapitalization: TextCapitalization.none,
          decoration: const InputDecoration(
              labelText: 'MQTT Broker',
              border: OutlineInputBorder(),
              hintText: "i.e. : 103.228.144.77"),
        ),
        // ),
      );
    }

    Widget mqttPortTextFieldWidget(
        TextEditingController portTextFieldController) {
      return Container(
        padding: const EdgeInsets.only(right: 110),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // Expanded(
              //   child:
              TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: portTextFieldController,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
                labelText: 'Port',
                border: OutlineInputBorder(),
                hintText: "i.e. : 1883"),
          ),
          // ),
        ),
      );
    }

    Widget mqttBrokerSettingCard(
        String thisMqttBroker,
        TextEditingController brokerNameTextFieldController,
        TextEditingController portTextFieldController,
        {bool showDeleteMqttBrokerButton = true}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'MQTT Broker Setting',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
                          client.server == brokerNameTextFieldController.text
                              ? Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 21, 120, 201),
                                  highlightColor: Colors.yellow,
                                  child: const Text('(Connected)'),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    mqttBrokerAddressTextFieldWidget(thisMqttBroker,
                        brokerNameTextFieldController, portTextFieldController),
                    mqttPortTextFieldWidget(portTextFieldController)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      saveMQTTbrokerButton(brokerNameTextFieldController,
                          portTextFieldController),
                      showDeleteMqttBrokerButton
                          ? deleteMQTTbrokerButton(
                              brokerNameTextFieldController,
                              portTextFieldController)
                          : const SizedBox()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget userGoogleProfileWidgetWithLoginOut() {
      return googleSignIn.currentUser != null
          ? Stack(
              alignment: Alignment.topRight,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.blue, spreadRadius: 3)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(5),
                    accountEmail: Text(accountEmail),
                    accountName: Text(accountName!),
                    currentAccountPicture:
                        Image(image: NetworkImage((currentAccountPicture!))),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Logoutbutton(setState, widget.mainsetstate),
                    syncDevicesButton(
                        context, accountEmail, widget.pref, setState)
                  ],
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await googleSignIn.signIn();
                    setState(() {});
                  },
                  child: const Text('🔄 Login to sync data to Cloud ☁️')),
            );
    }

    List<String> mqttPortsList = widget.pref
        .getStringList('mqttPortsList', defaultValue: ['']).getValue();
    int mqttBrokerCounter = 0;
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: ListView(
        shrinkWrap: true,
        children: [
          userGoogleProfileWidgetWithLoginOut(),
          privacyPolicyPageLink(),
          mqttBrokerSettingCard(
              '', TextEditingController(), TextEditingController(),
              showDeleteMqttBrokerButton: false),
          Column(
              mainAxisSize: MainAxisSize.min,
              // shrinkWrap: true,
              children: widget.pref
                  .getStringList('mqttBrokersList', defaultValue: [''])
                  .getValue()
                  .map((thisMqttBroker) {
                    TextEditingController brokerNameTextFieldController =
                        TextEditingController(text: thisMqttBroker);
                    TextEditingController portTextFieldController =
                        TextEditingController(
                            text: mqttPortsList[mqttBrokerCounter]);
                    mqttBrokerCounter += 1;

                    return mqttBrokerSettingCard(thisMqttBroker,
                        brokerNameTextFieldController, portTextFieldController);
                  })
                  .toList()),
        ],
      ),
    );
  }
}

Widget syncDevicesButton(BuildContext context, String accountEmail,
    StreamingSharedPreferences pref, Function setState) {
  return ElevatedButton(
      onPressed: () async {
        bool checkSignedIn = await googleSignIn.isSignedIn();
        if (checkSignedIn == false) {
          await googleSignIn.signIn();
        }

        if (checkSignedIn) {
          Map? thisData = await OurDatabase.read(
              'swiboard_users', googleSignIn.currentUser!.email);

          List<dynamic> thisUserDevices = thisData!['devices'];

          List<String> currentAvailableDevices = pref.getStringList(
              tasmotaDeviceListSharedPrefKey,
              defaultValue: []).getValue();

          for (var oneDeviceName in currentAvailableDevices) {
            if (!thisUserDevices.contains(oneDeviceName) &&
                oneDeviceName != '') {
              thisUserDevices.add(oneDeviceName);
              OurDatabase.update(
                  'swiboard_users',
                  googleSignIn.currentUser!.email,
                  {'devices': thisUserDevices});
            }
          }

          // ignore: use_build_context_synchronously
          await syncDeviceDialogueBox(context, thisUserDevices, pref, setState);
        }
      },
      child: const Text('Sync Devices 🔄'));
}

// ######### Sync Device from Firebase dialogue box #################
Future<dynamic> syncDeviceDialogueBox(
    BuildContext context,
    List<dynamic> thisUserDevices,
    StreamingSharedPreferences pref,
    Function setState) async {
  return showDialog(
    context: context,
    builder: (context) {
      //#### Download device from cloud Fx ########
      addDeviceLocallyFromCloud(
          String thisCloudDevice, StreamingSharedPreferences pref) async {
        List<String> thisLocalDevicesList = pref.getStringList(
            tasmotaDeviceListSharedPrefKey,
            defaultValue: []).getValue();
        if (!thisLocalDevicesList.contains(thisCloudDevice)) {
          thisLocalDevicesList.add(thisCloudDevice);
          await pref.setStringList(
              tasmotaDeviceListSharedPrefKey, thisLocalDevicesList);

          TasmotaDevice thisDevice =
              TasmotaDevice(deviceTopic1: thisCloudDevice, pref1: pref);
          publishEvery5secondStateAndStatusTopic(thisDevice.statusCmndTopic!,
              thisDevice.stateCmndTopic!, thisDevice.deviceTopic!, 3, pref);
          String statusTopic = 'stat/${thisDevice.deviceTopic}/STATUS';
          String resultsTopic = 'stat/${thisDevice.deviceTopic}/RESULT';
          await subscribeToStatusAndResults(
              statusTopic, resultsTopic, thisDevice.deviceTopic!, pref);

          setState(() {});
        }
      }

      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cloud Devices',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView(
                  shrinkWrap: true,
                  children: thisUserDevices.map((thisDevice) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(thisDevice),
                        IconButton(
                          onPressed: () {
                            addDeviceLocallyFromCloud(thisDevice, pref);
                          },
                          icon: const Icon(Icons.download,
                              size: 25, color: Colors.blue),
                        )
                      ],
                    );
                  }).toList()),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class Logoutbutton extends StatelessWidget {
  final Function sidebarsetState;
  final Function mainpagesetstate;
  const Logoutbutton(this.sidebarsetState, this.mainpagesetstate, {super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
          child: const Text('Logout 🚪'),
          onPressed: () async {
            await googleSignIn.signOut();
            sidebarsetState(() {});
            mainpagesetstate(() {});
          },
        ),
      );
    } on Error catch (e) {
      if (kDebugMode) {
        print("this error was occured #001 : $e");
      }
      return const SizedBox();
    }
  }
}

Widget privacyPolicyPageLink() {
  return Center(
    child: InkWell(
        child: const Text(
          'Privacy Policy',
          style: TextStyle(fontSize: 15),
        ),
        onTap: () => launchUrl(Uri.parse('https://hjlabs.in/privacy-policy/'))),
  );
}
