import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/all_utilities.dart';

class ChangeThemeColor extends ChangeNotifier {
  changeThemeColor({bool value}) {
    Prefs.instance.setAppTheme(value: value);
    notifyListeners();
  }

  get getThemeColor => Prefs.instance.getTheme() ?? false;

  ThemeData get themeData => getThemeColor
      ? ThemeData.fallback().copyWith(
          primaryColor: Colors.green,
          appBarTheme: AppBarTheme(color: Colors.green),
          scaffoldBackgroundColor: Colors.grey[200],
          dialogBackgroundColor: Colors.green[100])
      : ThemeData.dark();
}
