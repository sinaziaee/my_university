import 'dart:io';

import 'package:dt_front/components/reading_card_list.dart';
import 'package:dt_front/components/trade_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../constants.dart';

class HistoryScreen extends StatefulWidget {
  static String id = 'history_screen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int bookedCount = 0, tradeCount = 0;
  String token;
  int userId;
  String morgageBookUrl = '$baseUrl/api/bookbse/trades/?state=all';
  String tradedUrl = '$baseUrl/api/bookbse/trades/history/?state=all';

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastName = prefs.getString('last_name');
    String firstName = prefs.getString('first_name');
    String username = prefs.getString('username');
    token = prefs.getString('token');
    //TODO
    token = 'Token e87c0878c2aa02c6c3bd3d108fa8960b46bba00f';
    userId = prefs.getInt('user_id');
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.display1,
                        children: [
                          TextSpan(text: "کتاب های رزرو شده "),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FutureBuilder(
                    future: http.get(morgageBookUrl, headers: {
                      HttpHeaders.authorizationHeader: token,
                    }),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        http.Response response = snapshot.data;
                        List<Map> mapList = [];
                        var jsonRes = convert.jsonDecode(
                            convert.utf8.decode(response.bodyBytes));
                        tradeCount = 0;
                        for (Map each in jsonRes) {
                          print('******************');
                          mapList.add(each);
                          tradeCount++;
                          print(each);
                          // print(convert.utf8.decode(each));
                        }
                        // return SizedBox();
                        return Container(
                          height: 250,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tradeCount,
                            itemBuilder: (context, index) {
                              return ReadingListCard(
                                image: (mapList[index]['image'] != null)
                                    ? baseUrl + '/' + mapList[index]['image']
                                    : '',
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
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.display1,
                              children: [
                                TextSpan(text: "کتاب های معامله شده"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FutureBuilder(
                          future: http.get(
                            tradedUrl,
                            headers: {
                              HttpHeaders.authorizationHeader: token,
                            },
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<Response> snapshot) {
                            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                              return SizedBox();
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        // SizedBox(height: 40),
                        // Container(
                        //   height: 80,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(38.5),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         offset: Offset(0, 10),
                        //         blurRadius: 33,
                        //         color: Color(0xFFD3D3D3).withOpacity(.84),
                        //       ),
                        //     ],
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(38.5),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         Expanded(
                        //           child: Padding(
                        //             padding:
                        //                 EdgeInsets.only(left: 30, right: 20),
                        //             child: Row(
                        //               children: <Widget>[
                        //                 Expanded(
                        //                   child: Column(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.end,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: <Widget>[
                        //                       Text(
                        //                         "Crushing & Influence",
                        //                         style: TextStyle(
                        //                           fontWeight: FontWeight.bold,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         "Gary Venchuk",
                        //                         style: TextStyle(
                        //                           color: kLightBlackColor,
                        //                         ),
                        //                       ),
                        //                       Align(
                        //                         alignment:
                        //                             Alignment.bottomRight,
                        //                         child: Text(
                        //                           "خریده شده",
                        //                           style: TextStyle(
                        //                             fontSize: 10,
                        //                             color: kLightBlackColor,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       SizedBox(height: 5),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Image.asset(
                        //                   "assets/images/book-1.png",
                        //                   width: 55,
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           height: 7,
                        //           width: size.width * .65,
                        //           decoration: BoxDecoration(
                        //             color: KBuyBook,
                        //             borderRadius: BorderRadius.circular(7),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 40),
                        // Container(
                        //   height: 80,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(38.5),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         offset: Offset(0, 10),
                        //         blurRadius: 33,
                        //         color: Color(0xFFD3D3D3).withOpacity(.84),
                        //       ),
                        //     ],
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(38.5),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         Expanded(
                        //           child: Padding(
                        //             padding:
                        //                 EdgeInsets.only(left: 30, right: 20),
                        //             child: Row(
                        //               children: <Widget>[
                        //                 Expanded(
                        //                   child: Column(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.end,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: <Widget>[
                        //                       Text(
                        //                         "Crushing & Influence",
                        //                         style: TextStyle(
                        //                           fontWeight: FontWeight.bold,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         "Gary Venchuk",
                        //                         style: TextStyle(
                        //                           color: kLightBlackColor,
                        //                         ),
                        //                       ),
                        //                       Align(
                        //                         alignment:
                        //                             Alignment.bottomRight,
                        //                         child: Text(
                        //                           "فروخته شده",
                        //                           style: TextStyle(
                        //                             fontSize: 10,
                        //                             color: kLightBlackColor,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       SizedBox(height: 5),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 Image.asset(
                        //                   "assets/images/book-1.png",
                        //                   width: 55,
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           height: 7,
                        //           width: size.width * .65,
                        //           decoration: BoxDecoration(
                        //             color: KSellBook,
                        //             borderRadius: BorderRadius.circular(7),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
