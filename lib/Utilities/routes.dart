import 'package:hivecoin/Screens/sign_in/forget_screen.dart';
import 'package:hivecoin/Screens/sign_in/games/game_screen.dart';
import 'package:hivecoin/Screens/sign_in/games/select_game.dart';
import 'package:hivecoin/Screens/sign_in/games/spinning_wheel_game.dart';
import 'package:hivecoin/Screens/sign_in/home_screen/home_screen.dart';
import 'package:hivecoin/Screens/sign_in/settings/setting_screen.dart';
import 'package:hivecoin/Screens/sign_in/settings/signin_setting_screen.dart';
import 'package:hivecoin/Screens/sign_in/welcome_screen/welcome_screen.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_screens.dart';
import 'package:hivecoin/more/privacy_policy_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  HomeScreen.routeName: (context) => HomeScreen(),
  GameScreen.routeName: (context) => GameScreen(),
  SigninSettingsScreen.routeName: (context) => SigninSettingsScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  ForgetScreen.routeName: (context) => ForgetScreen(),
  PrivacyPolicyScreen.routeName: (context) => PrivacyPolicyScreen(),
  SelectGame.routeName: (context) => SelectGame(),
  SpinningWheelScreen.routeName: (context) => SpinningWheelScreen(),
};
