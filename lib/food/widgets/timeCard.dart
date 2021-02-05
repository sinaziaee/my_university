import 'package:flutter/material.dart';

import '../../constants.dart';
import '../index.dart';

class TimeCard extends StatelessWidget {

  final String start_time;
  final String end_time;
  final Function ontap;
  // final String text;

  const TimeCard({
    this.start_time,
    this.end_time,
    this.ontap,
    // this.text,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.orange
                ]
            )
        ),
        child:  MaterialButton(
          onPressed:
            ontap,

          minWidth: double.infinity,
          child: Text("${replaceFarsiNumber(start_time.toString().substring(0,5))} - ${replaceFarsiNumber(end_time.toString().substring(0,5))}",
            style: TextStyle(color: Colors.black ,fontSize: 23),),
        ),
      ),
    );
  }
}
