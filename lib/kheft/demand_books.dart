import 'dart:io';

import 'package:my_university/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../constants.dart';
import 'package:my_university/components/history_book_item.dart';

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
      backgroundColor: Color(0xfffff8ee),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: Color(0xfffff8ee),
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: darkGrey),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.chevron_right),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ],
      //   title: Text(
      //     'درخواست ها',
      //     style: const TextStyle(
      //         color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
      //   ),
      // ),
      body: Container(
        child: FutureBuilder(
          future: getToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Home2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:Color(0xfffff8ee),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/books.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.9 ,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xfffff8ee),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 25 , horizontal: 20),
                                child: FutureBuilder(
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
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(100,100,100,20),
                                              child: Image(
                                                  image: AssetImage("assets/images/nodemand.png")
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                'هیچ درخواستی وجود ندارد',
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      print(
                                        'url: ${mapList[0]['image']}',
                                      );
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          print('***************************');
                                          print(mapList[index]);
                                          print('***************************');
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
                                                mapList[index]['bookId'],
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  onPressed(
      int id, String token, int seller, String seller_username, int buyer, int stock_id, String buyer_username) async{
    print('***************************');
    print('id is: $id');
    print('stockId is: $stock_id');
    print('***************************');
    var result = await Navigator.pushNamed(context, ProductPage.id, arguments: {
      'book_id': id,
      'bookId': id,
      'token': token,
      'seller_id': seller,
      'seller_username': seller_username,
      'buyer': buyer,
      'buyer_username': buyer_username,
      'stock_id': stock_id,
    });
    if (result == true){
      Navigator.pop(context);
    }
  }
}
