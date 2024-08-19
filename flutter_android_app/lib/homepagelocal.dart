import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:swiboard/ad_helper.dart';
import 'package:swiboard/login.dart';
import 'package:wiredash/wiredash.dart';
import 'inapp_webview.dart';
import 'settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'tasmotaDeviceClassLocal.dart';

String tasmotaDeviceListSharedPrefKey = 'tasmotadevices';
List<String> fiveSecondUpdateSubList = [];

// Replace these with your actual ad unit IDs
String bannerAdUnitId = 'YOUR_BANNER_AD_UNIT_ID';
String interstitialAdUnitId = 'YOUR_INTERSTITIAL_AD_UNIT_ID';
String rewardedAdUnitId = 'YOUR_REWARDED_AD_UNIT_ID';

int rewardADwaitingCounter = 0;
int interstitialADwaitingCounter = 0;

extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}

//########### HOME PAGE ###################
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title, required this.pref});
  final String title;
  final StreamingSharedPreferences pref;
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;
  late AdmobReward rewardAd;
  late AdmobBanner bannerAd;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    //#####################################
    super.initState();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }

  checkInitialMqttBrokers(StreamingSharedPreferences pref) {
    List<String> availableMqttBrokerList =
        pref.getStringList('mqttBrokersList', defaultValue: []).getValue();
    List<String> availableMqttPortList =
        pref.getStringList('mqttPortsList', defaultValue: []).getValue();
    if (availableMqttBrokerList.isEmpty) {
      availableMqttBrokerList.add('broker.hivemq.com');
      availableMqttPortList.add('1883');
      availableMqttBrokerList.add('103.228.144.77');
      availableMqttPortList.add('1883');
      pref.setStringList('mqttBrokersList', availableMqttBrokerList);
      pref.setStringList('mqttPortsList', availableMqttPortList);
    }
    if (kDebugMode) {
      print('availableMqttBrokerList : $availableMqttBrokerList');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ###### AdMob Configuration ##########
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId(context),
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleAdEvent(event, args, 'Interstitial', scaffoldState, context);
      },
    );
    rewardAd = AdmobReward(
      adUnitId: AdHelper.rewardedAdUnitId(context),
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleAdEvent(event, args, 'Reward', scaffoldState, context);
      },
    );
    bannerAd = AdmobBanner(
      adUnitId: AdHelper.bannerAdUnitId(context),
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleAdEvent(event, args, 'Reward', scaffoldState, context);
      },
      adSize: AdmobBannerSize.BANNER,
    );
    interstitialAd.load();
    rewardAd.load();
    bannerAd.listener!;

    checkInitialMqttBrokers(widget.pref);
    PageController page = PageController();
    SideMenuController sideMenuController = SideMenuController();

    List<SideMenuItem> sidemenuItemsList = [
      SideMenuItem(
          priority: 0,
          title: 'Devices',
          onTap: (int pgnum, SideMenuController con1) {
            page.jumpToPage(0);
            sideMenuController.changePage(0);
          },
          icon: const Icon(Icons.home),
          tooltipContent: "Home"),
      SideMenuItem(
          priority: 1,
          title: 'Setting',
          onTap: (int pgnum, SideMenuController con1) async {
            page.jumpToPage(1);
            sideMenuController.changePage(1);
          },
          icon: const Icon(Icons.settings),
          tooltipContent: "Settings"),
      SideMenuItem(
          priority: 2,
          title: 'Buy Now!',
          onTap: (int pgnum, SideMenuController con1) {
            page.jumpToPage(2);
            sideMenuController.changePage(2);
          },
          icon: const Icon(Iconsax.bag),
          tooltipContent: "Buy Now!")
    ];

    var brightness = PlatformDispatcher.instance.platformBrightness;

    bool isDarkMode = brightness == Brightness.dark;
// ################### SIDEMENU  WIDGET ##################################
    Widget sidemenu = SideMenu(
        showToggle: true,
        controller: sideMenuController,
        style: SideMenuStyle(
          displayMode: SideMenuDisplayMode.auto,
          hoverColor: isDarkMode ? Colors.blue.shade700 : Colors.blue.shade100,
          selectedColor: Colors.lightBlue,
          selectedTitleTextStyle: const TextStyle(color: Colors.white),
          selectedIconColor: Colors.white,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          backgroundColor:
              isDarkMode ? Colors.blue.shade700 : Colors.blue.shade50,
        ),
        title: Column(
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 150,
                  maxWidth: 150,
                ),
                child: const SizedBox(
                  height: 7,
                )),
            // const Divider(
            //   indent: 2.0,
            //   endIndent: 2.0,
            // ),
          ],
        ),
        items: sidemenuItemsList);

//############### LIST OF WIDGETS OF ALL PAGES IN SIDEMENU ###########################
    List<Widget> sideMenuPagesList = [
      StreamBuilder(
          stream: widget.pref
              .getStringList(tasmotaDeviceListSharedPrefKey, defaultValue: []),
          // initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Widget> reorderableListItems = tasmotaDeviceListWidget(
                      snapshot.data,
                      ref,
                      context,
                      widget.pref,
                      setState,
                      rewardAd,
                      interstitialAd) +
                  [
                    // bannerAd.createElement().widget,
                    AdmobBanner(
                        key: ValueKey(
                            'banneradkey${Timestamp.now().toString()}'),
                        adUnitId: AdHelper.bannerAdUnitId(context),
                        adSize: bannerSize!,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic>? args) {
                          handleAdEvent(
                              event, args, 'Banner', scaffoldState, context);
                        },
                        onBannerCreated:
                            (AdmobBannerController bannerAdController) {
                          bannerAdController.dispose();
                        }),
                  ];

              return ReorderableListView(
                shrinkWrap: true,
                children: reorderableListItems,
                onReorder: (int oldIndex, int newIndex) {
                  reorderableListItems.swap(oldIndex, newIndex);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      Sidebarwid(
        setState,
        widget.pref,
      ),
      const SizedBox(
          width: 300, height: 1000, child: InAppWebViewExampleScreen()),
    ];

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: Text(
                        widget.title,
                        // style: TextStyle(fontSize: 15),
                      ),
                      onTap: () async {
                        await launchUrl(
                            Uri.parse(
                                'https://hjlabs.in/product/swiboard-wifi-switch-board-iot-device/'),
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Share.share(
                              '''Check out this awesome Tasmota MQTT control app 
                                  Download Now : SWiBoard: https://play.google.com/store/apps/details?id=in.hjlabs.swiboard
                                  Share with friends.''');
                        },
                        key: ValueKey(
                            'AddNewDevice${Timestamp.now().toString()}'),
                        heroTag:
                            Text('AddNewDevice${Timestamp.now().toString()}'),
                        tooltip: 'Share',
                        mini: true,
                        child: const Icon(Icons.share),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      key: ValueKey('feedback${Timestamp.now().toString()}'),
                      heroTag: Text('feedback${Timestamp.now().toString()}'),
                      tooltip: 'Feedback',
                      mini: true,
                      onPressed: () async {
                        Wiredash.of(context).show(inheritMaterialTheme: true);
                      },
                      child: const Icon(Icons.feedback),
                    ),
                    FloatingActionButton(
                      key:
                          ValueKey('AddNewDevice${Timestamp.now().toString()}'),
                      heroTag:
                          Text('AddNewDevice${Timestamp.now().toString()}'),
                      tooltip: 'Add New Device',
                      mini: true,
                      onPressed: () async {
                        // await thisfirebaseuser.addDeviceDialogueBox(context);
                        await addDeviceDialogueBox(context, widget.pref, ref);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sidemenu,
            Expanded(
                child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    allowImplicitScrolling: true,
                    // pageSnapping: false,
                    controller: page,
                    children: sideMenuPagesList))
          ],
        ));
  }
}

// ######### Add new device dialogue box #################
Future<dynamic> addDeviceDialogueBox(BuildContext context,
    StreamingSharedPreferences pref, WidgetRef ref) async {
  TextEditingController textfieldcontroller =
      TextEditingController(text: 'tasmota_');
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: textfieldcontroller,
            textCapitalization: TextCapitalization.characters,
            autofocus: true,
            decoration: const InputDecoration(
                labelText:
                    'Enter New Device Tasmota Topic (i.e.:tasmota_23FG56)',
                border: OutlineInputBorder(),
                hintText: "i.e. : tasmota_3B02RC"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            addButton(context, textfieldcontroller, pref, ref)
          ],
        );
      });
}

// ########### Add New Device Button ############################
Widget addButton(
    BuildContext context,
    TextEditingController textfieldcontroller,
    StreamingSharedPreferences pref,
    WidgetRef ref) {
  return ElevatedButton(
    child: const Text('OK'),
    onPressed: () async {
      Preference<List<String>> gtopreflist =
          pref.getStringList(tasmotaDeviceListSharedPrefKey, defaultValue: []);
      List<String> currentlist = gtopreflist.getValue();
      if (!currentlist.contains(textfieldcontroller.text)) {
        currentlist = currentlist + [textfieldcontroller.text];
        pref
            .setStringList(tasmotaDeviceListSharedPrefKey, currentlist)
            .then((value) async {
          Navigator.pop(context);

          TasmotaDevice thisDevice = TasmotaDevice(
              deviceTopic1: textfieldcontroller.text, pref1: pref);
          publishEvery5secondStateAndStatusTopic(thisDevice.statusCmndTopic!,
              thisDevice.stateCmndTopic!, thisDevice.deviceTopic!, 3, pref);
          String statusTopic = 'stat/${thisDevice.deviceTopic}/STATUS';
          String resultsTopic = 'stat/${thisDevice.deviceTopic}/RESULT';
          await subscribeToStatusAndResults(
              statusTopic, resultsTopic, thisDevice.deviceTopic!, pref);
        });
      } else {
        Navigator.pop(context);
      }
    },
  );
}

//############ Column of all tasmota devices cards ###################
List<Widget> tasmotaDeviceListWidget(
    List tasmotaDevices,
    ref,
    context,
    StreamingSharedPreferences pref,
    Function setState,
    AdmobReward rewardAd,
    AdmobInterstitial interstitialAd) {
  return tasmotaDevices.map((tasmotaDeviceName) {
    final thisTasmotaDevice =
        TasmotaDevice(deviceTopic1: tasmotaDeviceName.toString(), pref1: pref);
    return thisTasmotaDevice.widgetCardFromSSP(
        context, setState, rewardAd, interstitialAd);
  }).toList();
}

//########### SHOW SNACKBAR F(x) ####################
void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
