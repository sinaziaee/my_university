import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_university/event/Screens/new_event_screen.dart';
import 'package:my_university/screens/books_screen.dart';
import 'dart:convert' as convert;
import '../../constants.dart';
import 'event_details_screen.dart';

bool isParticipating = false;

class EventsScreen extends StatefulWidget {
  static String id = 'event_screen';

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  TextEditingController eventController = TextEditingController();
  String eventSearch = '',
      eventsUrl = '$baseUrl/api/event/user/all',
      eventDemandUrl = '$baseUrl/api/event/user/register/';
  Map args;
  String token;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    token = args['token'];
    token = 'Token d402c93776246eee11a88d25b322b6ae88d4d7e1';
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: !isParticipating? Colors.purple:Colors.white,
              onPressed: () {
                isParticipating = false;
                eventsUrl = '$baseUrl/api/event/user/register/';
                setState(() {});
                print('isP: $isParticipating');
              },
              child: Text(
                'رویدادهای ثبت نامی',
                style: TextStyle(
                  color: isParticipating? Colors.purple:Colors.white,
                ),
              ),
            ),
            Spacer(),
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: isParticipating? Colors.purple:Colors.white,
              onPressed: () {
                eventsUrl = '$baseUrl/api/event/user/all';
                isParticipating = true;
                setState(() {});
                print('isP: $isParticipating');
              },
              child: Text(
                'رویداد های موجود',
                style: TextStyle(
                  color: !isParticipating? Colors.purple:Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(Icons.history),
        //     onPressed: () {
        //       // Navigator.pushNamed(context, EventsHistoryScreen.id);
        //     }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple.shade300,
        title: Text(isParticipating?'رویداد های موجود':'رویداد های ثبت نام شده'),
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
        onPressed: () {
          _navigateToNewEventScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<bool> _refresh() async {
    setState(() {});
    return true;
  }

  Widget eventList() {
    return RefreshIndicator(
      onRefresh: () {
        return _refresh();
      },
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
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
                  var jsonResponse = convert
                      .jsonDecode(convert.utf8.decode(response.bodyBytes));
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 150,
                      ),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget eventBuilder(String imageUrl, String eventName, int remainingCapacity,
      int eventId, bool imageIsAvailable) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: ListTile(
        onTap: () {
          _navigateToEventDetailScreen(eventId, token);
        },
        leading: (imageIsAvailable)
            ? FadeInImage(
          placeholder: AssetImage('assets/images/not_found.png'),
          image: NetworkImage(imageUrl),
        )
            : Image(
          image: AssetImage('assets/images/not_found.png'),
        ),
        title: Text(eventName),
        subtitle: Text(remainingCapacity.toString()),
        trailing: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: (isParticipating)?Colors.green:Colors.red,
          onPressed: () {
            participate(eventId);
          },
          child: Text(
            (isParticipating) ? 'ثبت نام' : 'لغو ثبت نام',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  participate(int eventId) async {
    print('here : $isParticipating');
    print('event_id: $eventId');
    print(eventDemandUrl);
    Map map = Map();
    map['event_id'] = eventId;
    map['register'] = (isParticipating).toString();
    http.Response response = await http
        .post(eventDemandUrl, body: convert.json.encode(map), headers: {
      HttpHeaders.authorizationHeader: token,
      "Accept": "application/json",
      "content-type": "application/json",
    });
    if (response.statusCode >= 400) {
      print(response.statusCode);
      print(response.body);
      _showMessageDialog('مشکلی پیش آمد');
      setState(() {});
    } else {
      _showMessageDialog(isParticipating ?'شما در رویداد ثبت نام شدید':'ثبت نام شما لغو شد');
      setState(() {});
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
    Navigator.pushNamed(context, NewEventScreen.id);
  }

  _showMessageDialog(String message) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(message),
        content: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('باشه'),
        ),
      ),
    );
  }
}
