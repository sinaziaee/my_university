import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  MessageBubble({this.timestamp, this.text, this.isMe});

  final String timestamp;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (isMe) ? EdgeInsets.only(left: 20, bottom: 10) : EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            elevation: 5.0,
            color: isMe ? Colors.purple.shade200 : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: isMe?0:20, right: isMe?20:0),
            child: Text(
              timestamp.substring(11,16),
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
