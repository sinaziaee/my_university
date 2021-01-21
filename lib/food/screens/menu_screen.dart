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
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(100),
                      //     elevation: 8,
                      //     child: TextField(
                      //       decoration: InputDecoration(
                      //         contentPadding:
                      //         EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      //         hintText: 'Search',
                      //         border: InputBorder.none,
                      //         hintStyle: TextStyle(
                      //           color: Colors.black,
                      //         ),
                      //         suffixIcon: Material(
                      //             borderRadius: BorderRadius.circular(100),
                      //             elevation: 8,
                      //             child: Icon(Icons.search)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(text: "ASAP - ", style: kTitle1Style),
                      //       TextSpan(
                      //         text: "Sienna 76",
                      //         style: kTitle2Style.copyWith(
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Spacer(),
                      // Container(
                      //   width: 40.0,
                      //   height: 40.0,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border: Border.all(color: kGreyColor),
                      //   ),
                      //   child: Icon(Icons.more_horiz),
                      // ),
                      // SizedBox(width: 15.0),
                      // Container(
                      //   width: 40.0,
                      //   height: 40.0,
                      //   padding: EdgeInsets.all(10.0),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: kOrangeAccentColor,
                      //   ),
                      //   child: SvgPicture.asset("assets/slider.svg"),
                      // ),
                    ],
                  ),
                ),
                //? TabBar
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: TabBar(
                //     isScrollable: true,
                //     labelStyle: kTitle1Style,
                //     labelColor: kOrangeColor,
                //     unselectedLabelColor: kGreyColor,
                //     indicatorSize: TabBarIndicatorSize.label,
                //     indicatorColor: kOrangeColor,
                //     tabs: [
                //       Container(
                //         child: Row(
                //           children: [
                //             SvgPicture.asset(
                //               "assets/delivery.svg",
                //               width: 30.0,
                //             ),
                //             SizedBox(width: 15.0),
                //             Tab(text: "Menu")
                //           ],
                //         ),
                //       ),
                //       // Container(
                //       //   child: Row(
                //       //     children: [
                //             // SvgPicture.asset(
                //             //   "assets/pickup.svg",
                //             //   width: 30.0,
                //             // ),
                //             // SizedBox(width: 15.0),
                //             // Tab(text: "Pickup")
                //       //     ],
                //       //   ),
                //       // )
                //     ],
                //   ),
                // )
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
