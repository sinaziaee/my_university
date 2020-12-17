import 'package:my_university/food/index.dart';
import 'package:my_university/food/screens/AllFoodDetails.dart';
import 'package:my_university/food/screens/bucket_screen.dart';
import 'package:my_university/food/screens/time_screen.dart';
import 'package:my_university/screens/chat_rooms_screen.dart';
import 'package:my_university/screens/chat_screen.dart';
import 'package:my_university/screens/demand_books.dart';
import 'package:my_university/screens/filter_screen.dart';
import 'package:my_university/screens/new_book.dart';
import 'package:my_university/screens/product_screen.dart';
import 'package:my_university/screens/trade_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'event/Screens/NewEvent.dart';
import 'food/screens/Today_food_details.dart';
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
        NewEvent.id : (context) => NewEvent(),
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
        TimeScreen.id : (context) => TimeScreen(),
        Index.id : (context) => Index(),
        TodayFoodDetails.id : (context) => TodayFoodDetails(),
        AllFoodDetails.id : (context) => AllFoodDetails(),
        Bucket.id : (context) => Bucket(),
      },
    );
  }
}

