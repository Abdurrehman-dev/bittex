import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';

class Prefs {
  static final Prefs _instance = Prefs._();
  static Prefs get instance => _instance;
  Prefs._();
  static final String _isSignedInKey = "signin";
  static final String _userNameKey = "userName";
  static final String _userEmailKey = "userEmail";
  static final String _isButtonEnabledKey = "buttonEnabled";
  static final String _isGameButtonEnabledKey = "gameButtonEnabled";
  static final String _userCharKey = "char";
  static final String _buttonTime = "buttonTime";
  static final String _gameTime = "gameTime";
  static final String _theme = "theme";
  SharedPreferences _sharedPrefs;

  Future<void> init() async =>
      _sharedPrefs = await SharedPreferences.getInstance();
  void setSignIn({bool value}) {
    _sharedPrefs.setBool(_isSignedInKey, value);
  }

  bool getSigninBool() {
    bool _val = _sharedPrefs.getBool(_isSignedInKey);
    if (_val == null) {
      _val = false;
    }
    return _val;
  }

  setUserName({String value}) => _sharedPrefs.setString(_userNameKey, value);

  String getUserName() => _sharedPrefs.getString(_userNameKey);

  setUserEmail({String value}) => _sharedPrefs.setString(_userEmailKey, value);
  String getUserEmail() => _sharedPrefs.getString(_userEmailKey);
  setUserChar({String value}) => _sharedPrefs.setString(_userCharKey, value);
  String getUserChar() => _sharedPrefs.getString(_userCharKey);
  setButtonBool({bool value}) =>
      _sharedPrefs.setBool(_isButtonEnabledKey, value);
  bool getButtonBool() => _sharedPrefs.getBool(_isButtonEnabledKey) ?? true;
  setGameButtonBool({bool value}) =>
      _sharedPrefs.setBool(_isGameButtonEnabledKey, value);
  bool getGameButtonBool() =>
      _sharedPrefs.getBool(_isGameButtonEnabledKey) ?? true;
  setButtonTime({int value}) => _sharedPrefs.setInt(_buttonTime, value);
  int getButtonTime() => _sharedPrefs.getInt(_buttonTime) ?? 0;
  setGameOnTime({int value}) => _sharedPrefs.setInt(_gameTime, value);
  int getGameOnTime() => _sharedPrefs.getInt(_gameTime) ?? 0;
  setAppTheme({bool value}) => _sharedPrefs.setBool(_theme, value);
  bool getTheme() => _sharedPrefs.getBool(_theme) ?? false;
}
