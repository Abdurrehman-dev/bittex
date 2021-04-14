import 'package:hivecoin/Screens/sign_in/settings/signin_setting_screen.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/all_utilities.dart';
import 'package:hivecoin/all_screens.dart';
import 'package:hivecoin/provider_files/change_theme_color.dart';

class SettingScreen extends StatefulWidget {
  static final String routeName = "/settingScreen";

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: Column(
        children: [
          _listTileWidget(
              onTap: () {
                Navigator.pushNamed(context, SigninSettingsScreen.routeName);
              },
              iconData: Icons.drive_file_rename_outline,
              text: 'Change Name'),
          _listTileWidget(
              onTap: () {},
              iconData: Icons.sticky_note_2_outlined,
              text: 'KYC    \'Coming Soon\''),
          _listTileWidget(
              onTap: () {},
              iconData: Icons.account_balance_wallet,
              text: 'Wallet     \'Coming Soon\''),
          _listTileWidget(
              iconData: Icons.color_lens,
              text: 'Change Theme Color',
              trailing: Prefs.instance.getTheme()
                  ? Text(
                      "light",
                      style: AppTheme.font
                          .copyWith(color: Colors.white, fontSize: 15),
                    )
                  : Text(
                      "dark",
                      style: AppTheme.font.copyWith(fontSize: 15),
                    ),
              onTap: () {
                setState(() {
                  if (Provider.of<ChangeThemeColor>(context, listen: false)
                      .getThemeColor) {
                    Provider.of<ChangeThemeColor>(context, listen: false)
                        .changeThemeColor(value: false);
                  } else {
                    Provider.of<ChangeThemeColor>(context, listen: false)
                        .changeThemeColor(value: true);
                  }
                });
              })
        ],
      ),
    );
  }

  _listTileWidget(
      {IconData iconData, String text, Function onTap, Widget trailing}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Prefs.instance.getTheme() ? Colors.green : Colors.black87,
        onTap: onTap,
        leading: Icon(iconData,
            color: Prefs.instance.getTheme() ? Colors.white : Colors.white),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(15.0)),
        title: Text(text,
            style: Prefs.instance.getTheme()
                ? AppTheme.font.copyWith(color: Colors.white)
                : AppTheme.font),
        trailing: trailing,
      ),
    );
  }
}
