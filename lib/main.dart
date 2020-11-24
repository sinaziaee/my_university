import 'package:dt_front/screens/chat_rooms_screen.dart';
import 'package:dt_front/screens/chat_screen.dart';
import 'package:dt_front/screens/demand_books.dart';
import 'package:dt_front/screens/filter_screen.dart';
import 'package:dt_front/screens/new_book.dart';
import 'package:dt_front/screens/product_screen.dart';
import 'package:dt_front/screens/trade_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/books_screen.dart';
import 'screens/email_verfication_screen.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registeration_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';

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
      initialRoute: LoginScreen.id,
      routes: {
        ProductPage.id: (context) => ProductPage(),
        RegisterationScreen.id: (context) => RegisterationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        EmailVerificationScreen.id: (context) => EmailVerificationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        BooksScreen.id: (context) => BooksScreen(),
        HistoryScreen.id: (context) => HistoryScreen(),
        FilterScreen.id: (context) => FilterScreen(),
        NewBook.id: (context) => NewBook(),
        ChatScreen.id: (context) => ChatScreen(),
        ChatRoomsScreen.id: (context) => ChatRoomsScreen(),
        DemandBookScreen.id: (context) => DemandBookScreen(),
        TradeScreen.id: (context) => TradeScreen(),
      },
    );
  }
}

