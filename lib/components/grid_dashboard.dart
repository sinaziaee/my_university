import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:my_university/event/Screens/eventsScreen.dart';
import 'package:my_university/food/screens/time_screen.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/kheft/books_screen.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/kheft/chat_rooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persian_fonts/persian_fonts.dart';

import 'package:my_university/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert' as convert;

class GridDashboard extends StatelessWidget {
  final BuildContext context;
  final String username, token, firstName, lastName;
  final int user_id;


  GridDashboard(this.context, this.user_id, this.token, this.username, this.firstName, this.lastName);

   bool c ;

  Items item1 = new Items(
    title: "خفت کتاب",
    subtitle: "خرید , فروش , تبادل",
    img: "assets/images/khaft.png",
    dest: BooksScreen.id,
  );

  Items item2 = new Items(
    title: "سامانه تغذیه",
    subtitle: "رزرو هوشمند غذا",
    img: "assets/images/food.png",
    dest: TimeScreen.id,
  );
  Items item3 = new Items(
    title: "ثبت نام در رویداد ها",
    subtitle: "ایونت های دانشگاه",
    img: "assets/images/map.png",
    dest: EventsScreen.id,
  );
  Items item4 = new Items(
    title: "اطلاعات اساتید",
    subtitle: "آشنایی با اساتید",
    img: "assets/images/prof.png",
  );
  Items item5 = new Items(
    title: "گفتگو ها",
    subtitle: "چت های من",
    img: "assets/images/chat.png",
    dest: ChatRoomsScreen.id,
  );
  Items item6 = new Items(
    title: "خروج از برنامه",
    subtitle: "",
    img: "assets/images/shut_down.png",
    // dest: showlogoutDialog()
    b:  true,
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return InkWell(
              onTap: (){
                if(data.b == true){
                  showlogoutDialog();
                }

                print('user_id : $user_id');
                Navigator.pushNamed(context, data.dest, arguments: {
                  'token': token,
                  'user_id': user_id,
                  'first_name': firstName,
                  'last_name': lastName,
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color), borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 72,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                    ),

                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                    ),
                    //   style: GoogleFonts.openSans(
                    //       textStyle: TextStyle(
                    //           color: Colors.white38,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.w600)),
                    // ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }



   showlogoutDialog(){
    showDialog(
      context: context,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'خارج می شوید؟ ',
                        textDirection:
                        TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: kPrimaryColor ,
                            fontSize: 17
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    logoutApp();
                  },
                  child: Padding(
                    padding:
                    EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Text(
                          'بلی',
                          textDirection:
                          TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor ,
                              fontSize: 12
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    //selectFromGallery();
                  },
                  child: Padding(
                    padding:
                    EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Text(
                          'خیر',
                          textDirection:
                          TextDirection.rtl,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,

                              color: kPrimaryColor ,
                              fontSize: 12
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  void logoutApp() async{

    http.Response response;
    response = await http.post(
      "http://danibazi9.pythonanywhere.com/api/account/logout",
      headers: {
        HttpHeaders.authorizationHeader: token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    print(response.statusCode);
    print(token);

    if(response.statusCode == 200){
      // Navigator.pop(context);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, LoginScreen.id);
    }

    else{

    }


  }



}

class Items {
  String title;
  String subtitle;
  String img;
  String dest;
  bool b = false ;

  Items({
    this.title,
    this.subtitle,
    this.img,
    this.dest,
    this.b
  });
}
