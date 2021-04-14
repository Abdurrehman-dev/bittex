import 'package:hivecoin/Screens/sign_in/home_screen/home_screen.dart';
import 'package:hivecoin/Screens/sign_in/sign_in_screen.dart';
import 'package:hivecoin/Screens/sign_in/sign_up/components/sign_up_form.dart';
import 'package:hivecoin/Services/authentication.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';
import 'package:hivecoin/Widgets/button_widgets.dart';
import 'package:hivecoin/Widgets/text_form_field.dart';
import 'package:hivecoin/all_utilities.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatelessWidget {
  static final String routeName = "/signUp";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _againPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bittex SignUp", style: AppTheme.font),
      ),
      body: SignUpForm(
        formKey: formKey,
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
        againPasswordController: _againPasswordController,
      ),
    );
  }
}
