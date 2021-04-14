import 'package:hivecoin/Screens/sign_in/components/sign_in_form.dart';
import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';
import 'package:hivecoin/Utilities/app_theme.dart';

class SignIn extends StatelessWidget {
  static final String routeName = "/signIn";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bittex SignIn", style: AppTheme.font),
      ),
      body: SignInForm(
        formKey: formKey,
        emailController: _emailController,
        passwordController: _passwordController,
      ),
    );
  }
}
