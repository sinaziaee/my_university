import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_university/screens/books_screen.dart';
import 'dart:convert' as convert;

import 'package:my_university/screens/chat_rooms_screen.dart';

import '../../constants.dart';
import 'event_details_screen.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  TextEditingController eventController = TextEditingController();
  String eventSearch = '',
      eventsUrl = '$baseUrl/api/event/user/all/',
      eventDemandUrl = '$baseUrl/api/event/user/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: eventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewEventScreen(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget eventList() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: eventController,
              onChanged: (value) {
                eventSearch = eventController.text;
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'جست و جو',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: http.get('$eventsUrl', headers: {
              HttpHeaders.authorizationHeader: token,
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                http.Response response = snapshot.data;
                if (response.statusCode >= 400) {
                  print(response.statusCode);
                  print(response.body);
                  try {
                    String jsonResponse = convert
                        .jsonDecode(convert.utf8.decode(response.bodyBytes));
                    if (jsonResponse.startsWith('ERROR: You haven\'t been')) {
                      return errorWidget(
                          'شما به عنوان ارشد دانشکده انتخاب نشدید.');
                    } else {
                      return errorWidget('sth else');
                    }
                  } catch (e) {
                    print(e);
                    return errorWidget('مشکلی درارتباط با سرور پیش آمد');
                  }
                }
                var jsonResponse =
                    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
                // print(jsonResponse);
                List<Map> mapList = [];
                int eventCount = 0;
                // print(jsonResponse);
                for (Map map in jsonResponse) {
                  eventCount++;
                  mapList.add(map);
                  // print(map.toString());
                }
                if (eventCount == 0) {
                  return errorWidget('ایوندی وجود ندارد.');
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return eventBuilder(
                        '$baseUrl${mapList[index]['image']}',
                        mapList[index]['name'],
                        mapList[index]['remaining_capacity'],
                        mapList[index]['event_id'],
                        (mapList[index]['image'] == null) ? false : true,
                      );
                    },
                    itemCount: eventCount,
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
    );
  }

  Widget eventBuilder(String imageUrl, String eventName, int remainingCapacity,
      int eventId, bool imageIsAvailable) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: ListTile(
        onTap: () {
          _navigateToEventDetailScreen(eventId, token);
        },
        leading: (imageIsAvailable)
            ? FadeInImage(
                placeholder: AssetImage('assets/images/junk.jpeg'),
                image: NetworkImage(imageUrl),
              )
            : Image(
                image: AssetImage('assets/images/junk.jpeg'),
              ),
        title: Text(eventName),
        subtitle: Text(remainingCapacity.toString()),
        trailing: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.red,
          onPressed: () {
            participate(false, eventId);
          },
          child: Text(
            'رد رویداد',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  participate(bool isParticipating, int eventId) async {
    print('user_id: $eventId');
    Map map = Map();
    map['user_id'] = eventId;
    map['grant'] = (!isParticipating).toString();
    http.Response response =
        await http.post(url, body: convert.json.encode(map), headers: {
      HttpHeaders.authorizationHeader: token,
      "Accept": "application/json",
      "content-type": "application/json",
    });
    if (response.statusCode == 200) {
      setState(() {});
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Widget errorWidget(String message) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Text(
          message,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  _navigateToEventDetailScreen(int eventId, String token) {
    Navigator.pushNamed(context, EventDetailsScreen.id, arguments: {
      'event_id': eventId,
      'token': token,
    });
  }

  _navigateToNewEventScreen() {
    Navigator.pushNamed(context, EventDetailsScreen.id);
  }
}
