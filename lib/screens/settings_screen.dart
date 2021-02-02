import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_university/constants.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  // static final String path = "lib/src/pages/settings/settings1.dart";
  static String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark;
  String token, firstName, lastName, username, email, phone;
  int userId;
  Size size;
  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    firstName = prefs.getString('first_name');
    lastName = prefs.getString('last_name');
    username = prefs.getString('username');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'تنظیمات',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
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
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.purple,
                            child: ListTile(
                              onTap: () {
                                //open edit profile
                              },
                              title: Text(
                                "${firstName} ${lastName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: CircleAvatar(
                                // backgroundImage: NetworkImage(avatars[0]),
                                backgroundColor: Colors.white,
                                child: FadeInImage(
                                  height: 40,
                                  image: AssetImage('assets/images/unkown.png'),
                                  placeholder: AssetImage('assets/images/unkown.png'),
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.fromLTRB(
                                32.0, 8.0, 32.0, 16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.phone,
                                    color: Colors.purple,
                                  ),
                                  title: Text(phone ?? 'شماره ی موبایلی ثبت نشده'),
                                  // trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change password
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.email,
                                    color: Colors.purple,
                                  ),
                                  title: Text('${email}', style: TextStyle(fontSize: 14),),
                                  // trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change language
                                  },
                                ),
                                _buildDivider(),
                                ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.purple,
                                  ),
                                  title: Text("${username}"),
                                  // trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    //open change location
                                  },
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(height: 20.0),
                          // Text(
                          //   "Theme",
                          //   style: TextStyle(
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.indigo,
                          //   ),
                          // ),
                          // ListTile(
                          //   title: Text(_dark ? 'Dark Theme':'Light Theme'),
                          //   trailing: IconButton(
                          //     icon: Icon(FontAwesomeIcons.moon),
                          //     onPressed: () {
                          //       _dark = !_dark;
                          //       setState(() {});
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: 60.0),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -20,
                      child: Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 00,
                      left: 00,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.powerOff,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showLogoutDialog(context, "آیا اطمینان دارید ؟");
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login_bottom.png",
                        width: size.width * 0.6,
                      ),
                    ),

                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
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
          btnCancelOnPress: (){},
          btnCancelText: "خیر",
          btnCancelIcon: Icons.cancel,
          btnCancelColor: Colors.red

      )
        ..show();
  }

  void logoutApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }
}
