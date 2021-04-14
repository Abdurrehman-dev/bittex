import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:hivecoin/Screens/sign_in/welcome_screen/welcome_screen.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Widgets/banner_advertisement.dart';
import 'package:hivecoin/all_utilities.dart';

class GameScreen extends StatefulWidget {
  static final String routeName = "/gameScreen";

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  ConfettiController _controllerCenter;
  List gameWidgets = [];
  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Watch & Earn",
          style: AppTheme.font,
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Watch & Earn more Bittex!",
                    textAlign: TextAlign.center,
                    style: AppTheme.font.copyWith(fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "In Some Countries the ads are not allowed to show. So you can earn coins from Spinning Wheel game!",
                  style: AppTheme.font.copyWith(letterSpacing: 4),
                ),
              ),
              Expanded(
                child: WelcomeScreen.buildAdvertiseButtons(_controllerCenter),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.1,
              shouldLoop: false,
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter, child: BannerAdvertisement()),
        ],
      ),
    );
  }
}
