import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_university/food/screens/bucket_screen.dart';
import 'package:my_university/food/screens/delivery_tab.dart';
import 'package:my_university/food/screens/food_history_screen.dart';
import 'package:my_university/food/screens/menu_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';

import '../constants.dart';


class Index extends StatefulWidget {
  static String id = 'Index';

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;
  onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _viewList = [
    Home(),
    // Search(),
    Bucket(),
    History(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _viewList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: onTappedItem,
        selectedIndex: _selectedIndex,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('منو' , style: PersianFonts.Shabnam,),
            activeColor: kRedColor,
            inactiveColor: kBlackColor,
          ),
          // BottomNavyBarItem(
          //   icon: Icon(Icons.search),
          //   title: Text('Searcg'),
          //   activeColor: kOrangeColor,
          //   inactiveColor: kBlackColor,
          // ),
          BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('سبد خرید', style: PersianFonts.Shabnam,),
            activeColor: kRedColor,
            inactiveColor: kBlackColor,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text('سفارشات من' , style: PersianFonts.Shabnam,),
            activeColor: kRedColor,
            inactiveColor: kBlackColor,
          ),
        ],
      ),
    );
  }
}
