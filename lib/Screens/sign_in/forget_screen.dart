import 'package:fluttertoast/fluttertoast.dart';
import 'package:hivecoin/Services/authentication.dart';
import 'package:hivecoin/all_utilities.dart';

class ForgetScreen extends StatefulWidget {
  static final routeName = "/forgetScreen";

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forget Password!"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/main_logo.png",
                  height: 200.h, width: 200.w),
              CustomTextFormField(
                controller: _emailController,
                hintText: "Enter Email",
                validator: (String validate) {
                  if (validate.isEmpty ||
                      !validate.contains("@") ||
                      !validate.contains(".")) {
                    return "Please Enter valid Email!";
                  }
                },
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomButtons.registerButton(() async {
                      if (_formKey.currentState.validate()) {
                        setState(() => _isLoading = true);
                        final forget = await Authentication.instance
                            .forgetPassword(email: _emailController.text);
                        if (forget) {
                          Fluttertoast.showToast(msg: "Password sent!");
                        } else {
                          Fluttertoast.showToast(
                              msg: "Something Wrong Please try again later!");
                        }
                        setState(() => _isLoading = false);
                      }
                    }, "Send", context),
            ],
          ),
        ));
  }
}
