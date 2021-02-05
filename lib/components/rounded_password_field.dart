import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool isObscured;
  final Function onPressed;
  final FocusNode node;

  RoundedPasswordField({this.onPressed, this.isObscured, this.onChanged, this.node});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        obscureText: isObscured ?? true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        // textDirection: TextDirection.rtl,
        textAlign: TextAlign.end,
        onEditingComplete: () => node.unfocus(), // Submit and hide keyboard/ Move focus to next
        decoration: InputDecoration(
          hintText: "      رمز عبور     ",
          suffixIcon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          icon: IconButton(
              icon: Icon(
                (isObscured == true) ? Icons.visibility_off : Icons.visibility,
                color: kPrimaryColor,
              ),
              onPressed: onPressed),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
