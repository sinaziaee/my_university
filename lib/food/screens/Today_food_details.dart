import 'dart:math';

import "package:flutter/material.dart";
import 'package:my_university/food/models/order.dart';
import 'package:my_university/food/screens/bucket_screen.dart';
import 'package:my_university/food/screens/delivery_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class TodayFoodDetails extends StatefulWidget {
  static String id = 'todayDetail_screen';

  final String name;
  final int price;
  final String picture;

  final Function onPressed;
  final int servid;

  TodayFoodDetails(
      {this.name, this.price, this.picture, this.onPressed, this.servid});

  @override
  _TodayFoodDetailsState createState() => _TodayFoodDetailsState();
}

class _TodayFoodDetailsState extends State<TodayFoodDetails> {
  String name;
  int price;
  String picture;

  String description;
  Function onPressed;
  int remain;

  int servid;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Map args = ModalRoute.of(context).settings.arguments;
    name = args["namefood"];
    price = args["price"];
    picture = args["image"];
    description = args["desc"];
    remain = args["remain"];
    servid = args["serve_id"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kBlackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.60,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.red[900].withOpacity(0.9),
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    image: (picture != null)
                        ? NetworkImage(
                            "http://danibazi9.pythonanywhere.com/$picture")
                        : AssetImage('assets/joojeh.png'),
                    placeholder: NetworkImage(
                        "http://danibazi9.pythonanywhere.com/$picture"),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                "$name",
                style: kFoodStyle.copyWith(fontSize: 23.0),
              ),
              SizedBox(height: 25.0),
              Row(
                children: [
                  Row(
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       if(counter>1){
                      //         counter--;
                      //       }
                      //     });
                      //   },
                      //   child: Container(
                      //     width: 40.0,
                      //     height: 40.0,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(color: kGreyColor),
                      //     ),
                      //     child: Icon(
                      //       Icons.remove,
                      //       color: kOrangeColor,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 15.0),
                      // Text(
                      //   counter.toString(),
                      //   style: kTitle1Style,
                      // ),
                      // SizedBox(width: 15.0),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       counter++;
                      //     });
                      //   },
                      //   child: Container(
                      //     width: 40.0,
                      //     height: 40.0,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(color: kOrangeColor),
                      //     ),
                      //     child: Icon(
                      //       Icons.add,
                      //       color: kOrangeColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        " تومان ${price}",
                        style: kFoodStyle.copyWith(fontSize: 25.0),
                      ),
                      Text(
                        " تعداد باقی مانده برای رزرو : $remain ",
                        style: kFoodStyle.copyWith(fontSize: 20.0),
                      ),
                    ],
                  )
                ],
              ),
              // SizedBox(height: 25.0),
              // Text(
              //   "$counter pc ",
              //   style: kSubtitleStyle.copyWith(color: kOrangeColor),
              // ),
              SizedBox(height: 25.0),
              Text(description, style: kFoodStyle),
              SizedBox(height: 25.0),

            ],
          ),
        ),
    ]
      ),
      bottomNavigationBar: Container(
        height: height*0.11,
        width: width,
          color: Colors.red[900].withOpacity(0.9),

        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  setState(
                    () {
                      bool flag = false;
                      for(var each in DeliveryTab.listTodayFoods){
                        if(each.name == name){
                          flag = true;
                          break;
                        }
                      }
                      if(flag == false){
                        DeliveryTab.listTodayFoods.add(Order(
                            name: name, price: price, image: picture, number: 1, serveId: servid));
                      }
                      Navigator.pushNamed(context, Bucket.id);
                    },
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.white,
                child: Text(
                  "اضافه به سبد خرید",
                  style: kTitle2Style.copyWith(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
