import 'package:flutter/material.dart';
import 'package:my_university/screens/books_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_university/components/griddashboard.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                        "assets/images/notification.png",
                        width: size.width * 0.1,
                      ),
                      onPressed: () {
                        setState(() {
                          print(size.width);
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),

              GridDashboard(),


            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, BooksScreen.id);
      //   },
      //   child: Icon(Icons.book),
      // ),
      // body: Center(
      //   child: Text('Home'),
      // ),
    );
  }
}
