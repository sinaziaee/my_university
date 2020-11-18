import 'package:dt_front/components/rounded_button.dart';
import 'package:dt_front/components/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
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
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    // _showSnackBar(context, 'A verification code is sent to your email');
    sid = arguments['sid'];
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
                        "WELCOME TO MY University",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.05),
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        height: size.height * 0.45,
                      ),
                      SizedBox(height: size.height * 0.05),
                      RoundedInputField(
                        hintText: "Enter Verification Code",
                        onChanged: (value) {
                          code = value;
                        },
                      ),
                      RoundedButton(
                        text: "Check",
                        color: kPrimaryColor,
                        press: () {
                          checkValidation(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Didn\'t get an email ? '),
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
                              'Resend',
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
                                    ' seconds remaining')
                                : Text('Your Code is expired'),
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
        _showSnackBar(context,
            'A verification code is will be sent to your email in at most 30 seconds');
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
        _showSnackBar(context, 'failed to send email');
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
      _showSnackBar(context, 'Please enter the verification code');
      return;
    }
    if (theCode != null) {
      if (theCode == int.parse(this.code)) {
        _showSnackBar(context, 'Success');
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.popAndPushNamed(context, HomeScreen.id);
        });
      } else {
        _showSnackBar(context, 'Error');
      }
    } else {
      _showSnackBar(context, 'Your Code is Expired');
    }
  }

  _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
