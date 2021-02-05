import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';

import '../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "ثبت نام" : "ورود",
            style: PersianFonts.Shabnam.copyWith(
                color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          login ? "تاکنون ثبت نام نکرده اید؟" : "حساب کاربری دارید؟",
          style: PersianFonts.Shabnam.copyWith(
              color: kPrimaryColor),
        ),
      ],
    );
  }
}
