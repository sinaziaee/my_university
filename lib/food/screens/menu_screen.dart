import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_university/food/screens/delivery_tab.dart';

import '../../constants.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180.0),
          child: Container(
            height: height * 0.6,
            width: width,
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(60),
              ),
            ),

            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:50  , bottom: 20),
                        child: Text(
                          'سلف آزاد دانشگاه علم و صنعت ایران',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: EdgeInsets.all(3
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:Color(0xfffff8ee),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/redlogo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            DeliveryTab(),
            // PickupTab(),
          ],
        ),
      ),
    );
  }
}
