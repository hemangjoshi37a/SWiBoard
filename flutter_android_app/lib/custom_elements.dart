import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'homepagelocal.dart';
import 'mqtt.dart';
import 'text_element.dart';

enum MultiChoiseEnum { none, done }

enum CustomElementType {
  text,
  // switchButton,
  // rangeProgressSlider,
  // multipleChoise,
  image,
  color
}

class CustomElement {
  late CustomElementType thisElementType;
  late String subTopic;
  late String pubTopic;
  late String deviceTopic;
  late Function setStateElement;
  late MqttServerClient mqttClientElement;
  CustomElement({
    required CustomElementType elementType,
    required Function setState,
  }) {
    thisElementType = elementType;
    setStateElement = setState;
  }

  get element {
    switch (thisElementType) {
      case CustomElementType.text:
        {
          return const Text('''title', 'value', mqttClientElement''');
        }
      // case CustomElementType.switchButton:
      //   {
      //     return switchButtonElement('title', true, Icons.home);
      //   }
      // case CustomElementType.rangeProgressSlider:
      //   {
      //     return sliderElement('title', 123, setStateElement, 0, 200);
      //   }
      // case CustomElementType.multipleChoise:
      //   {
      //     return multiChoiseElement([
      //       'choisesListElement',
      //     ], setStateElement);
      //   }
      case CustomElementType.image:
        {
          return const Text('CustomElementType.image');
        }
      case CustomElementType.color:
        {
          return const Text('CustomElementType.color');
        }
    }
  }
}

//  ################### Delete Refresh All Switches States ####################
Card addNewWidgetButton(BuildContext context, Function setState,
    String deviceTopic, StreamingSharedPreferences pref) {
  Widget addNewWidgetDialogueBox = AlertDialog(
    content: SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Add New Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView(shrinkWrap: true, children: [
            ElevatedButton(
              child: const Text('Text'),
              onPressed: () async {
                TextElement textelement = TextElement(
                    'title',
                    'value',
                    CustomElementType.text,
                    'subTopic',
                    'pubTopic',
                    deviceTopic,
                    client,
                    pref,
                    setState);
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
                textelement.newElementDialoguebox(
                  context,
                  setState,
                  TextEditingController(),
                  TextEditingController(),
                  TextEditingController(),
                  TextEditingController(),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Switch/Button'),
              onPressed: () {
                showSnackBar('Coming Soon on next update.', context);
              },
            ),
            ElevatedButton(
              child: const Text('Range/Progress/Slider'),
              onPressed: () {
                showSnackBar('Coming Soon on next update.', context);
              },
            ),
            ElevatedButton(
              child: const Text('Multiple Choise'),
              onPressed: () {
                showSnackBar('Coming Soon on next update.', context);
              },
            ),
            ElevatedButton(
              child: const Text('Image'),
              onPressed: () {
                showSnackBar('Coming Soon on next update.', context);
              },
            ),
            ElevatedButton(
              child: const Text('Color'),
              onPressed: () {
                showSnackBar('Coming Soon on next update.', context);
              },
            ),
          ]),
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
  return Card(
    key: const ValueKey('addNewWidgetButtonKey'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: SizedBox(
      // height: 40,
      // width: 40,
      child: IconButton(
        icon: const Icon(Icons.add, size: 25),
        onPressed: () async {
          return showDialog(
              context: context,
              builder: (context) {
                return addNewWidgetDialogueBox;
              });
        },
      ),
    ),
  );
}
