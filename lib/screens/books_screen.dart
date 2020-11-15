import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_university/components/book_item.dart';
import 'package:my_university/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:my_university/screens/filter_screen.dart';

String url = 'https://jsonplaceholder.typicode.com/todos';

class BooksScreen extends StatefulWidget {
  static String id = 'books_screen';

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(child: SafeArea(
      //   child: Container(
      //     child: Stack(
      //       children: <Widget>[
      //         Positioned(
      //           top: 10,
      //           right: 15,
      //           left: 15,
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 color: Colors.grey[200],
      //                 borderRadius: BorderRadius.circular(20)),
      //             child: Row(
      //               children: <Widget>[
      //                 Expanded(
      //                   child: TextField(
      //                     onChanged: (val){
      //                       print(val.trim());
      //                     },
      //                     controller: controller,
      //                     cursorColor: Colors.black,
      //                     keyboardType: TextInputType.text,
      //                     textInputAction: TextInputAction.search,
      //                     textDirection: TextDirection.rtl,
      //                     decoration: InputDecoration(
      //                         border: InputBorder.none,
      //                         contentPadding:
      //                         EdgeInsets.symmetric(horizontal: 15),
      //                         hintText: "Search..."),
      //                   ),
      //                 ),
      //                 Material(
      //                   type: MaterialType.transparency,
      //                   shape: CircleBorder(),
      //                   child: IconButton(
      //                     splashColor: Colors.grey,
      //                     icon: Icon(
      //                       FontAwesomeIcons.filter,
      //                       color: kProgressIndicator,
      //                       size: 20,
      //                     ),
      //                     onPressed: () {
      //                       Scaffold.of(context).openDrawer();
      //                     },
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ), preferredSize: Size.fromHeight(80)),
      appBar: FloatAppBar(controller: controller,),
      body: RefreshIndicator(
        onRefresh: () {
          return _refresh();
        },
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: FutureBuilder(
              future: http.get(url),
              builder: (context, snapshot) {
                // return ListView.builder(
                //   itemCount: 10,
                //   itemBuilder: (context, index) {
                //     // return Container(child: Text('$index: ${mapList[index]['title']}'), color: Colors.red, margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),);
                //     return MyBookItem('url','title', 'description', 'category','2000', onPressed());
                //   },
                // );
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      http.Response response = snapshot.data;
                      // print(response.body);
                      // List<Map> jsonResponse = convert.jsonDecode(response.body);
                      var jsonResponse = convert.jsonDecode(response.body);
                      List<Map> mapList = [];
                      for(Map map in jsonResponse){
                        mapList.add(map);
                      }
                      int count = response.body.length;
                      print(count);
                      return ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) {
                          return Container(child: Text('$index: ${mapList[index]['title']}'), color: Colors.red, margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),);
                        },
                      );
                      return Image.asset('assets/images/book-1.png');
                    } else {
                      // show nothing
                      return SizedBox();
                    }
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/not_found.png', height: 200),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Not found'),
                        ],
                      ),
                    );
                  }
                } else {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          padding: EdgeInsets.only(top: 15),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(38.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: Color(0xFFD3D3D3).withOpacity(.84),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(38.5),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }

  onPressed() {
    print('hhhhhhh');
  }

  Future<bool> _refresh() async {
    print('hello');
    return true;
  }

  _getList() {}

  onChanged(String value){
    // setState(() {
      url = '$url?userId=$value';
    // });
    print(url);
  }

}

class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
  final TextEditingController controller;
  final Function onChanged;
  FloatAppBar({this.controller, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (val){
                          onChanged(controller.text);
                        },
                        controller: controller,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Search..."),
                      ),
                    ),
                    Material(
                      type: MaterialType.transparency,
                      shape: CircleBorder(),
                      child: IconButton(
                        splashColor: Colors.grey,
                        icon: Icon(
                          FontAwesomeIcons.filter,
                          color: kPrimaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          onPressed(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressed(BuildContext context){
    Navigator.pushNamed(context, FilterScreen.id);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
