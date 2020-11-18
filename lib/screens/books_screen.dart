import 'dart:convert';
import 'dart:io';

import 'package:dt_front/components/book_item.dart';
import 'package:dt_front/screens/filter_screen.dart';
import 'package:dt_front/screens/history_screen.dart';
import 'package:dt_front/screens/new_book.dart';
import 'package:dt_front/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constants.dart';

String url =
    '$baseUrl/api/bookbse/stocks/?state=all';

class BooksScreen extends StatefulWidget {
  static String id = 'books_screen';

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  TextEditingController controller = new TextEditingController();
  Map args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    int userId = args['user_id'];
    String token = args['token'];
    print(token);
    //TODO
    token = 'Token 84ad40dff810e6063d18ae6c1bd1a9ac4364d4bc';
    _navigateToFilterScreen(BuildContext context) async {
      var result = await Navigator.pushNamed(context, FilterScreen.id);
      print(result);
    }

    _navigateToNewScreen(BuildContext context) async {
      var result = await Navigator.pushNamed(context, NewBook.id, arguments: {
        'token': token,
        'user_id': userId,
      });
      print(result);
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
                  icon: Icon(Icons.history, color: kPrimaryColor,),
                  onPressed: () {
                    Navigator.pushNamed(context, HistoryScreen.id, arguments: {
                      'token': token,
                    });
                  },
                  label: Text('کتاب های من', style: TextStyle(color: kPrimaryColor,),),
                ),
                Spacer(),
                TextButton.icon(
                  icon: Icon(Icons.clear_all, color: kPrimaryColor,),
                  onPressed: () {
                    _navigateToFilterScreen(context);
                  },
                  label: Text('فیلتر', style: TextStyle(color: kPrimaryColor,),),
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
                                    onChanged(val);
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
                  future: http.get(url,
                      headers: {HttpHeaders.authorizationHeader: token}),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          http.Response response = snapshot.data;
                          // print(response.statusCode);
                          // print(utf8.decode(response.bodyBytes));
                          // List<Map> jsonResponse = convert.jsonDecode(response.body);
                          var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
                          List<Map> mapList = [];
                          // print(jsonResponse);
                          // if (jsonResponse['detail'] != null) {
                          //   return Center(
                          //     child: Text('Wrong token is sent'),
                          //   );
                          // }
                          int count = 0;
                          for (Map map in jsonResponse) {
                            count++;
                            mapList.add(map);
                            // print(map.toString());
                          }
                          if (count == 0) {
                            return Container(
                              child: Center(
                                child: Text('کتابی برای فروش موجود نیست'),
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
                                  onPressed(mapList[index]['id'], token,
                                      mapList[index]['seller']);
                                },
                                url:(mapList[index]['image'] != null)?
                                    '$baseUrl/media/${mapList[index]['image']}' : '',
                                cost: mapList[index]['price'].toString(),
                                name: mapList[index]['name'].toString(),
                                author: mapList[index]['author'].toString(),
                                timeStamp: mapList[index]['upload']
                                    .toString()
                                    .substring(10, 16),
                                publisher: mapList[index]['faculty'].toString(),
                                faculty: mapList[index]['faculty'].toString(),
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
      },
    );
  }

  onPressed(int id, String token, int seller_id) {
    Navigator.pushNamed(context, ProductPage.id, arguments: {
      'book_id': id,
      'token': token,
      'seller_id': seller_id,
    });
  }

  Future<bool> _refresh() async {
    print('hello');
    return true;
  }

  _getList() {}

  onChanged(String value) {
    // setState(() {
    url = '$url?userId=$value';
    // });
    print(url);
  }
}
