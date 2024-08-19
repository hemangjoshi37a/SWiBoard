import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

//########################## ADHELPER #################################
class AdHelper {
  static String bannerAdUnitId(BuildContext context) {
    if (kIsWeb) {
      return 'XXXXXXXXXXXXXXXXXXXXXX';
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return 'ca-app-pub-XXXXXXXXXXXXXXXXXXXX';
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        return 'XXXXXXXXXXXXXXXXXXX';
      } else {
        return 'XXXXXXXXXXXXXXXXXXX';
      }
    }
  }

  static String interstitialAdUnitId(BuildContext context) {
    if (kIsWeb) {
      return 'XXXXXXXXXXXXXXXXXXXXXX';
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return "ca-app-pub-XXXXXXXXXXXXXXXXXXXXXXXXXXX";
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        return "XXXXXXXXXXXXXXXXXXX";
      } else {
        return 'XXXXXXXXXXXXXXXXXXX';
      }
    }
  }

  static String rewardedAdUnitId(BuildContext context) {
    if (kIsWeb) {
      return 'XXXXXXXXXXXXXXXXXXXXXX';
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return "ca-app-pub-XXXXXXXXXXXXXXXXXX";
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        return "XXXXXXXXXXXXXXXXXXX";
      } else {
        return 'XXXXXXXXXXXXXXXXXXX';
      }
    }
  }

  static String get myTestDeviceID {
    return 'YOUR_TEST_DEVICE_ID_1';
  }

  static String get myTestDeviceID2 {
    return 'YOUR_TEST_DEVICE_ID_2';
  }
}
//######################################################################

//###################### ADHELPER TEST #################################
class AdHelperTest {
  static String bannerAdUnitId(BuildContext context) {
    if (kIsWeb) {
      return 'XXXXXXXXXXXXXXXXXXXXXX';
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return 'ca-app-pub-XXXXXXXXXXXXXXXXXXX';
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        return 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
      } else {
        return 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
      }
    }
  }

  static String interstitialAdUnitId(BuildContext context) {
    if (kIsWeb) {
      return 'XXXXXXXXXXXXXXXXXXXXXX';
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return "ca-app-pub-XXXXXXXXXXXXXXX";
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        return "XXXXXXXXXXXXXXXXXXXXXX";
      }
    }
  }

  static String rewardedAdUnitId(BuildContext context) {
    if (kIsWeb) {
      return 'XXXXXXXXXXXXXXXXXXXXXX';
    } else {
      if (Theme.of(context).platform == TargetPlatform.android) {
        return "ca-app-pub-XXXXXXXXXXXXXXXX";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        return 'XXXXXXXXXXXXXXXXXXXXXX';
      }
    }
  }

  static String get myTestDeviceID {
    return 'YOUR_TEST_DEVICE_ID_1';
  }

  static String get myTestDeviceID2 {
    return 'YOUR_TEST_DEVICE_ID_2';
  }
}
//######################################################################

//################## HANDLE AD EVENT F(x)#########################
void handleAdEvent(
    AdmobAdEvent event,
    Map<String, dynamic>? args,
    String adType,
    GlobalKey<ScaffoldState> scaffoldState,
    BuildContext context) {
  switch (event) {
    case AdmobAdEvent.loaded:
      // showSnackBar('New Admob $adType Ad loaded!',context);
      break;
    case AdmobAdEvent.opened:
      // showSnackBar('Admob $adType Ad opened!',context);
      break;
    case AdmobAdEvent.closed:
      // showSnackBar('Admob $adType Ad closed!',context);
      break;
    case AdmobAdEvent.failedToLoad:
      // showSnackBar('Admob $adType failed to load. :(',context);
      break;
    case AdmobAdEvent.rewarded:
      showDialog(
        context: scaffoldState.currentContext!,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              return true;
            },
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Reward callback fired. Thanks Andrew!'),
                  Text('Type: ${args!['type']}'),
                  Text('Amount: ${args['amount']}'),
                ],
              ),
            ),
          );
        },
      );
      break;
    default:
  }
}
