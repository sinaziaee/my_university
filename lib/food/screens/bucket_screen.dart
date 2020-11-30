import 'package:flutter/material.dart';
import 'package:my_university/food/screens/food_history_screen.dart';
import 'package:my_university/food/widgets/order_card.dart';

class Bucket extends StatefulWidget {
  @override
  _BucketState createState() => _BucketState();
}

class _BucketState extends State<Bucket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical:50,horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          OrderCard(),
          OrderCard(),
        ],
      ),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  Widget _buildTotalContainer() {
    return Container(
      height: 250.0,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        children: <Widget>[
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       "Subtotal",
          //       style: TextStyle(
          //           color: Color(0xFF9BA7C6),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "23.0",
          //       style: TextStyle(
          //           color: Color(0xFF6C6D6D),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 10.0,
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       "Discount",
          //       style: TextStyle(
          //           color: Color(0xFF9BA7C6),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "10.0",
          //       style: TextStyle(
          //           color: Color(0xFF6C6D6D),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 10.0,
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       "Tax",
          //       style: TextStyle(
          //           color: Color(0xFF9BA7C6),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "0.5",
          //       style: TextStyle(
          //           color: Color(0xFF6C6D6D),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 2.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "مجموع فاکتور ( به تومان ) ",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  "60000",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => History()));
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Center(
                  child: Text(
                    "تکمیل سفارش",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 20.0,
          // ),
        ],
      ),
    );
  }
}
