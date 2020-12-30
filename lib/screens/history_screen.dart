import 'dart:io';

import 'package:my_university/components/reading_card_list.dart';
import 'package:my_university/components/trade_item.dart';
import 'package:my_university/screens/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../constants.dart';
import 'product_screen.dart';

class HistoryScreen extends StatefulWidget {
  static String id = 'history_screen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int tradeCount = 0, pendingCount = 0;
  String token, seller_username, buyer_username, username;
  int userId;
  String tradeBookUrl = '$baseUrl/api/bookbse/trades/?state=all';

  // String StockBookUrl = '$baseUrl/api/bookbse/stocks/history/';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    username = prefs.getString('username');
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: darkGrey),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.chevron_right, color: Colors.white,),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ],
      //   title: Padding(
      //     padding: EdgeInsets.only(left: 30),
      //     child: Text(
      //       'تاریخچه',
      //       style: const TextStyle(
      //           color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30.0),
      //     ),
      //   ),
      // ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Home2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Center(
                  //   child: Transform.rotate(
                  //     origin: Offset(140, -160),
                  //     angle: 2.4,
                  //     child: Container(
                  //       margin: EdgeInsets.only(
                  //         left: 75,
                  //         top: 40,
                  //       ),
                  //       height: size.height * 0.5,
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(80),
                  //         gradient: LinearGradient(
                  //           begin: Alignment.bottomLeft,
                  //           colors : [Color(0xff6f35a5), Color(0xFFA885FF)],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // SizedBox(height: 80,),
                        Container(
                          // margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        height: MediaQuery.of(context).size.height * 1.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xfffff8ee),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24 ,vertical: 15),
                              child: Text(
                                  "کتاب های رزرو شده",
                                  style:
                                  TextStyle(color: Colors.black ,fontSize: 20 ,
                                      fontWeight: FontWeight.bold)
                              )
                            ),
                            SizedBox(height: 30),
                            FutureBuilder(
                              future: http.get(tradeBookUrl, headers: {
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
                                  print('****** json   ************');
                                  print(jsonResponse);
                                  print('******************');
                                  pendingCount = 0;
                                  for (Map each in jsonResponse) {
                                    if (each['state'] == false) {
                                      mapList.add(each);
                                      pendingCount++;
                                    }
                                  }
                                  if (pendingCount == 0) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(120,0,120,20),
                                            child: Image(
                                                image: AssetImage("assets/images/nobook.png")
                                            ),
                                          ),
                                          Text(
                                            'کتاب رزروی وجود ندارد!',
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  // return SizedBox();
                                  return Container(
                                    height: 250,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: pendingCount,
                                      itemBuilder: (context, index) {
                                        return ReadingListCard(
                                          onPressed: () {
                                            print('tradeId: ' + mapList[index]['id'].toString());
                                            onPressed(
                                              mapList[index]['id'],
                                              token,
                                              (username == mapList[index]['seller_username'])? true : false,
                                            );
                                          },
                                          text: (username == mapList[index]['seller_username']) ? 'برای فروش': 'برای خرید',
                                          image: mapList[index]['image'],
                                          title: mapList[index]['name'],
                                          auth: mapList[index]['author'],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24 ,vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                       "کتاب های معامله شده",
                                      style:
                                      TextStyle(color: Colors.black ,fontSize: 20 ,
                                      fontWeight: FontWeight.bold)
                                  )    ,





                                  SizedBox(height: 20),
                                  FutureBuilder(
                                    future: http.get(
                                      tradeBookUrl,
                                      headers: {
                                        HttpHeaders.authorizationHeader: token,
                                      },
                                    ),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Response> snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.connectionState ==
                                              ConnectionState.done) {
                                        http.Response response = snapshot.data;
                                        List<Map> mapList = [];
                                        var jsonResponse = convert.jsonDecode(
                                            convert.utf8
                                                .decode(response.bodyBytes));
                                        tradeCount = 0;
                                        print('******************');
                                        print(jsonResponse);
                                        print('******************');
                                        for (Map each in jsonResponse) {
                                          if (each['state'] == true) {
                                            mapList.add(each);
                                            tradeCount++;
                                          }
                                        }
                                        if (tradeCount == 0) {
                                          return Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(150,0,150,20),
                                                  child: Image(
                                                      image: AssetImage("assets/images/book2.png")
                                                  ),
                                                ),

                                                Text(
                                                  'کتابی تا کنون مبادله نشده است',
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        // return SizedBox();
                                        return Container(
                                          height: size.height*0.3,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: tradeCount,
                                            itemBuilder: (context, index) {
                                              return TradeItem(
                                                url: mapList[index]['image'],
                                                name: mapList[index]['name'],
                                                author: mapList[index]['author'],
                                                seller: mapList[index]['seller'],
                                                status: mapList[index]['state'],
                                                buyer: mapList[index]['buyer'],
                                                seller_username: mapList[index]['seller_username'],
                                                buyer_username: mapList[index]['client_username'],
                                                onPressed: (){
                                                  onPressed(
                                                    mapList[index]['id'],
                                                    token,
                                                    false,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                          ),
                      ],
                    ),
                  )

              ),
            );
          }

          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: getToken(),
      ),
    );
  }

  onPressed(int id, String token, bool isVisible) async{
    print('username: $username');
    print('trade: $id');
    var result = await Navigator.pushNamed(context, TradeScreen.id, arguments: {
      'trade_id': id,
      'token': token,
      'isVisible': isVisible,
    });
    if(result == true){
      Navigator.pop(context);
    }
  }
}
