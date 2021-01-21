import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:my_university/food/index.dart';
import 'package:my_university/food/widgets/timeCard.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../screens/chat_rooms_screen.dart';
import '../../screens/chat_rooms_screen.dart';
import 'package:persian_date/persian_date.dart';

class TimeScreen extends StatefulWidget {
  static String id = 'time_screen';

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> with TickerProviderStateMixin {

  DateTime selectedDate = DateTime.now();
  PersianDate persianDate = PersianDate(format: "yyyy/mm/dd  \n DD  , d  MM  ");
  String _datetime = '';
  String _format = 'yyyy-mm-dd';

  get colorList => [Colors.red , Colors.green];
  ////////////////////////////

  showCalendarDialog()async{
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1450,
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
          if (!showTitleActions) {
            _datetime = '$year-$month-$day';
          }
        }, onConfirm: (year, month, day) {
          setState(() {});
          Jalali j = Jalali(year, month, day);
          print("0000 $j");
          date = '${j.day}-${j.month}-${j.year}';
          print("*****");
          print(date);
          selectedDate = j.toDateTime();
          print('dateTime is: $selectedDate');
          _datetime = '$year-$month-$day';
          setState(() {
            _datetime = '$year-$month-$day';
            print('time' + _datetime);
          });
        });
  }



  // DateTime selectedDate = DateTime.now();
  String date = DateTime.now().toString().substring(0, 10);

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  // showCalendarDialog() async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       date = selectedDate.toString().substring(0, 10);
  //       print(selectedDate);
  //     });
  // }
  //





  void _showDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1450,
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
          if (!showTitleActions) {
            _datetime = '$year-$month-$day';
          }
        }, onConfirm: (year, month, day) {
          setState(() {});
          Jalali j = Jalali(year, month, day);
          selectedDate = j.toDateTime();
          print('dateTime is: $selectedDate');
          _datetime = '$year-$month-$day';
          setState(() {
            _datetime = '$year-$month-$day';
            print('time' + _datetime);
          });
        });
  }


  // DateTime selectedDate = DateTime.now();
  // PersianDate persianDate = PersianDate(format: "yyyy/mm/dd  \n DD  , d  MM  ");
  // String _datetime = '';
  // String _format = 'yyyy-mm-dd';
  //
  // get colorList => [Colors.red , Colors.green];
  ////////////////////////////

  // showCalendarDialog()async{
  //   final bool showTitleActions = false;
  //   DatePicker.showDatePicker(context,
  //       minYear: 1300,
  //       maxYear: 1450,
  //       confirm: Text(
  //         'تایید',
  //         style: TextStyle(color: Colors.red),
  //       ),
  //       cancel: Text(
  //         'لغو',
  //         style: TextStyle(color: Colors.cyan),
  //       ),
  //       dateFormat: _format, onChanged: (year, month, day) {
  //         if (!showTitleActions) {
  //           _datetime = '$year-$month-$day';
  //         }
  //       }, onConfirm: (year, month, day) {
  //         setState(() {});
  //         Jalali j = Jalali(year, month, day);
  //         selectedDate = j.toDateTime();
  //         print('dateTime is: $selectedDate');
  //         _datetime = '$year-$month-$day';
  //         setState(() {
  //           _datetime = '$year-$month-$day';
  //           print('time' + _datetime);
  //         });
  //       });
  // }

  int pendingCount = 0;
  var ServeTimeUrl =
      "$baseUrl/api/food/user/serve/all";
  List reserves = new List();
  String start_time;

  String end_time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SetData();
    getToken();
  }




  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    print(selectedDate);
=======
    // _datetime = String.fromCharCodes();
    // Iterable<String> temp =  Jalali.now().toString().substring(7,18).replaceAll(",","-").split(" ").reversed.cast<String>();
    Jalali j = Jalali.now();
    date = '${j.day}-${j.month}-${j.year}';
    // for(int i = 0 ; i < 3 ; i++ ){
    // }
>>>>>>> aae44041d5df64f59f7fd31d69c1a2523b69d28b
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
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.8),
                        Colors.black.withOpacity(.2),
                      ])),
                ),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'به سلف آزاد خوش آمدید',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20 ,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'زمان رزرو غذاهای ${replaceFarsiNumber(selectedDate.toString().substring(0,10))} را مشاهده کنید',
                                  // textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: TextButton.icon(
                                  label: Text(
                                    'تغییر تاریخ',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showCalendarDialog();
                                  },
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FutureBuilder(
                              future: http
                                  .get('${ServeTimeUrl}/?date=${selectedDate.toString().substring(0,10)}', headers: {
                                HttpHeaders.authorizationHeader: token,
                              }),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  http.Response response = snapshot.data;
                                  print(response.statusCode);
                                  print(response.body);
                                  print(date);
                                  List<Map> mapList = [];
                                  var jsonResponse = convert.jsonDecode(
                                      convert.utf8.decode(response.bodyBytes));
                                  print('****** json   ************');
                                  if (jsonResponse
                                      .toString()
                                      .startsWith('ERROR: the date of')) {
                                    return Center(
                                      child: Container(
                                        height: 100,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'لطفا تاریخ دیگری را انتخاب کنید.',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            IconButton(
                                                icon: Icon(Icons.calendar_today,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  showCalendarDialog();
                                                }),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  print(jsonResponse);
                                  print('******************');
                                  pendingCount = 0;
                                  for (Map each in jsonResponse) {
                                    if (each['start_serve_time'] != null ) {
                                      // bool found  = false ;
                                      // for (Map e in mapList.) {
                                      //   if (e == each['start_serve_time']) {
                                      //     found = true;
                                      //     break;
                                      //   }
                                      // }
                                      //
                                      // if(found == false) {
                                      //
                                      // }

                                      mapList.add(each);
                                      pendingCount++;
                                    }
                                  }
                                  if (pendingCount == 0) {
                                    return Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(colors: [
                                              Colors.red,
                                              Colors.orange
                                            ])),
                                        child: MaterialButton(
                                          // onPressed: () => _onTap(),
                                          minWidth: double.infinity,
                                          child: Text(
                                            "زمانی برای رزرو وجود ندارد",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
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
                                            ontap: () {
                                              onPressed1(
                                                  mapList[index]["start_serve_time"].toString().substring(0,5),
                                                  mapList[index]['end_serve_time'].toString().substring(0,5),

                                              );
                                            },
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
                                            start_time: mapList[index]
                                                ['start_serve_time'],
                                            end_time: mapList[index]
                                                ['end_serve_time'],
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
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              child: Text(
                                "سلف آزاد دانشگاه علم و صنعت ایران ",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 15),
                              ),
                            ),
                          ]),
                    ))
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: getToken(),
      ),
    );
  }

  _onTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
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

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        start_time = jsonResponse[0]["start_serve_time"];
        end_time = jsonResponse[0]["end_serve_time"];
        print(start_time);
        print(end_time);
      });
    }
  }

  onPressed1( String start, String end ) async {
    print(start);
    print(end);
    await Navigator.pushNamed(context, Index.id, arguments: {
      "start": start,
      "end": end,
      "date" : selectedDate.toString().substring(0,10)
    });
  }
}
