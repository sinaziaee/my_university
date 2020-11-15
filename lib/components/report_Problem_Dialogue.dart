import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class report_problem extends StatefulWidget {
  String Complaint;
  static String id = 'report_problem';


  @override
  _report_problemState createState() => _report_problemState();
}


class _report_problemState extends State<report_problem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text("صفحه دادرسی ")),
      backgroundColor: Colors.white,
      body: AlertDialog(
        title: Text("What is your Complaint !!!!!"),
        content: Text("!!!! Do you Really want to Complaint ? !!!!"),

        actions: [
          Container(
            child: FlatButton(onPressed: null, child: Text("*& Yes &*",),
              color: Colors.purple.shade400,
            ),
          ) ,

          FlatButton(onPressed: null, child: Text("*& No &*") ,
          color: Colors.purple.shade400,
          )
        ],
        elevation: 24,
        backgroundColor: Colors.yellowAccent.shade400,
        shape: RoundedRectangleBorder(),
      ),
    );
  }
}


showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("Submit"),
    onPressed: () { },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}










