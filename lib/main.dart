import 'package:flutter/services.dart';
import 'package:hivecoin/Screens/sign_in/home_screen/home_screen.dart';
import 'package:hivecoin/Screens/sign_in/welcome_screen/welcome_screen.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_screens.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/Utilities/routes.dart';
import 'package:hivecoin/provider_files/change_theme_color.dart';
import 'all_utilities.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Prefs.instance.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Prefs.instance.init();
  await Future.delayed(Duration(seconds: 1));
  runApp(ChangeNotifierProvider<ChangeThemeColor>(
      create: (BuildContext context) => ChangeThemeColor(), child: MyApp()));
  if (Prefs.instance.getTheme() == null) {
    Prefs.instance.setAppTheme(value: false);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(/*width*/ 414.0, /*height*/ 736.0),
      builder: () => Consumer<ChangeThemeColor>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            routes: routes,
            initialRoute: WelcomeScreen.routeName,
            debugShowCheckedModeBanner: false,
            theme: value.themeData,
            title: "Bittex Coin",
          );
        },
      ),
    );
  }
}
