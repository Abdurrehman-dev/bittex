import 'package:hivecoin/Screens/sign_in/games/game_screen.dart';
import 'package:hivecoin/Screens/sign_in/games/select_game.dart';
import 'package:hivecoin/Screens/sign_in/settings/setting_screen.dart';
import 'package:hivecoin/Screens/sign_in/settings/signin_setting_screen.dart';
import 'package:hivecoin/Screens/sign_in/sign_in_screen.dart';
import 'package:hivecoin/Services/authentication.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/more/privacy_policy_screen.dart';

import '../all_utilities.dart';

Widget drawer({
  final String accountName = "",
  final String accountEmail = "",
  final Widget picture,
  @required final BuildContext context,
}) {
  return Drawer(
    child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(accountName, style: AppTheme.font),
          accountEmail: Text(accountEmail, style: AppTheme.font),
          currentAccountPicture: picture,
        ),
        Expanded(
          child: ListView(
            children: [
              _drawerItems(
                  icon: Icons.videogame_asset,
                  title: "Play Game",
                  onPressed: () {
                    Navigator.pushNamed(context, SelectGame.routeName);
                  }),
              _drawerItems(
                  icon: Icons.settings,
                  title: "Settings",
                  onPressed: () {
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  }),
              _drawerItems(
                  icon: Icons.policy,
                  title: 'Privacy Policy',
                  onPressed: () {
                    Navigator.pushNamed(context, PrivacyPolicyScreen.routeName);
                  }),
              _drawerItems(
                  icon: Icons.logout,
                  title: "Logout",
                  onPressed: () {
                    _showDialog(context, () async {
                      Prefs.instance.setSignIn(value: false);
                      await Authentication.instance.signOut();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, SignIn.routeName);
                    });
                  }),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _drawerItems({IconData icon, String title, Function onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: ListTile(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppTheme.buttonColor, width: 2.0)),
      leading: Icon(icon),
      title: Text(title, style: AppTheme.font),
    ),
  );
}

_showDialog(BuildContext context, Function yesFunction) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text("Are you sure?"),
            content: Text("Are you sure to logout."),
            actions: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: yesFunction,
                child: Text("Yes"),
                color: AppTheme.buttonColor,
              ),
              SizedBox(width: 10.w),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No"),
                color: Colors.red,
              )
            ],
          ));
}
