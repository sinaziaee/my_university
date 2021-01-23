import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:my_university/components/already_have_an_account_acheck.dart';
import 'package:my_university/components/rounded_button.dart';
import 'package:my_university/components/rounded_input_field.dart';
import 'package:my_university/components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'email_verfication_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RegisterationScreen extends StatefulWidget {
  static String id = 'registeration_screen';
  static int theCode;

  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  bool isObscured = true;
  int count = 0;
  Color color = kPrimaryColor;

  onEyePressed() {
    if (isObscured) {
      isObscured = false;
    } else {
      isObscured = true;
    }
    print(isObscured);
    setState(() {});
  }

  String firstName = '', lastName = '', email = '', sid = '', password = '';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kPrimaryColor,
        child: Builder(
          builder: (context) {
            return Container(
              height: size.height,
              width: double.infinity,
              // Here i can use size.width but use double.infinity because both work as a same
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/signup_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_bottom.png",
                      width: size.width * 0.25,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ثبت نام کاربران",
                          style: PersianFonts.Shabnam.copyWith(
                              color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: size.height * 0.03),
                        SvgPicture.asset(
                          "assets/icons/signup.svg",
                          height: size.height * 0.35,
                        ),
                        RoundedInputField(
                          hintText: "آدرس ایمیل",
                          onChanged: (value) {
                            email = value;
                          },
                          icon: Icons.email,
                        ),
                        RoundedInputField(
                          hintText: "شماره دانشجویی",
                          onChanged: (value) {
                            sid = value;
                          },
                          icon: Icons.format_italic,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: RoundedInputField(
                                  visible: false,
                                  hintText: "نام",
                                  onChanged: (value) {
                                    firstName = value;
                                  },
                                  icon: Icons.person,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RoundedInputField(
                                  visible: false,
                                  hintText: "نام خانوادگی",
                                  onChanged: (value) {
                                    lastName = value;
                                  },
                                  icon: Icons.person,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RoundedPasswordField(
                          isObscured: isObscured,
                          onPressed: onEyePressed,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        RoundedButton(
                          color: color,
                          text: "ثبت نام",
                          press: () {
                            checkValidation(context);
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Navigator.popAndPushNamed(context, LoginScreen.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  checkValidation(BuildContext context) async {
    if (email.length == 0) {
      _showDialog(context, 'لطفا آدرس ایمیل را وارد کنید');
      return;
    }
    if (firstName.length == 0) {
      _showDialog(context, 'لطفا نام را وارد کنید');
      return;
    }
    if (lastName.length == 0) {
      _showDialog(context, 'لطفا نام خانوادگی را وارد کنید');
      return;
    }
    if (sid.length != 8) {
      _showDialog(context, 'فرمت شماره دانشجویی اشتباه است');
      return;
    }
    try {
      int.parse(sid);
    } catch (e) {
      _showDialog(context, 'فرمت شماره دانشجویی اشتباه است');
      return;
    }
    if (password.length == 0) {
      _showDialog(context, 'لطفا رمز عبور را وارد کنید');
      return;
    }
    count++;
    if (count > 1) {
      // pass
    } else {
      showSpinner = true;
      setState(() {
        color = Colors.grey[400];
      });
      post(baseUrl, context);
    }
  }

  post(String url, BuildContext context) async {
    Random random = Random();
    Map data = {
      'first_name': firstName.trim(),
      'last_name': lastName.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'student_id': int.parse(sid.trim()),
      'username': firstName.trim() +
          ' ' +
          lastName.trim() +
          random.nextInt(9999999).toString(),
      'mobile_number': 091000000000,
      'role': 'student',
    };
    try {
      http.Response result = await http.post(
        '$url/api/account/register',
        body: convert.json.encode(data),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      if (result.statusCode == 201) {
        Map jsonBody = convert.jsonDecode(result.body);
        print(jsonBody);
        http.Response codeResult = await http.get('$url/api/account/send-email',
            headers: {
              HttpHeaders.authorizationHeader: 'Token ' + jsonBody['token']
            });
        if (codeResult.statusCode == 200) {
          // _showSnackBar(context, 'A verification code is sent to your email');
          var jsonResponse = convert.jsonDecode(codeResult.body);
          print(jsonResponse['vc_code']);
          RegisterationScreen.theCode = jsonResponse['vc_code'];
          print('******************');
          // print(jsonResponse.toString());
          // saving data to shared preferences
          String username = jsonBody['username'];
          String first_name = jsonBody['first_name'];
          String last_name = jsonBody['last_name'];
          int user_id = jsonBody['user_id'];
          String token = jsonBody['token'];
          print(token);
          await addStringToSF(token, user_id, username, first_name, last_name);
          setState(() {
            showSpinner = false;
          });
          Navigator.pushNamed(context, EmailVerificationScreen.id, arguments: {
            'sid': sid,
          });
        } else {
          resetCounter();
          _showDialog(context, 'در ارسال کد تاییدیه مشکلی پیش آمد');
          setState(() {
            showSpinner = false;
          });
          print(codeResult.statusCode);
          print(codeResult.body);
        }
      } else if (result.statusCode == 406) {
        setState(() {
          showSpinner = false;
        });
        resetCounter();
        print(result.body.toString());
        _showDialog(context, 'لطفا ایمیل دانشکده ای وارد کنید');
      } else if (result.statusCode == 500) {
        setState(() {
          showSpinner = false;
        });
        resetCounter();
        _showDialog(context, 'ایمیل وارد شده توسط شخص دیگری استفاده می شود');
      } else {
        setState(() {
          showSpinner = false;
        });
        resetCounter();
        _showDialog(context, result.body);
        print(result.statusCode);
        print(result.body);
      }
    } catch (e) {
      showSpinner = false;
      resetCounter();
      _showDialog(context, 'مشکلی از سمت سرور وجود دارد');
      print("My Error: $e");
    }
  }

  resetCounter() {
    setState(() {
      color = kPrimaryColor;
    });
    count = 0;
  }

  addStringToSF(String token, int user_id, String username, String first_name,
      String last_name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString('token'));
      prefs.setString('token', 'Token $token');
      prefs.setInt('user_id', user_id);
      prefs.setString('username', username);
      prefs.setString('first_name', last_name);
      prefs.setString('last_name', first_name);
    } catch (e) {
      print('error: ' + e);
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
        btnOkColor: Colors.red)..show();
  }

}
