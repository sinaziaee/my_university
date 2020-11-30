import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "سفارش شما با موفقیت ثبت شد", style: TextStyle( color : Colors.white ,fontSize: 20 ,fontWeight: FontWeight.bold),
          ),
        ),
      ),
      ),
    );
  }
}
