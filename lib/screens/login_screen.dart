import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_university/components/already_have_an_account_acheck.dart';
import 'package:my_university/components/rounded_button.dart';
import 'package:my_university/components/rounded_input_field.dart';
import 'package:my_university/components/rounded_password_field.dart';
import 'package:my_university/constants.dart';
import 'package:my_university/screens/home_screen.dart';
import 'package:my_university/screens/registeration_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String myUrl = 'http://danibazi9.pythonanywhere.com/api/users-list/';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = '', student_id = '';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: kPrimaryColor,
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
                        "LOGIN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        "assets/icons/login.svg",
                        height: size.height * 0.35,
                      ),
                      SizedBox(height: size.height * 0.03),
                      RoundedInputField(
                        hintText: "Your Student ID",
                        onChanged: (value) {
                          student_id = value;
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
                        text: "LOGIN",
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
    if (student_id.length == 0) {
      _showDialog(context, 'Fill student ID');
      return;
    }
    if (student_id.length != 8) {
      _showDialog(context, 'Bad student ID format');
      return;
    }
    try {
      int.parse(student_id);
    } catch (e) {
      _showDialog(context, 'Bad student ID format');
      return;
    }
    if (password.length == 0) {
      _showDialog(context, 'Fill password');
      return;
    }
    setState(() {
      showSpinner = true;
    });
    String baseUrl = 'http://danibazi9.pythonanywhere.com/';
    get(baseUrl, context);
  }

  get(String url, BuildContext context) async {
    try {
      // Map data = {
      //   'password': password.trim(),
      //   'student_id': int.parse(student_id.trim()),
      // };
      http.Response result =
          await http.get('$url/api/users-list/${int.parse(student_id)}');
      if (result.statusCode == 201 || result.statusCode == 200) {
        setState(() {
          showSpinner = false;
        });
        Map jsonResponse = convert.jsonDecode(result.body);
        String pass = jsonResponse['password'];
        if (pass == this.password) {
          _showDialog(context, 'success');
          Future.delayed(Duration(milliseconds: 600), () {
            Navigator.popAndPushNamed(context, HomeScreen.id);
          });
        } else {
          _showDialog(context, 'Wrong password');
        }
      } else if (result.statusCode == 404) {
        setState(() {
          showSpinner = false;
        });
        _showDialog(context, 'There is no user with this Student ID');
      } else {
        setState(() {
          showSpinner = false;
        });
        _showDialog(context, result.body);
        print(result.statusCode);
        print(result.body);
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      _showDialog(context, 'There is a problem with the host');
      print("My Error: $e");
    }
  }

  _showDialog(BuildContext context, String message) {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    AlertDialog dialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 20),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Text('Done!'),
          //     ),
          //   ],
          // ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Done!',
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, child: dialog);
  }
}
