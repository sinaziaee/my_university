import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_university/food/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List reserves = new List();
  // String token = "Token b27f62eb5016a937e753014d45fe0ee27c10e720";
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/starter-image.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: Container(
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
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                 Align
                   (alignment: Alignment.centerRight,
                     child: Text('به سلف آزاد خوش آمدید', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
                SizedBox(height: 20,),
                Align
                  (alignment: Alignment.centerRight,
                    child: Text('زمان رزرو غذاهای فردا را مشاهده کنید', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
                SizedBox(height: 100,),

                   Container(
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
                              child: Text("10 - 11", style: TextStyle(color: Colors.white , fontSize: 20), ),
                            ),
                          ),

                SizedBox(height: 20,),


                Container(
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
                    child: Text("12 - 13", style: TextStyle(color: Colors.white ,fontSize: 20),),
                  ),
                ),

                SizedBox(height: 40,),


                Container(
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
                    child: Text("ورود بدون رزرو (مشاهده منو) ", style: TextStyle(color: Colors.white ,fontSize: 20),),
                  ),
                ),


                SizedBox(height: 60,),

                     Align(
                        child: Text("سلف آزاد دانشگاه علم و صنعت ایران ", style: TextStyle(color: Colors.white70, fontSize: 15),),
                      ),

                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTap() {
    Navigator.push(context,MaterialPageRoute(builder: (context)=>Index()) );
  }
  Widget _buildBody(){
    return Container(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context , int indext){
        return new Container(
          child: new Text(
            indext.toString()
          ),
        );
      }),
    );
  }

  void _SetData() async {
    var url = "http://danibazi9.pythonanywhere.com/api/food/user/serve/all";
    var response = await http.get(url , headers: {
      HttpHeaders.authorizationHeader : token,
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      start_time = jsonResponse[0]["start_serve_time"];
      end_time = jsonResponse[0]["end_serve_time"];
      setState(() {
        print(start_time);
        print(end_time);

      });
    }
  }
  
}