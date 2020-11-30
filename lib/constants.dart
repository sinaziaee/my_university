import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kAnimationDuration = Duration(milliseconds: 200);
const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
const Color darkGrey = Color(0xff202020);
const KSellBook = Color(0xFFFF0000);
const KBuyBook = Color(0xFF00FF00);

LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);
String baseUrl = 'http://danibazi9.pythonanywhere.com';
screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

const kOrangeColor = Color(0xFFFFA451);
const kOrangeAccentColor = Color(0xFFFEE6A7);
const kGreyColor = Color(0xFFB2B4C1);
const kWhiteColor = Color(0xFFF9FAFB);
const kRedColor = Color(0xFFFF7051);
const kBrownColor = Color(0xFF6C6C6C);

var kTitle1Style = GoogleFonts.roboto(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);
var kTitle2Style = GoogleFonts.roboto(
  fontSize: 18.0,
  color: kBlackColor,
);

var kSubtitleStyle = GoogleFonts.roboto(
  fontSize: 15.0,
  color: kGreyColor,
);
var kSubtitle2Style = GoogleFonts.roboto(
  fontSize: 10.0,
  color: kGreyColor,
);

var kChipStyle = GoogleFonts.roboto(
  fontSize: 15.0,
  color: kWhiteColor,
);

var kDescriptionStyle = GoogleFonts.roboto(
  fontSize: 16.0,
  color: kBrownColor,
  height: 1.5,
);

