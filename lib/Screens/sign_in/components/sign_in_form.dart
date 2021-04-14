import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivecoin/Screens/sign_in/forget_screen.dart';
import 'package:hivecoin/Screens/sign_in/home_screen/home_screen.dart';
import 'package:hivecoin/Screens/sign_in/sign_up/sign_up_screen.dart';
import 'package:hivecoin/Services/authentication.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Utilities/prefs.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  SignInForm({this.formKey, this.emailController, this.passwordController});
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isLoading = false;
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/images/main_logo.png",
                    height: 150.h, width: 150.w),
                CustomTextFormField(
                  controller: widget.emailController,
                  hintText: "Enter Email",
                  validator: (String validate) {
                    if (validate.isEmpty) {
                      return "Please Enter Email";
                    } else if (!validate.contains("@") ||
                        !validate.contains(".")) {
                      return "Please Enter Valid Email";
                    }
                  },
                ),
                CustomTextFormField(
                  obscuretext: _obsecureText,
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
                  controller: widget.passwordController,
                  hintText: "Enter Password",
                  validator: (String validate) {
                    if (validate.isEmpty) {
                      return "Please Enter password";
                    } else if (validate.length < 6) {
                      return "Your password must be greater than 6!";
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ForgetScreen.routeName);
                        },
                        child: Text("Forget Password?",
                            style: AppTheme.font
                                .copyWith(color: AppTheme.buttonColor)),
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : CustomButtons.registerButton(() async {
                        if (widget.formKey.currentState.validate()) {
                          setState(() => isLoading = true);
                          final result = await Authentication.instance
                              .signInUser(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text);
                          if (result == true) {
                            final userName = await FirebaseFirestore.instance
                                .collection("User")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .get();
                            Prefs.instance.setSignIn(value: true);
                            Prefs.instance
                                .setUserName(value: userName["userName"]);
                            Prefs.instance.setUserEmail(
                                value: FirebaseAuth.instance.currentUser.email);
                            Prefs.instance
                                .setUserChar(value: userName["userName"][0]);
                            await Future.delayed(Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            });
                          } else {
                            setState(() => isLoading = false);
                            Fluttertoast.showToast(
                                msg:
                                    "user name or password is wrong! Please Try again later");
                          }
                          print("SignIn Successfully");
                        }
                      }, "Sign In", context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: AppTheme.font),
                      CustomButtons.roundedButton(
                          context: context,
                          buttonText: "Sign Up",
                          routeName: SignUp.routeName),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
