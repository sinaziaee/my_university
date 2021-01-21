import 'dart:io';

import 'package:my_university/screens/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_university/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../components/grid_dashboard.dart';
import '../constants.dart';
import 'dart:convert' as convert;


class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String token, username, firstName, lastName;
  int userId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children : [
          Transform.rotate(
            origin: Offset(40, -60),
            angle: 2.4,
            child: Container(
              margin: EdgeInsets.only(
                left: 75,
                top: 40,
              ),
              height: size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors : [Color(0xff6f35a5), Color(0xFFA885FF)],
                ),
              ),
            ),
          ),

          Column(
            children: <Widget>[
              SizedBox(
                height: size.height /7,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Image.asset(
                        "assets/images/shut_down.png",
                        color: Colors.black,
                        width: size.width * 0.1,
                      ),
                      onPressed: () {
                        setState(() {
                          showLogoutDialog()();
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              GridDashboard(context, userId, token, username, firstName, lastName),

            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    username = prefs.getString('username');
    firstName = prefs.getString('first_name');
    lastName = prefs.getString('last_name');
    userId = prefs.getInt('user_id');
    print(userId);
  }

  showLogoutDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'خارج می شوید؟ ',
                        textDirection: TextDirection.rtl,
                        style: PersianFonts.Shabnam.copyWith(
                            color: kPrimaryColor, fontSize: 20),
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
                    logoutApp();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'بله‌',
                          textDirection: TextDirection.rtl,
                          style: PersianFonts.Shabnam.copyWith(
                              color: kPrimaryColor, fontSize: 18),
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
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'خیر',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: PersianFonts.Shabnam.copyWith(
                              color: kPrimaryColor, fontSize: 18),
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

  void logoutApp() async {
    // http.Response response;
    // response = await http.post(
    //   "http://danibazi9.pythonanywhere.com/api/account/logout",
    //   headers: {
    //     HttpHeaders.authorizationHeader: token,
    //     "Accept": "application/json",
    //     "content-type": "application/json",
    //   },
    // );
    // print(response.statusCode);
    // print(token);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }
}
