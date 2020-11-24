import 'dart:io';

import 'package:dt_front/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../constants.dart';
import 'package:dt_front/components/history_book_item.dart';

class DemandBookScreen extends StatefulWidget {
  static String id = 'demand_screen';

  @override
  _DemandBookScreenState createState() => _DemandBookScreenState();
}

class _DemandBookScreenState extends State<DemandBookScreen> {
  String token, username;
  int userId, count = 0;
  String url = '$baseUrl/api/bookbse/demands/?state=all';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    username = prefs.getString('username');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'درخواست ها',
          style: const TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: http.get(
                url,
                headers: {HttpHeaders.authorizationHeader: token},
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  http.Response response = snapshot.data;
                  var jsonResponse = convert
                      .jsonDecode(convert.utf8.decode(response.bodyBytes));
                  List<Map> mapList = [];
                  print(jsonResponse);

                  count = 0;
                  for (Map each in jsonResponse) {
                    mapList.add(each);
                    count++;
                  }
                  if (count == 0) {
                    return Center(
                      child: Text(
                        'هیچ درخواستی وجود ندارد',
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  }
                  print(
                    'url: ${mapList[0]['image']}',
                  );
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MyBookItem(
                        name: mapList[index]['name'],
                        author: mapList[index]['author'],
                        url: mapList[index]['imageUrl'],
                        seller: mapList[index]['seller'],
                        buyer: mapList[index]['client'],
                        user: userId,
                        otherUser: (mapList[index]['seller_username'] ==
                                username)
                            ? 'خریدار : ${mapList[index]['client_username']}'
                            : 'فروشنده : ${mapList[index]['seller_username']}',
                        onPressed: () {
                          onPressed(
                            mapList[index]['id'],
                            token,
                            mapList[index]['seller'],
                            mapList[index]['seller_username'],
                            mapList[index]['client'],
                            mapList[index]['stock_id'],
                            mapList[index]['buyer_username'],
                          );
                        },
                      );
                    },
                    itemCount: count,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  onPressed(
      int id, String token, int seller, String seller_username, int buyer, int stock_id, String buyer_username) {
    Navigator.pushNamed(context, ProductPage.id, arguments: {
      'book_id': id,
      'token': token,
      'seller_id': seller,
      'seller_username': seller_username,
      'buyer': buyer,
      'buyer': buyer_username,
      'stock_id': stock_id,
    });
  }
}
