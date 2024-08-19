// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:swiboard/mqtt.dart';
import 'settingsParameters.dart';

class TasmotaDeviceSettingsWid extends StatefulWidget {
  final String deviceTopic;
  const TasmotaDeviceSettingsWid({super.key, required this.deviceTopic});

  @override
  State<TasmotaDeviceSettingsWid> createState() =>
      _TasmotaDeviceSettingsWidState();
}

class _TasmotaDeviceSettingsWidState extends State<TasmotaDeviceSettingsWid> {
  String dropdownValue = 'Control Settings';

  @override
  Widget build(BuildContext context) {
    Widget dropdownButton = DropdownButton<String>(
      value: dropdownValue,
      // icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      // elevation: 16,
      style: const TextStyle(color: Colors.deepPurple, fontSize: 26),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: mapOfGroupsOfSettings.keys
          .map((e) => e)
          .toList()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Settings'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: const Text(
                                '''You Need to `setOption4 1` for this to work'''),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListTile(
                                title: const Text('setOption4 1'),
                                onTap: () {
                                  sendMQTTmessageToTopic(
                                      topic:
                                          'cmnd/${widget.deviceTopic}/setOption4',
                                      msg: '1');
                                },
                              ),
                            ));
                      });
                },
                icon: const Icon(Icons.warning)),
          ),

          // Search Bar in Title bar
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate(
                      searchTerms: [],
                      setState: setState,
                      dropdownValue: dropdownValue));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(child: dropdownButton),
          Column(
            children: [
              settingsGroupWidget(
                  mapOfGroupsOfSettings[dropdownValue]!, widget.deviceTopic),
            ],
          )
        ],
      ),
    );
  }
}

Widget settingsGroupWidget(
    Map<String, String> settingsJSONmap, String deviceTopic) {
  return Card(
    child: Column(
        key: const ValueKey('TasmtoaDeviceSettingsWid'),
        children: settingsJSONmap.keys.map((oneKey) {
          return oneSettingWidget(settingsJSONmap, oneKey, deviceTopic);
        }).toList()),
  );
}

sendMQTTcommand(String mapKey, List<String> attributes, String deviceTopic) {
  if (attributes.length == 1) {
    sendMQTTmessageToTopic(
        topic: 'cmnd/$deviceTopic/$mapKey', msg: attributes[0]);
  } else {
    sendMQTTmessageToTopic(
        topic:
            'cmnd/$deviceTopic/${mapKey.replaceAll('<x>', '')}${attributes[0]}',
        msg: attributes[1]);
  }
}

Widget oneSettingWidget(
    Map<String, String> settingsMap, String settingMapKey, String deviceTopic) {
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();

  String currentsubtopic = 'stat/$deviceTopic/${settingMapKey.toUpperCase()}';

  client.subscribe(currentsubtopic, MqttQos.atLeastOnce);

  mqttStream.listen(((listOfMqttReceivedMessages) {
    MqttRawDataConvertClass mqttDataObj =
        MqttRawDataConvertClass(listOfMqttReceivedMessages.first);
    String thisMsgTopicName = mqttDataObj.topic!;

    if (thisMsgTopicName == currentsubtopic) {
      String searchTerm = settingMapKey;
      Map json = mqttDataObj.jsonDecodedMQTT!;

      if (json.keys
          .any((key) => key.toLowerCase() == searchTerm.toLowerCase())) {
        con2.text = json[json.keys.firstWhere(
                (key) => key.toLowerCase() == searchTerm.toLowerCase())]
            .toString();
      }
    }
  }));
  List<Widget> decideHasSubparameterNumber(String checkKey) {
    if (checkKey.contains('<x>')) {
      return [
        Text(settingMapKey),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextField(
            controller: con1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextField(
            controller: con2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              sendMQTTcommand(
                  settingMapKey, [con1.text, con2.text], deviceTopic);
            })
      ];
    } else {
      return [
        Text(settingMapKey),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: con2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    sendMQTTcommand(settingMapKey, [''], deviceTopic);
                  },
                  icon: const Icon(Icons.download)),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              sendMQTTcommand(settingMapKey, [con2.text], deviceTopic);
            })
      ];
    }
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: decideHasSubparameterNumber(settingMapKey),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                      child: Center(child: Text(settingsMap[settingMapKey]!))),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/////////////////////////////////////////////////////////////

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [];
  Function setState;
  String dropdownValue;

  CustomSearchDelegate(
      {required this.searchTerms,
      required this.setState,
      required this.dropdownValue});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            close(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            close(context, result);
          },
        );
      },
    );
  }

  @override
  void close(BuildContext context, dynamic result) {
    if (result != null) {
      setState(() {
        dropdownValue = result;
      });
    }
    super.close(context, result);
  }
}
