import 'package:flutter/material.dart';
import 'package:my_university/screens/books_screen.dart';
import 'package:my_university/screens/email_verfication_screen.dart';
import 'package:my_university/screens/filter_screen.dart';
import 'package:my_university/screens/home_screen.dart';
import 'package:my_university/screens/login_screen.dart';
import 'package:my_university/screens/product_page.dart';
import 'package:my_university/screens/registeration_screen.dart';
import 'package:my_university/screens/welcome_screen.dart';
import 'package:my_university/components/report_Problem_Dialogue.dart';

import 'constants.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        accentColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        report_problem.id : (context) => report_problem(),
        RegisterationScreen.id: (context) => RegisterationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        EmailVerificationScreen.id: (context) => EmailVerificationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        BooksScreen.id: (context) => BooksScreen(),
        ProductPage.id:(context) => ProductPage(),
      },
    );
  }
}

