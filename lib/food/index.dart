import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_university/food/screens/bucket_screen.dart';
import 'package:my_university/food/screens/food_history_screen.dart';
import 'package:my_university/food/screens/menu_screen.dart';

import '../constants.dart';


class Index extends StatefulWidget {
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
            title: Text('Menu'),
            activeColor: kOrangeColor,
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
            title: Text('bucket'),
            activeColor: kOrangeColor,
            inactiveColor: kBlackColor,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text('orders'),
            activeColor: kOrangeColor,
            inactiveColor: kBlackColor,
          ),
        ],
      ),
    );
  }
}
