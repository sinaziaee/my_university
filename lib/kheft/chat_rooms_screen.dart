import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_university/components/chat_item.dart';
import 'package:my_university/constants.dart';
import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

import 'chat_screen.dart';

String token, username, otherUsername;
int userId;

class ChatRoomsScreen extends StatefulWidget {
  static String id = 'chat_rooms_screen';

  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  String chatRoomsUrl = '$baseUrl/api/room-list/';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    username = prefs.getString('username');
    print('token: ' + token);
    return prefs.getString('token');
  }

  changeDateTimeToShamsi(String dateTime) {
    List times = dateTime.split(' ');
    print(times[1]);
    String time = times[1].toString().substring(0, 5);
    // String hourMin = dat.substring(11, timer.length);
    // time = time.substring(0,10);
    // String timeToShow = '';
    // List<String> times = time.split('-');
    // print(times);
    // Gregorian g = Gregorian(int.parse(times[0].toString()),
    //     int.parse(times[1].toString()), int.parse(times[2].toString()));
    // Jalali j = g.toJalali();
    // print(j);
    // timeToShow =
    // '${int.parse(j.year.toString())}-${int.parse(j.month.toString())}-${int.parse(
    //   j.day.toString(),
    // )}';
    // print('timeToShow ' + timeToShow);
    // String tel = replaceFarsiNumber(timeToShow + ' ' + hourMin);
    // print('----- $tel');
    return replaceFarsiNumber(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('لیست گفتگو ها'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: getToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return FutureBuilder(
                  future: http.get(chatRoomsUrl, headers: {
                    HttpHeaders.authorizationHeader: token,
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      http.Response response = snapshot.data;
                      print(response.statusCode);
                      print(response.body);
                      var jsonResponse = convert
                          .jsonDecode(convert.utf8.decode(response.bodyBytes));
                      List<Map> mapList = [];
                      print(jsonResponse);
                      int count = 0;
                      for (Map map in jsonResponse) {
                        count++;
                        mapList.add(map);
                      }
                      if (count == 0) {
                        return Container(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: kPrimaryColor,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 58,
                                    child: Icon(
                                      Icons.close,
                                      size: 100,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'تاکنون هیچ گفتگو نداشته اید.',
                                  style: PersianFonts.Shabnam.copyWith(
                                      fontSize: 20, color: kPrimaryColor),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ChatItem(
                            first_username: mapList[index]['first_user_id'],
                            second_username: mapList[index]['second_user_id'],
                            last_message:
                                (mapList[index]['last_message'].length != 0)
                                    ? mapList[index]['last_message']
                                    : '---------',
                            image: (mapList[index]['sender_image'] != null)
                                ? '$baseUrl${mapList[index]['sender_image']}'
                                : null,
                            last_time_message: (mapList[index]
                                            ['last_message_timestamp']
                                        .length !=
                                    0)
                                ? changeDateTimeToShamsi(
                                    mapList[index]['last_message_timestamp'])
                                : null,
                            onPressed: () {
                              onPressed(
                                  username,
                                mapList[index]['second_user_id'],
                                  mapList[index]['room_id'],
                                mapList[index]['sender_image'],
                              );
                            },
                            username: username,
                          );
                        },
                        itemCount: count,
                      );
                    } else {
                      return Center(
                        child: SpinKitWave(
                          color: kPrimaryColor,
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: SpinKitWave(
                    color: kPrimaryColor,
                  ),
                );
              }
            }),
      ),
    );
  }

  onPressed(String username, String otherUsername, int room_id, String image) async {
    print('username: $username');
    print('otherUsername: $otherUsername');
    await Navigator.pushNamed(context, ChatScreen.id, arguments: {
      'room': room_id,
      'user_id': userId,
      'username': username,
      'other_username': otherUsername,
      'image': image,
    });
    setState(() {});
  }
}
