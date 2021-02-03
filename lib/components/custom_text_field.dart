import 'package:flutter/material.dart';
import 'package:my_university/constants.dart';
import 'package:persian_fonts/persian_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final node;
  final String hintText;
  final IconData iconData;
  CustomTextField(
      {this.controller, this.node, this.hintText, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        // textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.end,
        cursorColor: kPrimaryColor,
        controller: controller,
        style: TextStyle(fontSize: 17, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(iconData, color: kPrimaryColor,),
          contentPadding: EdgeInsets.only(
            bottom: 25, //
            left: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.5,
                style: BorderStyle.solid),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.5,
                style: BorderStyle.solid),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.5,
                style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: kPrimaryColor,
                width: 1.5,
                style: BorderStyle.solid),
          ),
        ),
        onEditingComplete: () => node.nextFocus(), // Move focus to next
      ),
    );
  }
}
