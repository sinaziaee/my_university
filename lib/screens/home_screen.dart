import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:my_university/Professor/faculty_screen.dart';
import 'package:my_university/components/my_list_tile.dart';
import 'package:my_university/event/Screens/events_screen.dart';
import 'package:my_university/food/screens/time_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_university/kheft/books_screen.dart';
import 'package:my_university/screens/about_us_screen.dart';
import 'package:my_university/screens/login_screen.dart';
import 'package:my_university/screens/profile_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert' as convert;
import 'package:my_university/components/home_item.dart';

import '../kheft/chat_rooms_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String token, username, firstName, lastName, email, image;
  int userId;
  Size size;
  AnimationController _controller;
  Animation<double> _animation1;
  Animation<double> _animation2;
  Animation<double> _animation3;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  Map args;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      // )..repeat(reverse: true);
    );
    _controller.forward();
    _animation1 = CurvedAnimation(parent: _controller, curve: Curves.ease);
    _animation2 = CurvedAnimation(
        parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.ease));
    _animation3 = CurvedAnimation(
        parent: _controller, curve: Interval(0.8, 1.0, curve: Curves.ease));
  }

  @override
  void dispose() {
    print('here');
    print('*****************************************');
    _controller.stop(canceled: true);
    _controller.dispose();
    print('*****************************************');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    username = args['username'];
    firstName = args['first_name'];
    lastName = args['last_name'];
    email = args['email'];
    token = args['token'];
    image = args['image'];
    // print(image);
    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      drawer: Drawer(
        child: myDrawer(),
      ),
      body: Stack(
        children: [
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
                  colors: [Color(0xff6f35a5), Color(0xFFA885FF)],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 5),
              child: IconButton(
                icon: Icon(
                  Icons.clear_all,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  _drawerKey.currentState.openDrawer();
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.height / 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/elmoss.png",
                      width: 72,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      width: 72,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 35,
                ),
                Text(
                  "اپلیکیشن جامع دانشگاه من",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                bodyContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  myDrawer() {
    print('***************');
    // print(image);
    print('$baseUrl$image');
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // colorFilter: new ColorFilter.mode(
            //     Colors.black.withOpacity(0.2), BlendMode.dstATop),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 80,
              backgroundColor: kPrimaryColor,
              child: CircleAvatar(
                radius: 78,
                backgroundColor: Colors.white,
                child: FadeInImage(
                  height: 126,
                  placeholder: AssetImage('assets/images/elmoss.png'),
                  image: (image != null)
                      ? NetworkImage('$baseUrl$image')
                      : AssetImage('assets/images/elmoss.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'نام: ${firstName} ${lastName}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'ایمیل: ${email}',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.grey[350],
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MyListTile(
                        text: 'سامانه تغذیه',
                        icon: Icons.fastfood_sharp,
                        onTap: () {
                          onPressed(TimeScreen.id);
                        },
                      ),
                      MyListTile(
                        text: 'سامانه رویداد ها',
                        icon: Icons.event,
                        onTap: () {
                          // onPressed(EventsScreen.id);
                          onPressed(AllEventsScreen.id);
                        },
                      ),
                      MyListTile(
                        text: 'خفت کتاب',
                        icon: Icons.book,
                        onTap: () {
                          onPressed(BooksScreen.id);
                        },
                      ),
                      MyListTile(
                        text: 'گفتگوها',
                        icon: Icons.chat,
                        onTap: () {
                          onPressed(ChatRoomsScreen.id);
                        },
                      ),
                      MyListTile(
                        text: 'اطلاعات اساتید',
                        icon: Icons.person,
                        onTap: () {
                          onPressed(FacultyScreen.id);
                        },
                      ),
                      MyListTile(
                        text: 'پروفایل',
                        icon: Icons.settings,
                        onTap: () {
                          onPressed(ProfileScreen.id);
                        },
                      ),
                      MyListTile(
                        text: 'درباره ی ما',
                        icon: Icons.info_rounded,
                        onTap: () {
                          onPressed(AboutUsScreen.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed(String dest) async{
    dynamic result = await Navigator.pushNamed(context, dest, arguments: {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'token': token,
      'user_id': userId,
      'image': image,
    });
    if(result != null){
      result = result.toString().substring(8, result.toString().length-1);
      image = result;
      print('--------   $image   --------------');
    }
    setState(() {});
  }

  bodyContainer() {
    return Container(
      height: size.height * 0.7,
      child: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/main_top.png",
          //     width: size.width * 0.35,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Image.asset(
          //     "assets/images/login_bottom.png",
          //     width: size.width * 0.4,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ScaleTransition(
                    scale: _animation1,
                    child: Container(
                      decoration: kHomeDecoration,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, BooksScreen.id,
                                arguments: {
                                  'token': token,
                                  'user_id': userId,
                                  'first_name': firstName,
                                  'last_name': lastName,
                                });
                          },
                          child: Container(
                            height: size.height * 0.22,
                            width: size.width * 0.45,
                            child: HomeItem(
                              title: "خفت کتاب",
                              subtitle: "خرید , فروش , تبادل",
                              img: "assets/images/khaft.png",
                              size: size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation1,
                    child: Container(
                      decoration: kHomeDecoration,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, TimeScreen.id,
                                arguments: {
                                  'token': token,
                                  'user_id': userId,
                                  'first_name': firstName,
                                  'last_name': lastName,
                                });
                          },
                          child: Container(
                            height: size.height * 0.22,
                            width: size.width * 0.45,
                            child: HomeItem(
                              title: "سامانه تغذیه",
                              subtitle: "رزرو هوشمند غذا",
                              img: "assets/images/food.png",
                              size: size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ScaleTransition(
                    scale: _animation2,
                    child: Container(
                      decoration: kHomeDecoration,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, AllEventsScreen.id,
                                arguments: {
                                  'token': token,
                                  'user_id': userId,
                                  'first_name': firstName,
                                  'last_name': lastName,
                                });
                          },
                          child: Container(
                            height: size.height * 0.22,
                            width: size.width * 0.45,
                            child: HomeItem(
                              title: "ثبت نام در رویداد ها",
                              subtitle: "ایونت های دانشگاه",
                              img: "assets/images/map.png",
                              size: size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation2,
                    child: Container(
                      decoration: kHomeDecoration,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, FacultyScreen.id,
                                arguments: {
                                  'token': token,
                                  'user_id': userId,
                                  'first_name': firstName,
                                  'last_name': lastName,
                                });
                          },
                          child: Container(
                            height: size.height * 0.22,
                            width: size.width * 0.45,
                            child: HomeItem(
                              title: "اطلاعات اساتید",
                              subtitle: "آشنایی با اساتید",
                              img: "assets/images/prof.png",
                              size: size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ScaleTransition(
                    scale: _animation3,
                    child: Container(
                      decoration: kHomeDecoration,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, ChatRoomsScreen.id,
                                arguments: {
                                  'token': token,
                                  'user_id': userId,
                                  'first_name': firstName,
                                  'last_name': lastName,
                                });
                          },
                          child: Container(
                            height: size.height * 0.22,
                            width: size.width * 0.45,
                            child: HomeItem(
                              title: "گفتگو ها",
                              subtitle: "چت های من",
                              img: "assets/images/chat.png",
                              size: size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: _animation3,
                    child: Container(
                      decoration: kHomeDecoration,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, ProfileScreen.id,
                                arguments: {
                                  'token': token,
                                  'user_id': userId,
                                  'first_name': firstName,
                                  'last_name': lastName,
                                });
                          },
                          child: Container(
                            height: size.height * 0.22,
                            width: size.width * 0.45,
                            child: HomeItem(
                              title: "پروفایل کاربری",
                              subtitle: "اطلاعات من",
                              img: "assets/profile/profile.png",
                              size: size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  showLogoutDialog(BuildContext context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: ' خروج از برنامه',
        desc: message,
        btnOkOnPress: () {
          logoutApp();
        },
        btnOkText: "بله",
        btnOkIcon: Icons.check_circle,
        btnOkColor: Colors.green,
        btnCancelOnPress: () {},
        btnCancelText: "خیر",
        btnCancelIcon: Icons.cancel,
        btnCancelColor: Colors.red)
      ..show();

    // showDialog(
    //   context: context,
    //   child: AlertDialog(
    //     content: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(right: 10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Expanded(
    //                 child: Center(
    //                   child: Text(
    //                     'خارج می شوید؟ ',
    //                     textDirection: TextDirection.rtl,
    //                     style: PersianFonts.Shabnam.copyWith(
    //                         color: kPrimaryColor, fontSize: 20),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Container(
    //           height: 0.5,
    //           width: double.infinity,
    //           color: Colors.grey,
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           children: [
    //             InkWell(
    //               onTap: () {
    //                 logoutApp();
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.only(left: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Text(
    //                       'بله‌',
    //                       textDirection: TextDirection.rtl,
    //                       style: PersianFonts.Shabnam.copyWith(
    //                           color: kPrimaryColor, fontSize: 18),
    //                     ),
    //                     SizedBox(
    //                       width: 20,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Padding(
    //                 padding: EdgeInsets.only(left: 10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'خیر',
    //                       textDirection: TextDirection.rtl,
    //                       textAlign: TextAlign.center,
    //                       style: PersianFonts.Shabnam.copyWith(
    //                           color: kPrimaryColor, fontSize: 18),
    //                     ),
    //                     SizedBox(
    //                       width: 20,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  void logoutApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    // Navigator.pop(context);
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }
}
