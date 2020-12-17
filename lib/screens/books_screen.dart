import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:my_university/components/book_item.dart';
import 'package:my_university/screens/filter_screen.dart';
import 'package:my_university/screens/history_screen.dart';
import 'package:my_university/screens/new_book.dart';
import 'package:my_university/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../constants.dart';
import 'demand_books.dart';

String stockUrl = '$baseUrl/api/bookbse/stocks/';
String url;

class BooksScreen extends StatefulWidget {
  static String id = 'books_screen';

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  TextEditingController controller = new TextEditingController();
  Map args;

  String token, search, faculty;
  int userId, min , max;

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    url = stockUrl;
  }

  @override
  Widget build(BuildContext context) {
    _navigateToFilterScreen(BuildContext context) async {
      var result = await Navigator.pushNamed(context, FilterScreen.id, arguments: {
        'search': this.search,
        'min': this.min,
        'max': this.max,
        'faculty': this.faculty,
      });
      Map map = LinkedHashMap.from(result);

      String search = map['search'];
      int min = map['min'];
      int max = map['max'];
      String faculty = map['faculty'];

      if (search != null){
        this.search = search;
        controller.text = search;
      }
      if (min != null){
        this.min = min;
      }
      if (max != null){
        this.max = max;
      }
      if (faculty != null){
        this.faculty = faculty;
      }

      onChanged();

    }

    _navigateToNewScreen(BuildContext context) async {
      var result = await Navigator.pushNamed(context, NewBook.id, arguments: {
        'token': token,
        'user_id': userId,
      });
      setState(() {

      });
    }

    return Builder(
      builder: (context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _navigateToNewScreen(context);
            },
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.history,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, HistoryScreen.id, arguments: {
                      'token': token,
                    });
                  },
                  label: Text(
                    'کتاب های من',
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Spacer(),
                TextButton.icon(
                  icon: Icon(
                    Icons.clear_all,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    _navigateToDemandScreen();
                  },
                  label: Text(
                    'درخواست ها',
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: PreferredSize(
              child: SafeArea(
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
                                  onChanged: (val) {
                                    search = val;
                                    onChanged();
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
                                    // Scaffold.of(context).openDrawer();
                                    _navigateToFilterScreen(context);
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
              ),
              preferredSize: Size.fromHeight(80)),
          body: RefreshIndicator(
            onRefresh: () {
              return _refresh();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: FutureBuilder(
                  future: getToken(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return FutureBuilder(
                          future: http.get(url, headers: {
                            HttpHeaders.authorizationHeader: token
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  http.Response response = snapshot.data;
                                  // print(response.statusCode);
                                  // print(utf8.decode(response.bodyBytes));
                                  // List<Map> jsonResponse = convert.jsonDecode(response.body);
                                  var jsonResponse = convert.jsonDecode(
                                      utf8.decode(response.bodyBytes));
                                  List<Map> mapList = [];
                                  // print(jsonResponse);
                                  // if (jsonResponse['detail'] != null) {
                                  //   return Center(
                                  //     child: Text('Wrong token is sent'),
                                  //   );
                                  // }
                                  int count = 0;
                                  if (response.body.isEmpty) {
                                    return SizedBox();
                                  }
                                  // print(jsonResponse);
                                  for (Map map in jsonResponse) {
                                    count++;
                                    mapList.add(map);
                                    // print(map.toString());
                                  }
                                  if (count == 0) {
                                    return Container(
                                      child: Center(
                                        child:
                                            Text('کتابی برای فروش موجود نیست'),
                                      ),
                                    );
                                  }
                                  // print(count);
                                  // return SizedBox();
                                  return ListView.builder(
                                    itemCount: count,
                                    itemBuilder: (context, index) {
                                      return BookItem(
                                        onPressed: () {
                                          onPressed(
                                            mapList[index]['id'],
                                            token,
                                            mapList[index]['seller'],
                                            mapList[index]['seller_username'],
                                            mapList[index]['book_id'],
                                          );
                                        },
                                        url: (mapList[index]['image'] != null)
                                            ? '$baseUrl/media/${mapList[index]['image']}'
                                            : '',
                                        cost:
                                            mapList[index]['price'].toString(),
                                        name: mapList[index]['name'].toString(),
                                        author:
                                            mapList[index]['author'].toString(),
                                        timeStamp: mapList[index]['upload']
                                            .toString()
                                            .substring(10, 16),
                                        publisher: mapList[index]['faculty']
                                            .toString(),
                                        faculty: mapList[index]['faculty']
                                            .toString(),
                                      );
                                    },
                                  );
                                  // return Image.asset('assets/images/book-1.png');
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
                                      Image.asset('assets/images/not_found.png',
                                          height: 200),
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
                                        borderRadius:
                                            BorderRadius.circular(38.5),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 33,
                                            color: Color(0xFFD3D3D3)
                                                .withOpacity(.84),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(38.5),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        );
      },
    );
  }

  onPressed(int id, String token, int seller_id, String username, int book_id) {
    print('book:::::: $book_id');
    Navigator.pushNamed(context, ProductPage.id, arguments: {
      'stock_id': id,
      'token': token,
      'seller_id': seller_id,
      'seller_username': username,
      'book_id': book_id,
      'bookId': book_id,
    });
  }

  Future<bool> _refresh() async {
    onChanged();
    return true;
  }

  onChanged() {
    if(min == null && search == null && faculty == null){
      print(1);
      url = '$stockUrl';
    }
    else if(min != null && search != null && faculty == null){
      print(2);
      url = '$stockUrl?search=$search&min=$min&max=$max';
    }
    else if(min != null && search == null && faculty != null){
      print(3);
      url = '$stockUrl?min=$min&max=$max&faculty=$faculty';
    }
    else if(min == null && search != null && faculty != null){
      print(4);
      url = '$stockUrl?search=$search&faculty=$faculty';
    }
    else if(min != null && search == null && faculty == null){
      print(5);
      url = '$stockUrl?min=$min&max=$max';
    }
    else if(min == null && search == null && faculty != null){
      print(6);
      url = '$stockUrl?faculty=$faculty';
    }
    else if(min == null && search != null && faculty == null){
      print(7);
      url = '$stockUrl?search=$search';
    }
    else{
      print(8);
      url = '$stockUrl?search=$search&min=$min&max=$max&faculty=$faculty';
    }
    setState(() {

    });
    print('**********************');
    print(url);
    print('***********************');
  }

  void _navigateToDemandScreen() {
    Navigator.pushNamed(context, DemandBookScreen.id);
  }
}
