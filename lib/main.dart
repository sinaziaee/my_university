import 'package:flutter/material.dart';
import 'package:my_university/Professor/faculty_screen.dart';
import 'package:my_university/event/Screens/events_screen.dart';
import 'package:my_university/food/index.dart';
import 'package:my_university/food/screens/not_today_food_detail_screen.dart';
import 'package:my_university/food/screens/bucket_screen.dart';
import 'package:my_university/food/screens/time_screen.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/kheft/filter_screen.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/kheft/new_book_screen.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/food/screens/product_screen.dart';
import 'package:my_university/screens/settings_screen.dart';
import 'file:///D:/FlutterProjects/seyyed/my_university/lib/kheft/trade_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'Professor/Professor_screen.dart';
import 'Professor/professor_detail_screen.dart';
import 'constants.dart';
import 'event/Screens/event_details_screen.dart';
import 'food/screens/today_food_details.dart';
import 'kheft/books_screen.dart';
import 'kheft/chat_rooms_screen.dart';
import 'kheft/chat_screen.dart';
import 'kheft/demand_books.dart';
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
        textTheme: PersianFonts.shabnamTextTheme,
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
        NewBookScreen.id: (context) => NewBookScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ChatRoomsScreen.id: (context) => ChatRoomsScreen(),
        DemandBookScreen.id: (context) => DemandBookScreen(),
        TradeScreen.id: (context) => TradeScreen(),
        TimeScreen.id : (context) => TimeScreen(),
        Index.id : (context) => Index(),
        TodayFoodDetails.id : (context) => TodayFoodDetails(),
        AllFoodDetails.id : (context) => AllFoodDetails(),
        Bucket.id : (context) => Bucket(),
        EventDetailsScreen.id: (context) => EventDetailsScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        AllEventsScreen.id: (context) => AllEventsScreen(),
        FacultyScreen.id : (context) => FacultyScreen(),
        DetailPageProfessor.id : (context) => DetailPageProfessor(),
        ProfessorList.id : (context) => ProfessorList(),
      },
    );
  }
}

