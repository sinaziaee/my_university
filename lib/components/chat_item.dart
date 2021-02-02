import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatItem extends StatelessWidget {
  final Function onPressed;
  final String username, first_username, second_username;

  ChatItem(
      {this.first_username, this.second_username, this.username, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          onTap: onPressed,
          leading: CircleAvatar(
            child: FadeInImage(
              height: 40,
              image: AssetImage('assets/images/unkown.png'),
              placeholder: AssetImage('assets/images/unkown.png'),
            ),
            radius: 40,
            backgroundColor: Colors.white,
          ),
          title: Text(
            (first_username == username) ? second_username : first_username,
          ),
          subtitle: Text('last message'),
          trailing: Text('last time'),
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: Colors.purple.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: onPressed,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Center(
              child: Text(
                (first_username == username) ? second_username : first_username,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
