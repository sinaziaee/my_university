import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';

class EventDetailsScreen extends StatefulWidget {
  static String id = 'event_detail_screen';

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  AnimationController animationController;

  String token,
      startTime,
      endTime,
      organizer,
      name,
      image,
      description,
      holdType,
      location;
  bool isParticipating = false ;
  int cost, capacity, remainingCapacity, eventId;
  String url = '$baseUrl/api/event/user';
  String eventDemandUrl = '$baseUrl/api/event/user/register/';
  Map args = Map();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    token = args['token'];
    eventId = args['event_id'];
    isParticipating = args['isp'];

    eventId = 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('جزئیات ایوند'),
        backgroundColor: Colors.purple.shade300,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
            Navigator.pop(context);
          })
        ],
      ),
      body: FutureBuilder(
        future: http.get('$url/?event_id=$eventId', headers: {
          HttpHeaders.authorizationHeader: token,
        }),
        builder: (context, snapshot) {
          http.Response response = snapshot.data;
          if (snapshot.hasData && snapshot.connectionState==ConnectionState.done){
            var jsonResponse = convert
                .jsonDecode(convert.utf8.decode(response.bodyBytes));
            print(jsonResponse);
            name = jsonResponse['name'];
            startTime = jsonResponse['start_time'];
            endTime = jsonResponse['end_time'];
            organizer = jsonResponse['organizer'];
            description = jsonResponse['description'];
            holdType = jsonResponse['hold-type'];
            cost = jsonResponse['cost'];
            remainingCapacity = jsonResponse['remaining_capacity'];
            location = jsonResponse['location'];
            image = '$baseUrl${jsonResponse['image']}';
            return bodyContainer();
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
  final double infoHeight = 250.0;

  // هر جور میخواین نمایش بدین  even رو
  Widget bodyContainer(){
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: Color(0xFFFFFFFF),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset('assets/images/webInterFace.png'),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color(0xFF3A5160).withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 32.0, left: 18, right: 16),
                            child: Text(
                              name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.27,
                                color: Color(0xFF17262A),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  ' تومان$cost',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: Color(0xFF00B6F0),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "   تعداد بلیط باقی مانده ${remainingCapacity.toString()} ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color: Color(0xFF3A5160),
                                        ),
                                      ),
                                      // Icon(
                                      //   Icons.star,
                                      //   color: Colors.purple,
                                      //   size: 24,
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // AnimatedOpacity(
                          //   duration: const Duration(milliseconds: 500),
                          //   opacity: 0,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: Row(
                          //       children: <Widget>[
                          //         // getTimeBoxUI('24', 'Classe'),
                          //         // getTimeBoxUI('2hours', 'Time'),
                          //         // getTimeBoxUI('24', 'Seat'),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: Text(
                                'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                  letterSpacing: 0.27,
                                  color: Color(0xFF3A5160),
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, bottom: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Container(
                                //   width: 48,
                                //   height: 48,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Color(0xFFFFFFFF),
                                //       borderRadius: const BorderRadius.all(
                                //         Radius.circular(16.0),
                                //       ),
                                //       border: Border.all(
                                //           color: Color(0xFF3A5160)
                                //               .withOpacity(0.2)),
                                //     ),
                                //     child: Icon(
                                //       Icons.add,
                                //       color: Color(0xFF00B6F0),
                                //       size: 28,
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 16,
                                // ),
                                Expanded(
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: (isParticipating)?Colors.green:Colors.red,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: (isParticipating)?Colors.green:Colors.red
                                                .withOpacity(0.5),
                                            offset: const Offset(1.1, 1.1),
                                            blurRadius: 10.0),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        (isParticipating) ? 'ثبت نام' : 'لغو ثبت نام',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          letterSpacing: 0.0,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: Card(
                color: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                elevation: 10.0,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFFFFFFF),
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF213333),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
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
