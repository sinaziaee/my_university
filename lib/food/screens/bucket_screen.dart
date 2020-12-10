import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_university/food/screens/food_history_screen.dart';
import 'package:my_university/food/widgets/order_card.dart';
import 'package:my_university/food/widgets/todayFood.dart';
import 'package:my_university/screens/chat_rooms_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class Bucket extends StatefulWidget {
  static String id = 'bucket_screen';

  @override
  _BucketState createState() => _BucketState();
}

class _BucketState extends State<Bucket> {

  int serveID;

  String postFoodUrl = 'http://danibazi9.pythonanywhere.com/api/food/user/order/add/';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  List<TodayFoods>
  TodayFoodList = [
    // TodayFoods(
    //   name: "جوج",
    //   price: 18000,
    //   image: "assets/joojeh.png",
    // ),
    //
    // TodayFoods(
    //   name: "سلطانی",
    //   price: 20000,
    //   image: "assets/mix.png",
    // ),
  ];


  @override
  Widget build(BuildContext context) {

    Map args = ModalRoute.of(context).settings.arguments;
    TodayFoodList = args["Todayfoodlist"];
    // OrderCard.price = args["price"];
    // OrderCard.picture = args["image"];
    var remain = args["remain"];
    serveID = args["serve_id"];

    print(serveID);




    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: 500,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: TodayFoodList.length,
          itemBuilder: (context, index) {



            TodayFoodList.add(
                TodayFoods(
                    image: TodayFoodList[index].image,
                    price: TodayFoodList[index].price ,
                    name: TodayFoodList[index].name ));


            print(TodayFoodList[index].name);
            print(TodayFoodList[index].price);
            print(TodayFoodList[index].image);


            return OrderCard(


              name: TodayFoodList[index].name,
              price: TodayFoodList[index].price,
              picture: TodayFoodList[index].image,

              onremove: (){
                print(")))");
                TodayFoodList.removeAt(index);
              }


            );

          },
        ),
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
                  "${TodayFoodList[0].price} ",
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
                // PostData();
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

  // PostData() async {
  //       http.Response httpResponse = await http.post(postFoodUrl,
  //           headers: {
  //             HttpHeaders.authorizationHeader: token,
  //             "Accept": "application/json",
  //             "content-type": "application/json",
  //           },
  //           body: convert.jsonEncode(
  //             {
  //               'serve_id': serveID,
  //               // 'count': OrderCard.number,
  //             },
  //           ));
  //       http.Response response;
  //
  //
  //       if (httpResponse.statusCode == 201) {
  //         Map jsonBody = convert.jsonDecode(httpResponse.body);
  //         // selectedBookId = jsonBody['id'];
  //       }
  //
  //       if (response.statusCode == 201) {
  //         // _showDialog(context, "کتاب اضافه شد");
  //       }
  //       else {
  //         print(response.body);
  //         // _showDialog(context, "متاسفانه مشکلی پیش آمد.");
  //       }
  //     }

}
