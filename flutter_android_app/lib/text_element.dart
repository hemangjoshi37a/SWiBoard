import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swiboard/mqtt.dart';

import 'custom_elements.dart';

class TextElement {
  late String _title;
  late String _value;
  late CustomElementType _elementType;
  late String _subTopic;
  late String _pubTopic;
  late String _deviceTopic;
  late StreamingSharedPreferences _pref;
  late String _mqttBrokerAddress;
  late int _mqttBrokerPort;
  late Function _setState;
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController pubTopicController = TextEditingController();
  TextEditingController subTopicController = TextEditingController();

  TextElement(
      String title,
      String value,
      CustomElementType elementType,
      String subTopic,
      String pubTopic,
      String deviceTopic,
      MqttServerClient mqttClient,
      StreamingSharedPreferences pref,
      [Function? setState]) {
    _title = title;
    _value = value;
    _elementType = elementType;
    _subTopic = subTopic;
    _pubTopic = pubTopic;
    _deviceTopic = deviceTopic;
    _pref = pref;
    _mqttBrokerAddress = mqttClient.server;
    _mqttBrokerPort = mqttClient.port!;
    _setState = setState!;
  }

  Widget sendTextFloatingButton(
      String sendTopic, TextEditingController textcontroller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              sendMQTTmessageToTopic(
                  topic: sendTopic, msg: textcontroller.text);
            },
            mini: true,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget textFieldOfElement(
    TextEditingController textFieldController,
    Map jsonDecodedMap,
    BuildContext context,
    Function setState,
  ) {
    textFieldController.text = jsonDecodedMap['value'];
    return GestureDetector(
      onLongPress: () {
        titleController.text = _title;
        valueController.text = _value;
        pubTopicController.text = _pubTopic;
        subTopicController.text = _subTopic;

        newElementDialoguebox(
          context,
          setState,
          titleController,
          valueController,
          pubTopicController,
          subTopicController,
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 70),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: TextField(
                controller: textFieldController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    labelText: jsonDecodedMap['title'],
                    border: const OutlineInputBorder(),
                    hintText: "Hello World..."),
              ),
            ),
          ),
          sendTextFloatingButton(
              jsonDecodedMap['pubTopic'], textFieldController)
        ],
      ),
    );
  }

  get widget {
    return StreamBuilder(
      stream: _pref.getString(_deviceTopic + _subTopic, defaultValue: ''),
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var snpdata = snapshot.data;
          try {
            Map<String, dynamic> jsonDecodedMap = jsonDecode(snpdata);
            TextEditingController thisTextController = TextEditingController();
            return textFieldOfElement(
              thisTextController,
              jsonDecodedMap,
              context,
              _setState,
            );
          } on FormatException catch (e) {
            if (kDebugMode) {
              print(e);
            }
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  saveConfig() {
    String sspSaveAddress = _deviceTopic + _subTopic;
    Map<String, String> saveStrJSON = {
      'title': _title,
      'value': _value,
      'elementType': _elementType.toString(),
      'subTopic': _subTopic,
      'pubTopic': _pubTopic,
      'deviceTopic': _deviceTopic,
      'mqttBrokerAddress': _mqttBrokerAddress,
      'mqttBrokerPort': _mqttBrokerPort.toString(),
    };
    _pref.setString(sspSaveAddress, jsonEncode(saveStrJSON));
  }

  newElementDialoguebox(
    BuildContext context,
    Function setState,
    TextEditingController titleController,
    TextEditingController valueController,
    TextEditingController pubTopicController,
    TextEditingController subTopicController,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          okButtonPress() {
            List<String> customElementsList = _pref
                .getStringList('customElements', defaultValue: []).getValue();
            _subTopic = subTopicController.text;
            _pubTopic = pubTopicController.text;
            _title = titleController.text;
            _value = valueController.text;
            String thisElement = _deviceTopic + _subTopic;
            if (!customElementsList.contains(thisElement)) {
              customElementsList.add(thisElement);
            }
            _pref.setStringList('customElements', customElementsList);
            saveConfig();
            Navigator.of(context).pop();
            setState(() {});
          }

          deleteButtonPress() {
            List<String> customElementsList = _pref
                .getStringList('customElements', defaultValue: []).getValue();
            customElementsList.remove(_deviceTopic + _subTopic);
            _pref.setStringList('customElements', customElementsList);
            Navigator.of(context).pop();
            setState(() {});
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
                      'Text Element',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: con,
                    width: 250,
                    child: ListView(shrinkWrap: true, children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            hintText: "i.e. : Fridge"),
                      ),
                      TextField(
                        controller: valueController,
                        decoration: const InputDecoration(
                            labelText: 'Initial Value',
                            border: OutlineInputBorder(),
                            hintText: "i.e. : Hello"),
                      ),
                      TextField(
                        controller: pubTopicController,
                        decoration: const InputDecoration(
                            labelText: 'Publish Topic',
                            border: OutlineInputBorder(),
                            hintText: "i.e. : /tasmota_213/sensor1"),
                      ),
                      TextField(
                        controller: subTopicController,
                        decoration: const InputDecoration(
                            labelText: 'Subscribe Topic',
                            border: OutlineInputBorder(),
                            hintText: "i.e. : /tasmota_213/sensor2"),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: deleteButtonPress,
                child: const Text('Delete'),
              ),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                onPressed: okButtonPress,
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
