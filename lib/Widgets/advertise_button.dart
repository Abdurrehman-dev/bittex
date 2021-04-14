import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivecoin/Services/ad_manager.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/all_utilities.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AdvertiseButton extends StatefulWidget {
  final ConfettiController confettiController;
  AdvertiseButton({@required this.confettiController});
  @override
  _AdvertiseButtonState createState() => _AdvertiseButtonState();
}

class _AdvertiseButtonState extends State<AdvertiseButton> {
  bool _isEnable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimation(
        curve: Curves.bounceOut,
        duration: 2.seconds,
        delay: 500.milliseconds,
        builder: (BuildContext context, Widget child, value) {
          return Transform.scale(scale: value, child: child);
        },
        tween: 0.0.tweenTo(1.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: _isEnable
                ? () {
                    setState(() {
                      AdManager.instance.showRewardedVideoAd(
                          onRewardedVideoCompleted: () {
                        _reward();
                        widget.confettiController.play();
                        _showDialog(context);
                        setState(() => _isEnable = false);
                      });
                    });
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                  color: _isEnable ? AppTheme.buttonColor : Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
              height: 30.h,
              width: 30.h,
              child: MirrorAnimation(
                  duration: Duration(milliseconds: 600),
                  tween: 3.0.tweenTo(3.5),
                  builder: (BuildContext context, Widget child, value) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Icon(Icons.play_circle_outline,
                      color: Prefs.instance.getTheme()
                          ? Colors.white
                          : Colors.white)),
            ),
          ),
        ));
  }

  _reward() async {
    final _val = await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    double _coins = double.parse(_val["coins"]);
    _coins = _coins + 0.5;
    Fluttertoast.showToast(msg: "${0.5} bittex added to your account!");
    final _sendCoin = _coins.toString();
    await Future.delayed(Duration(milliseconds: 500));
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({"coins": _sendCoin});
    setState(() {});
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text("Reward!", style: AppTheme.font),
              content: Text("Great you earned 0.5 Bittex coins.",
                  style: AppTheme.font),
              actions: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK",
                        style: AppTheme.font.copyWith(color: Colors.white)),
                    color: AppTheme.buttonColor),
              ],
            ));
  }
}
