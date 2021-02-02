import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:my_university/food/index.dart';
import 'package:my_university/food/widgets/timeCard.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../kheft/chat_rooms_screen.dart';
import '../../kheft/chat_rooms_screen.dart';
import 'package:persian_date/persian_date.dart';

class TimeScreen extends StatefulWidget {
  static String id = 'time_screen';

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  Jalali date = Jalali.now();
  String dateToShow, token;

  get colorList => [Colors.red, Colors.green];
  Map args;

  ////////////////////////////

  void showCalendarDialog() {
    String dateToShow = '${date.year}/${date.month}/${date.day}';
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          initial: dateToShow,
          color: kPrimaryColor,
          type: 'date',
          onSelect: (date) {
            print(date);
            List times = date.toString().split('/');
            int year = int.parse(times[0]);
            int month = int.parse(times[1]);
            int day = int.parse(times[2]);
            Jalali j = Jalali(year, month, day);
            dateToShow = '${j.year}-${j.month}-${j.day}';
            this.date = j;
            Gregorian g = j.toGregorian();
            selectedDate = g.toDateTime();
            print(selectedDate);
            setState(() {});
          },
        );
      },
    );
  }

  int pendingCount = 0;
  var serveTimeUrl = "$baseUrl/api/food/user/serve/all";

  Future<bool> _refresh() async {
    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    token = args['token'];
    dateToShow = '${date.year}-${date.month}-${date.day}';
    return Scaffold(
      body: RefreshIndicator(
        color: Colors.white,
        onRefresh: () {
          return _refresh();
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/starter-image.jpg'),
                  fit: BoxFit.cover,
                ),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _refresh();
                          },
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'به سلف آزاد خوش آمدید',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'زمان رزرو غذاهای ${replaceFarsiNumber(dateToShow)} را مشاهده کنید',
                          // textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: http.get(
                        '${serveTimeUrl}/?date=${selectedDate.toString().substring(0, 10)}',
                        headers: {
                          HttpHeaders.authorizationHeader: token,
                        },
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          http.Response response = snapshot.data;
                          print(response.statusCode);
                          print(response.body);
                          print(date);
                          List<Map> mapList = [];
                          var jsonResponse = convert.jsonDecode(
                            convert.utf8.decode(response.bodyBytes),
                          );
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
                                      style: TextStyle(color: Colors.white),
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
                                        colors: [Colors.red, Colors.orange])),
                                child: MaterialButton(
                                  // onPressed: () => _onTap(),
                                  minWidth: double.infinity,
                                  child: Text(
                                    "زمانی برای رزرو وجود ندارد",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
                                        mapList[index]["start_serve_time"]
                                            .toString()
                                            .substring(0, 5),
                                        mapList[index]['end_serve_time']
                                            .toString()
                                            .substring(0, 5),
                                      );
                                    },
                                    start_time: mapList[index]
                                        ['start_serve_time'],
                                    end_time: mapList[index]['end_serve_time'],
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
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
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressed1(String start, String end) async {
    print(start);
    print(end);
    await Navigator.pushNamed(
      context,
      Index.id,
      arguments: {
        "start": start,
        "end": end,
        "date": selectedDate.toString().substring(0, 10)
      },
    );
  }
}
