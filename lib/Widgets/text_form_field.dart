import 'file:///F:/flutter_apps/bitcoin_app/hivecoin/lib/all_utilities.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final TextInputType keyBoardType;
  final bool obscuretext;
  final Widget sufixIcon;
  final bool enable;
  CustomTextFormField(
      {this.validator,
      this.sufixIcon,
      this.controller,
      this.hintText,
      this.keyBoardType,
      this.obscuretext = false,
      this.enable = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kIsWeb ? 60 : 10.0, vertical: 10.0),
      child: TextFormField(
        enabled: enable,
        keyboardType: keyBoardType,
        obscureText: obscuretext,
        cursorColor: Colors.green,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            suffixIcon: sufixIcon,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            focusColor: Colors.green),
      ),
    );
  }
}
