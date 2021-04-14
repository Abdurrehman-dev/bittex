import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivecoin/Screens/sign_in/home_screen/home_screen.dart';
import 'package:hivecoin/Services/authentication.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';
import '../../sign_in_screen.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController againPasswordController;

  SignUpForm(
      {this.formKey,
      this.againPasswordController,
      this.passwordController,
      this.emailController,
      this.nameController});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isLoading = false;
  bool _obsecureText = true;
  bool _obsecureText1 = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset("assets/images/main_logo.png",
                    height: 150.h, width: 150.w),
                CustomTextFormField(
                  controller: widget.nameController,
                  hintText: "Enter Name",
                  validator: (String validate) {
                    if (validate.isEmpty) {
                      return "Please Enter Name";
                    }
                  },
                ),
                CustomTextFormField(
                  controller: widget.emailController,
                  hintText: "Enter Email",
                  validator: (String validate) {
                    if (validate.isEmpty) {
                      return "Please Enter Email";
                    } else if (!validate.contains("@") ||
                        !validate.contains(".") ||
                        !validate.contains(".com")) {
                      return "Please Enter Correct Email";
                    }
                  },
                ),
                CustomTextFormField(
                  sufixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        if (_obsecureText) {
                          _obsecureText = false;
                        } else {
                          _obsecureText = true;
                        }
                      });
                    },
                  ),
                  obscuretext: _obsecureText,
                  controller: widget.passwordController,
                  hintText: "Enter Password",
                  validator: (String validate) {
                    if (validate.isEmpty) {
                      return "Please Enter password";
                    } else if (validate.length < 6) {
                      return "Weak Password!";
                    }
                  },
                ),
                CustomTextFormField(
                  sufixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        if (_obsecureText1) {
                          _obsecureText1 = false;
                        } else {
                          _obsecureText1 = true;
                        }
                      });
                    },
                  ),
                  obscuretext: _obsecureText1,
                  controller: widget.againPasswordController,
                  hintText: "Enter Password Again",
                  validator: (String validate) {
                    if (validate.isEmpty) {
                      return "Please Enter password";
                    } else if (validate.length < 6) {
                      return "Weak Password!";
                    } else if (widget.passwordController.text !=
                        widget.againPasswordController.text) {
                      return 'Password doesn\'t match';
                    }
                  },
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : CustomButtons.registerButton(() async {
                        if (widget.formKey.currentState.validate()) {
                          setState(() => isLoading = true);
                          final _result = await Authentication.instance
                              .registerUser(
                                  name: widget.nameController.text,
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text);
                          if (_result == true) {
                            await FirebaseFirestore.instance
                                .collection("User")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .set({
                              "coins": "50",
                              "userName": widget.nameController.text
                            });
                            Fluttertoast.showToast(msg: "Signed Up");
                            final userName = await FirebaseFirestore.instance
                                .collection("User")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .get();
                            setState(() => isLoading = false);
                            Prefs.instance.setSignIn(value: true);
                            Prefs.instance
                                .setUserName(value: userName["userName"]);
                            Prefs.instance.setUserEmail(
                                value: FirebaseAuth.instance.currentUser.email);
                            Prefs.instance
                                .setUserChar(value: userName["userName"][0]);
                            await Future.delayed(Duration(milliseconds: 300),
                                () {
                              Navigator.popAndPushNamed(
                                  context, HomeScreen.routeName);
                            });
                          } else {
                            setState(() => isLoading = false);
                            Fluttertoast.showToast(
                                msg:
                                    "something wrong maybe internet problem\nor maybe email already exists!");
                          }
                        }
                      }, "Sign Up", context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: AppTheme.font),
                      CustomButtons.roundedButton(
                          context: context,
                          buttonText: "Sign In",
                          routeName: SignIn.routeName),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
