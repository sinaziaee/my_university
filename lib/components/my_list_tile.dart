import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  MyListTile({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(text),
        leading: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
