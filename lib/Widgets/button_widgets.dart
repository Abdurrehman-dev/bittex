import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/all_utilities.dart';
import 'package:simple_animations/simple_animations.dart';

class CustomButtons {
  static final bool isWeb = kIsWeb;
  static Widget registerButton(
      Function onPressed, String text, BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: onPressed,
      minWidth: kIsWeb
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width / 1.2,
      child: Text(text, style: AppTheme.font),
      color: AppTheme.buttonColor,
    );
  }

  static Widget roundedButton(
      {String buttonText, BuildContext context, String routeName}) {
    return RaisedButton(
      color: AppTheme.buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
        buttonText,
        style: AppTheme.font,
      ),
      onPressed: () {
        Navigator.popAndPushNamed(context, routeName);
      },
    );
  }

  static Widget circleButton(
      {Function onPressed,
      Widget child,
      Color color,
      bool animation = false,
      Color shadowColor = Colors.transparent}) {
    return InkWell(
      onTap: onPressed,
      child: MirrorAnimation(
        builder: (BuildContext context, Widget child, value) {
          return Transform.scale(scale: value, child: child);
        },
        tween: animation ? 0.8.tweenTo(1.0) : 1.0.tweenTo(1.0),
        duration: 500.milliseconds,
        child: Container(
          height: 120.h,
          width: 120.h,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 12.0, color: shadowColor)]),
          child: Center(child: child),
        ),
      ),
    );
  }
}
