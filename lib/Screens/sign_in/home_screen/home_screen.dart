import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivecoin/Services/ad_manager.dart';
import 'package:hivecoin/Services/notification_manager.dart';
import 'package:hivecoin/Widgets/banner_advertisement.dart';
import 'package:hivecoin/all_utilities.dart';
import 'package:supercharged/supercharged.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/Widgets/drawer.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Duration _enableButtonTime = Duration(minutes: 60);
  bool _showMenu = false;
  Duration _timeDifference = Duration(minutes: 0);
  _enableButton() {
    if (Prefs.instance.getButtonTime() == 0) return;
    final int _timeStamp = Prefs.instance.getButtonTime();
    final DateTime _before = DateTime.fromMillisecondsSinceEpoch(_timeStamp);
    final DateTime _now = DateTime.now();
    _timeDifference = _now.difference(_before);
    if (_timeDifference >= _enableButtonTime) {
      Prefs.instance.setButtonBool(value: true);
      Prefs.instance.setButtonTime(value: 0);
      setState(() {});
    }
  }

  @override
  void initState() {
    _enableButton();
    Future.delayed(2.seconds, () => _buildStartupDialog(context));
    NotificationManager.instance.scheduleAllNotificationsDaily();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(
          context: context,
          accountName: Prefs.instance.getUserName(),
          accountEmail: Prefs.instance.getUserEmail(),
          picture: Image.asset("assets/images/main_logo.png",
              height: 230.h, width: 230.w)),
      appBar: AppBar(
        title: Text("Get Some Bittex", style: AppTheme.font),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: 20.h,
            left: 20.w,
            right: 20.w,
            child: Center(
                child: Text(
              "Welcome " + Prefs.instance.getUserName(),
              style: AppTheme.font.copyWith(fontSize: 20),
            ))),
        Positioned(
            top: 50.h,
            left: 0.w,
            right: 0.w,
            child: MirrorAnimation(
              curve: Curves.easeInOut,
              tween: (-0.5).tweenTo(0.5),
              builder: (BuildContext context, Widget child, value) {
                return Transform.rotate(
                  angle: value,
                  child: child,
                );
              },
              child: Center(
                  child: Image.asset("assets/images/background.png",
                      height: 300.h, width: 300.h)),
            )),
        Positioned(
            top: 100.h,
            left: 20.w,
            right: 20.w,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                    child: Text(
                        double.parse(snapshot.data["coins"])
                                .toStringAsFixed(2) +
                            "\nBittex",
                        textAlign: TextAlign.center,
                        style: AppTheme.font.copyWith(
                            fontSize: 25, fontWeight: FontWeight.bold)));
              },
            )),
        Positioned(
            bottom: 60.h,
            left: 20.w,
            right: 20.w,
            child: Center(
              child: Prefs.instance.getButtonBool()
                  ? CustomButtons.circleButton(
                      shadowColor: Colors.green,
                      animation: true,
                      onPressed: () async {
                        final _internet =
                            await InternetAddress.lookup("www.google.com");
                        if (_internet.isEmpty || _internet == null) {
                          Fluttertoast.showToast(msg: "Internet Problem");
                        } else {
                          final _val = await FirebaseFirestore.instance
                              .collection("User")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .get();
                          Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              Prefs.instance.setButtonBool(value: false);
                            });
                          });
                          double _coins = double.parse(_val["coins"]);
                          _coins = _coins + 0.125;
                          Fluttertoast.showToast(
                              msg: "${0.125} bittex added to your wallet!");
                          final _sendCoin = _coins.toString();
                          await Future.delayed(Duration(milliseconds: 500));
                          await FirebaseFirestore.instance
                              .collection("User")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .update({"coins": _sendCoin});
                          setState(() {});
                        }
                        Prefs.instance.setButtonTime(
                            value: DateTime.now().millisecondsSinceEpoch);

                        setState(() {});
                        AdManager.instance.showInterstitial();
                        NotificationManager.instance.scheduleAllNotifications();
                      },
                      color: AppTheme.buttonColor,
                      child: Text(
                        "Get",
                        style: Prefs.instance.getTheme()
                            ? AppTheme.font
                                .copyWith(color: Colors.white, fontSize: 20)
                            : AppTheme.font.copyWith(fontSize: 20),
                      ),
                    )
                  : CustomButtons.circleButton(
                      shadowColor: Colors.red,
                      color: Colors.red,
                      child: Text(
                        "Please\nWait",
                        textAlign: TextAlign.center,
                        style: Prefs.instance.getTheme()
                            ? AppTheme.font
                                .copyWith(color: Colors.white, fontSize: 18)
                            : AppTheme.font.copyWith(fontSize: 18),
                      ),
                      onPressed: () {
                        AdManager.instance.showInterstitial();
                      },
                    ),
            )),
        Positioned(
          bottom: 320.h,
          right: _showMenu ? 0.w : -130.w,
          child: Center(
            child: InkWell(
              onTap: () async {
                await Future.delayed(2.seconds);
                _enableButton();
                setState(() {});
                Fluttertoast.showToast(msg: "Update completed");
                AdManager.instance.showInterstitial();
                _showMenu = false;
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.buttonColor,
                    borderRadius: BorderRadius.circular(10.0)),
                height: 50.h,
                width: 180.w,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          if (_showMenu) {
                            setState(() {
                              _showMenu = false;
                            });
                          } else if (!_showMenu) {
                            setState(() {
                              _showMenu = true;
                            });
                          }
                        }),
                    Center(
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: Prefs.instance.getTheme()
                            ? AppTheme.font.copyWith(color: Colors.white)
                            : AppTheme.font,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(alignment: Alignment.bottomCenter, child: BannerAdvertisement()),
        Positioned(
            bottom: 200.h,
            left: 20.w,
            right: 20.w,
            child: Center(
                child: Text(
              Prefs.instance.getButtonBool()
                  ? ""
                  : "The Button Enable after 1 hour \n\n\"you can earn more coins from playgame section!\""
                      .toUpperCase(),
              style: AppTheme.font.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            ))),
      ],
    );
  }

  _buildStartupDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Image.asset("assets/images/main_logo.png"),
              content: Text(
                  "Get 10,000 Bittex and earn instant 5 to 50 dollars in your bank account as a gift of reaching 10,000 bittex."),
              actions: [
                RaisedButton(
                  color: AppTheme.buttonColor,
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK", style: AppTheme.font),
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
            ));
  }
}
