import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_university/food/index.dart';
import 'package:my_university/food/widgets/timeCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/chat_rooms_screen.dart';
import '../../screens/chat_rooms_screen.dart';


class TimeScreen extends StatefulWidget {
  static String id = 'time_screen';

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> with TickerProviderStateMixin{

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  int pendingCount = 0;
  var ServeTimeUrl = "http://danibazi9.pythonanywhere.com/api/food/user/serve/all";
  List reserves = new List();
  String start_time ;
  String end_time ;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SetData();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/starter-image.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(.9),
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.2),
                            ]
                        )
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align
                              (alignment: Alignment.centerRight,
                                child: Text(
                                  'به سلف آزاد خوش آمدید', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                                )
                            ),
                            SizedBox(height: 20,),
                            Align
                              (alignment: Alignment.centerRight,
                                child: Text(
                                  'زمان رزرو غذاهای امروز را مشاهده کنید',
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),)
                            ),
                            SizedBox(height: 20,),

                            FutureBuilder(
                              future: http.get(ServeTimeUrl, headers: {
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
                                    if (each['start_serve_time'] != null) {
                                      mapList.add(each);
                                      pendingCount++;
                                    }
                                  }
                                  if (pendingCount == 0) {
                                    return Center(

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
                                          onPressed: () => _onTap(),
                                          minWidth: double.infinity,
                                          child: Text("زمانی برای رزرو وجود ندارد", style: TextStyle(color: Colors.white ,fontSize: 20),),
                                        ),
                                      ),
                                    );
                                  }
                                  // return SizedBox();
                                  return SingleChildScrollView(
                                    child: Container(
                                      height: 300,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.vertical,
                                        itemCount: pendingCount,
                                        itemBuilder: (context, index) {
                                          return TimeCard(
                                            // onPressed: () {
                                            //   print('tradeId: ' + mapList[index]['id'].toString());
                                            //   onPressed(
                                            //     mapList[index]['id'],
                                            //     token,
                                            //     (username == mapList[index]['seller_username'])? true : false,
                                            //   );
                                            // },
                                            // text: (username == mapList[index]['seller_username']) ? 'برای فروش': 'برای خرید',
                                            // image: mapList[index]['image'],
                                            start_time: mapList[index]['start_serve_time'],
                                            end_time: mapList[index]['end_serve_time'],
                                            // ontap: _onTap(),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20,),
                            Align(
                                          child: Text("سلف آزاد دانشگاه علم و صنعت ایران ", style: TextStyle(color: Colors.white70, fontSize: 15),),
                                        ),
                          ]
                      )
                  )

                ],
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }


            //   child: Container(
            //     decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //             begin: Alignment.bottomCenter,
            //             colors: [
            //               Colors.black.withOpacity(.9),
            //               Colors.black.withOpacity(.8),
            //               Colors.black.withOpacity(.2),
            //             ]
            //         )
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.all(20.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: <Widget>[
            //            Align
            //              (alignment: Alignment.centerRight,
            //                child: Text('به سلف آزاد خوش آمدید', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
            //           SizedBox(height: 20,),
            //           Align
            //             (alignment: Alignment.centerRight,
            //               child: Text('زمان رزرو غذاهای فردا را مشاهده کنید', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
            //           SizedBox(height: 100,),
            //
            //              Container(
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(10),
            //                         gradient: LinearGradient(
            //                             colors: [
            //                               Colors.yellow,
            //                               Colors.orange
            //                             ]
            //                         )
            //                     ),
            //                     child:  MaterialButton(
            //                         onPressed: () => _onTap(),
            //                         minWidth: double.infinity,
            //                         child: Text("10 - 11", style: TextStyle(color: Colors.white , fontSize: 20), ),
            //                       ),
            //                     ),
            //
            //           SizedBox(height: 20,),
            //
            //
            //           Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 gradient: LinearGradient(
            //                     colors: [
            //                       Colors.yellow,
            //                       Colors.orange
            //                     ]
            //                 )
            //             ),
            //             child:  MaterialButton(
            //               onPressed: () => _onTap(),
            //               minWidth: double.infinity,
            //               child: Text("12 - 13", style: TextStyle(color: Colors.white ,fontSize: 20),),
            //             ),
            //           ),
            //
            //           SizedBox(height: 40,),
            //
            //
            //           Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 gradient: LinearGradient(
            //                     colors: [
            //                       Colors.yellow,
            //                       Colors.orange
            //                     ]
            //                 )
            //             ),
            //             child:  MaterialButton(
            //               onPressed: () => _onTap(),
            //               minWidth: double.infinity,
            //               child: Text("ورود بدون رزرو (مشاهده منو) ", style: TextStyle(color: Colors.white ,fontSize: 20),),
            //             ),
            //           ),
            //
            //
            //           SizedBox(height: 60,),
            //
            //                Align(
            //                   child: Text("سلف آزاد دانشگاه علم و صنعت ایران ", style: TextStyle(color: Colors.white70, fontSize: 15),),
            //                 ),
            //
            //           SizedBox(height: 30,),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          },
          future: getToken(),
      ),
    );
  }

  _onTap() {
    Navigator.push(context,MaterialPageRoute(builder: (context)=>Index()) );
  }

  // Widget _buildTimeCard(String text){
  //   return Container(
  //     child: ListView.builder(
  //       itemCount: 1,
  //         itemBuilder: (BuildContext context , int indext){
  //       return Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             gradient: LinearGradient(
  //                 colors: [
  //                   Colors.yellow,
  //                   Colors.orange
  //                 ]
  //             )
  //         ),
  //         child:  MaterialButton(
  //           onPressed: () => _onTap(),
  //           minWidth: double.infinity,
  //           child: Text(text, style: TextStyle(color: Colors.white ,fontSize: 20),),
  //         ),
  //       );
  //     }),
  //   );
  // }

  Future<FutureBuilder> _SetData() async {
    var url = "http://danibazi9.pythonanywhere.com/api/food/user/serve/all";
    print(token);

    var now = new DateTime.now();
    var formatter = new DateFormat('Hms');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    DateTime StartTime;
    // for(int i = 0 ; i< start_time.length ; i++){
    //    StartTime = DateTime(DateTime.parse(start_time()));
    // }
    print(StartTime);
    // if(now.isAfter(StartTime) && now.isBefore(end_time)){
    //
    // }

    var response = await http.get(url , headers: {
      HttpHeaders.authorizationHeader : token,
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      setState(() {
        var jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        start_time = jsonResponse[0]["start_serve_time"];
        end_time = jsonResponse[0]["end_serve_time"];
        print(start_time);
        print(end_time);

      });
    }
  }
  
}