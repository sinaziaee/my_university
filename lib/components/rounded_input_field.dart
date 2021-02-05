import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';

import '../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final bool visible;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.visible,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(visible == null){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextField(
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          textAlign: TextAlign.end,
          style: PersianFonts.Shabnam.copyWith(
              // fontSize: 20
          ),
          decoration: InputDecoration(
            suffixIcon: Visibility(
              visible: visible ?? true,
              child: Icon(
                this.icon ?? Icons.person,
                color: kPrimaryColor,
              ),
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      );
    }
    else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          textAlign: TextAlign.end,
          style: PersianFonts.Shabnam.copyWith(
              // fontSize: 20
          ),
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      );
    }

  }
}
