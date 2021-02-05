import 'package:my_university/components/rounded_button.dart';
import 'package:my_university/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../constants.dart';
import 'home_screen.dart';
import 'registeration_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  static String id = 'email_verification_screen';

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

addStringToSF(
    String token,
    int user_id,
    String username,
    String first_name,
    String phone,
    String last_name,
    String image,
    String email,
    String sid) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    prefs.setString('token', 'Token $token');
    prefs.setInt('user_id', user_id);
    prefs.setString('username', username);
    prefs.setString('first_name', last_name);
    prefs.setString('last_name', first_name);
    prefs.setString('phone', phone);
    prefs.setString('image', image);
    prefs.setString('email', email);
    prefs.setString('sid', sid);
  } catch (e) {
    print('error: ' + e);
  }
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>
    with SingleTickerProviderStateMixin {
  String code = '';
  int theCode = RegisterationScreen.theCode;
  String sid;
  bool showSpinner = false;
  AnimationController controller;
  Animation<double> animation;
  int progress = 0;
  Color color = kPrimaryColor;
  int count = 0;
  String username, token, phone, first_name, last_name, image, email;
  int user_id;

  FocusNode node;

  @override
  void initState() {
    super.initState();
    reset();
    controller = AnimationController(
        duration: const Duration(seconds: 120), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
          progress = (animation.value * 120).round();
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    // _showSnackBar(context, 'A verification code is sent to your email');
    sid = arguments['sid'];
    user_id = arguments['user_id'];
    username = arguments['username'];
    print(username);
    first_name = arguments['first_name'];
    last_name = arguments['last_name'];
    token = arguments['token'];
    email = arguments['email'];
    image = arguments['image'];
    phone = arguments['phone'];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kPrimaryColor,
        child: Builder(builder: (context) {
          return Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_top.png",
                    width: size.width * 0.3,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_bottom.png",
                    width: size.width * 0.2,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "به اپلیکیشن دانشگاه من خوش آمدید",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.05),
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        height: size.height * 0.45,
                      ),
                      SizedBox(height: size.height * 0.05),
                      RoundedInputField(
                        hintText: "کد تایید را وارد کنید",
                        onChanged: (value) {
                          code = value;
                        }, node: node,
                      ),
                      RoundedButton(
                        text: "بررسی",
                        color: kPrimaryColor,
                        press: () {
                          checkValidation(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ایمیل را دریافت نکرده اید ؟ '),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                showSpinner = true;
                              });
                              controller.stop();
                              controller.forward();
                              resendEmail(context);
                              // }
                            },
                            child: Text(
                              'ارسال دوباره',
                              style: TextStyle(color: color),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: (progress != 120)
                                ? Text((120 - progress).toString() +
                                    ' زمان باقی مانده ')
                                : Text('کد شما منقضی شده'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: LinearProgressIndicator(
                              value: animation.value,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ],
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

  reseter() {
    count = 0;
    color = kPrimaryColor;
  }

  void reset() {
    Future.delayed(
        Duration(
          seconds: 120,
        ), () {
      theCode = null;
      RegisterationScreen.theCode = null;
      print(theCode);
    });
  }

  void resendEmail(BuildContext context) async {
    String url =
        'http://danibazi9.pythonanywhere.com/api/send-email/${int.parse(sid)}';
    try {
      http.Response codeResult = await http.get('$url');
      if (codeResult.statusCode == 200) {
        showSpinner = false;
        _showSnackBar(
            context, 'یک کد تایید تا سی ثانیه دیگر برای شما ایمیل خواهد شد');
        var jsonResponse = convert.jsonDecode(codeResult.body);
        print(jsonResponse['vc_code']);
        RegisterationScreen.theCode = jsonResponse['vc_code'];
        theCode = jsonResponse['vc_code'];
        setState(() {
          showSpinner = false;
        });
      } else {
        setState(() {
          showSpinner = false;
        });
        _showSnackBar(context, 'ایمیل ارسال نشد');
        print(codeResult.statusCode);
        print(codeResult.body);
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      print('MyError: $e');
    }
  }

  void checkValidation(BuildContext context) {
    if (code.length == 0) {
      _showSnackBar(context, 'لطفا کد تایید را وارد کنید');
      return;
    }
    if (theCode != null) {
      if (theCode == int.parse(this.code)) {
        _showSnackBar(context, 'تایید شد');
        navigateToHomeScreen();
      } else {
        _showSnackBar(context, 'خطا');
      }
    } else {
      _showSnackBar(context, 'کد شما منقضی شده');
    }
  }

  navigateToHomeScreen() async {
    await addStringToSF(token, user_id, username, first_name, phone, last_name,
        image, email, sid);
    Navigator.pop(context);
    Navigator.popAndPushNamed(
      context,
      HomeScreen.id,
      arguments: {
        'sid': sid,
        'user_id': user_id,
        'token': username,
        'email': email,
        'first_name': first_name,
        'last_name': last_name,
        'username': username,
        'phone': phone,
        'image': image,
      },
    );
  }

  _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
