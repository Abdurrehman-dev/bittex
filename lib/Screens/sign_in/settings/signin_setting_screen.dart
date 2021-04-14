import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supercharged/supercharged.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';

class SigninSettingsScreen extends StatefulWidget {
  static final String routeName = "/signInSettingScreen";

  @override
  _SigninSettingsScreenState createState() => _SigninSettingsScreenState();
}

class _SigninSettingsScreenState extends State<SigninSettingsScreen> {
  final _updateNameController = TextEditingController();
  bool _enable = false;
  @override
  void initState() {
    _updateNameController.text = Prefs.instance.getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings", style: AppTheme.font),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Change Name", style: AppTheme.font.copyWith(fontSize: 40)),
          SizedBox(
            height: 30.h,
          ),
          CustomTextFormField(
            controller: _updateNameController,
            enable: _enable,
          ),
          _enable
              ? CustomButtons.registerButton(() async {
                  await FirebaseFirestore.instance
                      .collection("User")
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .update({"userName": _updateNameController.text}).then(
                          (value) => Fluttertoast.showToast(msg: "Updated"));
                  setState(() {
                    Prefs.instance
                        .setUserName(value: _updateNameController.text);
                    Prefs.instance
                        .setUserChar(value: _updateNameController.text[0]);
                  });
                  await Future.delayed(2.seconds, () {
                    setState(() {
                      _enable = false;
                    });
                  });
                }, "Update", context)
              : CustomButtons.registerButton(() {
                  setState(() {
                    _enable = true;
                  });
                }, "Click to Enable", context),
        ],
      ),
    );
  }

  _getDataFromFireBase() async {
    final _data = await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
  }
}
