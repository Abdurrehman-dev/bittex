import 'package:hivecoin/Screens/sign_in/games/game_screen.dart';
import 'package:hivecoin/Screens/sign_in/games/spinning_wheel_game.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import 'package:hivecoin/all_utilities.dart';

class SelectGame extends StatelessWidget {
  static final String routeName = "/selectGameScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Game", style: AppTheme.font),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _selectTile(
                text: "Watch & Earn",
                number: 1,
                onPressed: () {
                  Navigator.pushNamed(context, GameScreen.routeName);
                }),
            _selectTile(
                text: "Spin & Win!",
                number: 2,
                onPressed: () {
                  Navigator.pushNamed(context, SpinningWheelScreen.routeName);
                }),
          ],
        ),
      ),
    );
  }

  _selectTile({int number, String text, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Text(number.toString() + ".",
            style: Prefs.instance.getTheme()
                ? AppTheme.font.copyWith(color: Colors.white)
                : AppTheme.font),
        tileColor: Prefs.instance.getTheme() ? Colors.green : Colors.black87,
        onTap: onPressed,
        title: Text(text,
            style: Prefs.instance.getTheme()
                ? AppTheme.font.copyWith(color: Colors.white)
                : AppTheme.font),
      ),
    );
  }
}
