import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_university/food/models/order.dart';
import 'package:my_university/food/screens/AllFoodDetails.dart';
import 'package:my_university/food/screens/Today_food_details.dart';
import 'package:my_university/food/widgets/AllFoodsCard.dart';
import 'package:my_university/food/widgets/allfoods.dart';
import 'package:my_university/food/widgets/today_card.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_university/screens/trade_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../kheft/chat_rooms_screen.dart';

class DeliveryTab extends StatelessWidget {
  static List<Order> listTodayFoods = [];

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  String startServer;
  String endserver;

  int pendingCount = 0;
  int foodcount = 0;
  var ServeTimeUrl = "http://danibazi9.pythonanywhere.com/api/food/user/serve";

  String url;

  var AllFoodUrl = "http://danibazi9.pythonanywhere.com/api/food/all";

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    String start = args["start"];
    String end = args["end"];
    String date = args["date"];
    print("----");
    print(date);

    // DateTime dateTime = DateTime.now();
    // String date =
    // dateTime.toString().substring(0,10);

    onPressed1(int id, String name, int price, String image, String desc,
        int remain) async {
      var result =
          await Navigator.pushNamed(context, TodayFoodDetails.id, arguments: {
        "namefood": name,
        "price": price,
        "image": image,
        "desc": desc,
        "remain": remain,
        "serve_id": id
      });
    }

    onPressed2(String name, int price, String image, String desc) async {
      var result =
          await Navigator.pushNamed(context, AllFoodDetails.id, arguments: {
        "namefood": name,
        "price": price,
        "image": image,
        "desc": desc,
      });
    }

    onChanged();

    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Stack(children: [
              RefreshIndicator(
                onRefresh: () {
                  return _refresh();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 18.0, top: 15, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "لیست غذاهای امروز",
                          textAlign: TextAlign.right,
                          style: PersianFonts.Shabnam.copyWith(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder(
                          future: http.get(
                              "$ServeTimeUrl/?start_time=$start&end_time=$end&date=$date",
                              headers: {
                                HttpHeaders.authorizationHeader: token,
                              }),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              http.Response response = snapshot.data;
                              List<Map> mapList = [];
                              var jsonResponse = convert.jsonDecode(
                                  convert.utf8.decode(response.bodyBytes));

                              pendingCount = 0;
                              print("=========");
                              print(
                                  "$ServeTimeUrl/?start_time=$start&end_time=$end&date=$date");

                              DateTime dateTime = DateTime.now();
                              String dateLocal =
                                  dateTime.toString().substring(0, 10);
                              print("dateLocal $dateLocal");

                              String timeLocal =
                                  dateTime.toString().substring(11, 19);
                              String hour = timeLocal.substring(0, 2);
                              String min = timeLocal.substring(3, 5);

                              String LocalTime = "$hour$min";

                              int Local = int.parse(LocalTime);

                              for (Map each in jsonResponse) {
                                startServer = start;
                                endserver = end;

                                String starthourServer =
                                    startServer.substring(0, 2);
                                String StartminServer =
                                    startServer.substring(3, 5);
                                String Startserver =
                                    "$starthourServer$StartminServer";
                                int sts = int.parse(Startserver);

                                String endhourServer =
                                    endserver.substring(0, 2);
                                String endminServer = endserver.substring(3, 5);
                                String Endserver =
                                    "$endhourServer$endminServer";
                                int ets = int.parse(Endserver);

                                if (each['serve_id'] != null &&
                                    each['remaining_count'] != 0) {
                                  // if (Local >= sts && Local <= ets   ) {
                                  mapList.add(each);
                                  pendingCount++;
                                }
                                // }
                              }
                              if (pendingCount == 0) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Colors.orange,
                                          Colors.red
                                        ])),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      minWidth: double.infinity,
                                      child: Text(
                                        "غذا برای رزرو تعیین نشده",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // return SizedBox();
                              return Container(
                                alignment: Alignment.bottomRight,
                                height: 250,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  reverse: true,
                                  itemCount: pendingCount,
                                  itemBuilder: (context, index) {
                                    return TodayCard(
                                      onPressed: () {
                                        onPressed1(
                                            mapList[index]["serve_id"],
                                            mapList[index]['name'],
                                            mapList[index]['cost'],
                                            mapList[index]['image'],
                                            mapList[index]['description'],
                                            mapList[index]['remaining_count']);
                                      },

                                      id: mapList[index]['serve_id'],
                                      name: mapList[index]['name'],
                                      price: mapList[index]['cost'],
                                      picture: mapList[index]['image'],
                                      description: mapList[index]
                                          ['description'],
                                      remain: mapList[index]['remaining_count'],

                                      // ontap: _onTap(),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: SpinKitWave(
                                  color: kPrimaryColor,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 18, bottom: 10),
                            child: Text("منوی رستوران (غیر قابل فروش)",
                                textAlign: TextAlign.right,
                                style: PersianFonts.Shabnam.copyWith(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        FutureBuilder(
                          future: http.get(
                            AllFoodUrl,
                            headers: {
                              HttpHeaders.authorizationHeader: token,
                            },
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              http.Response response = snapshot.data;
                              List<Map> mapList = [];
                              var jsonResponse = convert.jsonDecode(
                                  convert.utf8.decode(response.bodyBytes));
                              foodcount = 0;

                              for (Map each in jsonResponse) {
                                if (each['food_id'] != null) {
                                  mapList.add(each);
                                  foodcount++;
                                }
                              }
                              if (foodcount == 0) {
                                return Center(
                                  child: Text(
                                    'غذایی تا کنون اضافه نشده است',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }
                              // return SizedBox();
                              return Container(
                                child: GridView.builder(
                                  itemCount: foodcount,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.0 / 1.3,
                                    crossAxisSpacing: 1.0,
                                    mainAxisSpacing: 1.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    return AllFoodsCard(
                                      onPressed: () {
                                        onPressed2(
                                            mapList[index]['name'],
                                            mapList[index]['cost'],
                                            mapList[index]['image'],
                                            mapList[index]['description']);
                                      },
                                      name: mapList[index]['name'],
                                      price: mapList[index]['cost'],
                                      picture: mapList[index]['image'],
                                      Description: mapList[index]
                                          ['description'],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: SpinKitWave(
                                  color: kPrimaryColor,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]);
          } else {
            return Center(
              child: SpinKitWave(
                color: kPrimaryColor,
              ),
            );
          }
        },
        future: getToken(),
      ),
    );
  }

  Future<bool> _refresh() async {
    onChanged();
    return true;
  }

  onChanged() {
    url = '$ServeTimeUrl';
  }
}
