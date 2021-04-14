import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:hivecoin/Screens/sign_in/home_screen/home_screen.dart';
import 'package:hivecoin/Services/ad_manager.dart';
import 'package:hivecoin/Services/firebase_remote_config.dart';
import 'package:hivecoin/Services/notification_manager.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_screens.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/Widgets/advertise_button.dart';
import 'package:hivecoin/all_utilities.dart';

class WelcomeScreen extends StatefulWidget {
  static final String routeName = "/welcomeScreen";
  static buildAdvertiseButtons(ConfettiController confettiController) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return AdvertiseButton(confettiController: confettiController);
        },
        itemCount: 9);
  }

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.wait([
      NotificationManager.instance.init(),
      AdManager.initAdManager(),
    ]);
    AdManager.instance.loadInterstitial();
    AdManager.instance.loadRewardedAd();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        Prefs.instance.getSigninBool()
            ? HomeScreen.routeName
            : SignIn.routeName,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotificationManager.instance.scheduleAllNotificationsDaily();
    return Scaffold(
        backgroundColor:
            Prefs.instance.getTheme() ? Colors.green[100] : Colors.black26,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/main_logo.png", height: 150, width: 150),
            SizedBox(height: 25.h),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LinearProgressIndicator(),
            ),
          ],
        ));
  }
}
