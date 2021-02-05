import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_university/components/already_have_an_account_acheck.dart';
import 'package:my_university/components/rounded_button.dart';
import 'package:my_university/components/rounded_input_field.dart';
import 'package:my_university/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constants.dart';
import 'home_screen.dart';
import 'registeration_screen.dart';

// String myUrl = 'http://danibazi9.pythonanywhere.com/api/users-list/';
String myUrl = '$baseUrl/account/login';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = '', email = '';
  bool isObscured = true;
  bool showSpinner = false;

  onEyePressed() {
    if (isObscured) {
      isObscured = false;
    } else {
      isObscured = true;
    }
    print(isObscured);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkStringValueExistence();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.purple.shade200,
        child: Builder(builder: (context) {
          return Container(
            width: double.infinity,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_top.png",
                    width: size.width * 0.35,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    width: size.width * 0.4,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "ورود کاربران",
                        style: PersianFonts.Shabnam.copyWith(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        "assets/icons/login.svg",
                        height: size.height * 0.35,
                      ),
                      SizedBox(height: size.height * 0.03),
                      RoundedInputField(
                        hintText: "آدرس ایمیل",
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      RoundedPasswordField(
                        isObscured: isObscured,
                        onPressed: onEyePressed,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      RoundedButton(
                        text: "ورود",
                        color: kPrimaryColor,
                        press: () {
                          checkValidation(context);
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.popAndPushNamed(
                              context, RegisterationScreen.id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  checkValidation(BuildContext context) async {
    if (email.length == 0) {
      _showDialog(context, 'لطفا آدرس ایمیل را به صورت کامل پر کنید');
      return;
    }
    if (!email.contains('@')) {
      _showDialog(context, 'فرمت ایمیل وارد شده اشتباه است');
      return;
    }
    if (password.length == 0) {
      _showDialog(context, 'لطفا رمز عبور را وارد کنید');
      return;
    }
    setState(() {
      showSpinner = true;
    });
    // String baseUrl = 'http://danibazi9.pythonanywhere.com/';
    // get(baseUrl, context);
    post(baseUrl, context);
  }

  post(String url, BuildContext context) async {
    Map data = {
      'username': email.trim(),
      'password': password.trim(),
    };
    try {
      http.Response result = await http.post(
        '$url/api/account/login',
        body: convert.json.encode(data),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      if (result.statusCode == 200) {
        setState(() {
          showSpinner = false;
        });
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(result.bodyBytes));
        print(jsonResponse['token']);
        print(jsonResponse);
        addStringToSF(
          jsonResponse['token'],
          jsonResponse['user_id'],
          jsonResponse['username'],
          jsonResponse['first_name'],
          jsonResponse['last_name'],
          jsonResponse['email'],
          jsonResponse['image'],
          jsonResponse['mobile_number'],
        );
      } else if (result.statusCode == 400) {
        setState(() {
          showSpinner = false;
        });
        _showDialog(context, 'آدرس ایمیل وجود ندارد یا رمز عبور اشتباه است');
      } else {
        setState(() {
          showSpinner = false;
        });
        _showDialog(context, result.body);
        print(result.statusCode);
        print(result.body);
      }
    } catch (e) {
      _showDialog(context, e);
      setState(() {
        showSpinner = false;
      });
      _showDialog(context, 'مشکلی از سمت سرور بوجد آمده است');
      print("My Error: $e");
    }
  }

  addStringToSF(String token, int user_id, String username, String first_name,
      String last_name, String email, String image, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'Token $token');
    prefs.setInt('user_id', user_id);
    prefs.setString('username', username);
    prefs.setString('first_name', first_name);
    prefs.setString('last_name', last_name);
    prefs.setString('email', email);
    prefs.setString('image', image);
    prefs.setString('phone', phone);
    print(prefs.getString('first_name'));
    print(prefs.getString('last_name'));
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    print('-----------------------------------------');
    print(prefs.getString('image'));
    print('-----------------------------------------');
    // print(prefs.getString('user_id').toString());
    Navigator.popAndPushNamed(context, HomeScreen.id, arguments: {
      'token': prefs.getString('token'),
      'email': prefs.getString('email'),
      'first_name': prefs.getString('first_name'),
      'last_name': prefs.getString('last_name'),
      'username': prefs.getString('username'),
      'phone': prefs.getString('phone'),
      'image': prefs.getString('image'),
    });
  }

  checkStringValueExistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      Navigator.popAndPushNamed(context, HomeScreen.id, arguments: {
        'token': prefs.getString('token'),
        'email': prefs.getString('email'),
        'first_name': prefs.getString('first_name'),
        'last_name': prefs.getString('last_name'),
        'username': prefs.getString('username'),
        'phone': prefs.getString('phone'),
        'image': prefs.getString('image'),
      });
    } else {
      // pass
    }
  }

  _showDialog(BuildContext context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطا',
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
}
