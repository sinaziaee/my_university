import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatItem extends StatelessWidget {
  final Function onPressed;
  final String username, first_username, second_username;

  ChatItem(
      {this.first_username, this.second_username, this.username, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.purple.shade100,
        ),
        child: Center(
          child: Text(
            (first_username == username) ? second_username : first_username,
          ),
        ),
      ),
    );
  }
}
