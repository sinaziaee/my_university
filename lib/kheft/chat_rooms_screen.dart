import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_university/components/chat_item.dart';
import 'package:my_university/constants.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/kheft/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // print(utf8.decode(response.bodyBytes));
                    // List<Map> jsonResponse = convert.jsonDecode(response.body);
                    // return SizedBox();
                    var jsonResponse = convert
                        .jsonDecode(convert.utf8.decode(response.bodyBytes));
                    List<Map> mapList = [];
                    print(jsonResponse);
                    // if (jsonResponse['detail'] != null) {
                    //   return Center(
                    //     child: Text('Wrong token is sent'),
                    //   );
                    // }
                    int count = 0;
                    // print(jsonResponse);
                    for (Map map in jsonResponse) {
                      count++;
                      mapList.add(map);
                      // print(map.toString());
                    }
                    if (count == 0) {
                      return Container(
                        child: Center(
                          child: Text('تاکنون هیچگونه گفتگو نداشته اید.'),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatItem(
                          first_username: mapList[index]['first_user_id'],
                          second_username: mapList[index]['second_user_id'],
                          onPressed: () {
                            onPressed(
                                username,
                                (username == mapList[index]['first_user_id'])
                                    ? mapList[index]['second_user_id']
                                    : mapList[index]['first_user_id'],
                                mapList[index]['room_id']);
                          },
                          username: username,
                        );
                      },
                      itemCount: count,
                    );
                    return SizedBox();
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/not_found.png',
                              height: 200),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Not found'),
                        ],
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
              );
            } else {
              return Center(
                child: SpinKitWave(
                  color: kPrimaryColor,
                ),
              );
            }
          }),
    );
  }

  onPressed(String username, String otherUsername, int room_id) {
    print('username: $username');
    print('otherUsername: $otherUsername');
    Navigator.pushNamed(context, ChatScreen.id, arguments: {
      'room': room_id,
      'user_id': userId,
      'username': username,
      'other_username': otherUsername,
    });
  }
}
