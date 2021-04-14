import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivecoin/Services/ad_manager.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/Widgets/banner_advertisement.dart';
import 'package:hivecoin/all_utilities.dart';

class SpinningWheelScreen extends StatefulWidget {
  static final String routeName = "/spinningGameScreen";

  @override
  _SpinningWheelScreenState createState() => _SpinningWheelScreenState();
}

class _SpinningWheelScreenState extends State<SpinningWheelScreen> {
  String msg = "Please come back after 5 minutes.";
  final StreamController _dividerController = StreamController<int>();
  final Duration _enableButtonTime = Duration(minutes: 5);
  Duration _timeDifference = Duration(minutes: 0);
  _enableButton() {
    if (Prefs.instance.getGameOnTime() == 0) return;
    final int _timeStamp = Prefs.instance.getGameOnTime();
    final DateTime _before = DateTime.fromMillisecondsSinceEpoch(_timeStamp);
    final DateTime _now = DateTime.now();
    _timeDifference = _now.difference(_before);
    if (_timeDifference >= _enableButtonTime) {
      Prefs.instance.setGameButtonBool(value: true);
      Prefs.instance.setGameOnTime(value: 0);
      setState(() {});
    }
  }

  bool _buttonDisabled = false;

  final _wheelNotifier = StreamController<double>();

  @override
  void dispose() {
    _dividerController.close();
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  void initState() {
    _enableButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String val = '';
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Spin & Win", style: AppTheme.font),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinningWheel(
                  Image.asset('assets/images/roulette-8-300.png'),
                  width: 310,
                  height: 310,
                  initialSpinAngle: _generateRandomAngle(),
                  spinResistance: 0.1,
                  canInteractWhileSpinning: false,
                  dividers: 8,
                  onUpdate: _dividerController.add,
                  onEnd: _dividerController.add,
                  secondaryImage:
                      Image.asset('assets/images/roulette-center-300.png'),
                  secondaryImageHeight: 110,
                  secondaryImageWidth: 110,
                  shouldStartOrStop: _wheelNotifier.stream,
                ),
                SizedBox(height: 30),
                Prefs.instance.getGameButtonBool()
                    ? CustomButtons.circleButton(
                        color: AppTheme.buttonColor,
                        child: Text(
                          "Start",
                          style: AppTheme.font.copyWith(fontSize: 25),
                        ),
                        onPressed: () async {
                          setState(() {
                            msg =
                                "Please wait for 10 seconds your reward is coming!";
                            Prefs.instance.setGameButtonBool(value: false);
                          });
                          _wheelNotifier.sink.add(_generateRandomVelocity());
                          Timer(10.seconds, () async {
                            setState(() {
                              msg = "Please come back after 5 minutes.";
                            });
                            final _val = await FirebaseFirestore.instance
                                .collection("User")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .get();
                            double _coins = double.parse(_val["coins"]);
                            _coins = _coins + val.toDouble();
                            Fluttertoast.showToast(
                                msg: "$val bittex added to your wallet!");
                            final _sendCoin = _coins.toString();
                            await Future.delayed(Duration(milliseconds: 500));
                            await FirebaseFirestore.instance
                                .collection("User")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .update({"coins": _sendCoin});
                            setState(() {});
                            _showDialog(context: context, data: val);
                            AdManager.instance.showInterstitial();
                          });
                          Prefs.instance.setGameOnTime(
                              value: DateTime.now().millisecondsSinceEpoch);
                        })
                    : Text(
                        msg,
                        style: AppTheme.font.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                SizedBox(height: 30),
                StreamBuilder(
                    stream: _dividerController.stream,
                    builder: (context, snapshot) {
                      val = "0." + snapshot.data.toString();
                      return snapshot.hasData
                          ? RouletteScore(snapshot.data)
                          : Container();
                    }),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BannerAdvertisement(),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;

  _showDialog({BuildContext context, data}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Awesome!'),
              content: Text("you got $data Bittex, Well-done!"),
              actions: [
                CustomButtons.registerButton(
                    () => Navigator.pop(context), "OK", context)
              ],
            ));
  }
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '0.1',
    2: '0.2',
    3: '0.3',
    4: '0.4',
    5: '0.5',
    6: '0.6',
    7: '0.8',
    8: '1.0',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
