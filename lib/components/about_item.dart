import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_university/constants.dart';
import 'package:persian_fonts/persian_fonts.dart';

class AboutItem extends StatelessWidget {
  final String name;
  final String skills;
  final String path;
  final Size size;

  AboutItem({this.name, this.path, this.skills, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.27,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          CircleAvatar(
            radius: size.width * 0.15,
            backgroundColor: kPrimaryColor,
            child: CircleAvatar(
              radius: size.width * 0.15 - 2,
              backgroundColor: Colors.white,
              // child: Image.asset(path, fit: BoxFit.cover, height: 100,),
              backgroundImage: AssetImage(path),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            name ?? 'name',
            textAlign: TextAlign.center,
            style: PersianFonts.Shabnam.copyWith(
              fontSize: size.height * 0.018,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            skills ?? 'Full Stack Developer',
            textAlign: TextAlign.center,
            style: kDescriptionStyle.copyWith(
              fontSize: size.height * 0.018,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
        ],
      ),
    );
  }
}
