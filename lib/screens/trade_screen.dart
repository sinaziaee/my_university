import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../constants.dart';
import 'chat_screen.dart';

class TradeScreen extends StatefulWidget {
  static String id = 'trade_screen';

  @override
  _TradeScreenState createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  bool isVisible;
  String reportUrl = '$baseUrl/api/bookbse/trades/report';
  TextEditingController controller = TextEditingController();
  Map args;
  String token,
      username,
      text,
      messageText = 'گفت و گو',
      seller_username,
      buyer_username;
  int userId, seller_id, tradeId, buyer_id, otherId, price, seller, buyer;
  bool isBuyer = true;
  String url = '$baseUrl/api/bookbse/trades';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    username = prefs.getString('username');
    if (seller_id == userId) {
      isBuyer = false;
      text = 'خرید تمام شد';
    }
    return token;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    tradeId = args['trade_id'];
    isVisible = args['isVisible'];
    // seller_id = args['seller_id'];
    // seller_username = args['seller_username'];
    // buyer_username = args['buyer_username'];
    // buyer_id = args['buyer_id'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.campaign),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.orange.shade500,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          ' جزئیات کتاب',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: http.get('${url}/?tradeID=$tradeId',
                  headers: {HttpHeaders.authorizationHeader: token}),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  http.Response response = snapshot.data;

                  Map result = convert
                      .jsonDecode(convert.utf8.decode(response.bodyBytes));
                  // if (isVisible == null && result['seller_username'] == username){
                  //   // setState(() {
                  //     isVisible = true;
                  //   // });
                  // }
                  price = result['price'];
                  seller_id = result['seller'];
                  buyer_id = result['buyer'];
                  seller_username = result['seller_username'];
                  buyer_username = result['client_username'];
                  print(result);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Center(
                            child: Banner(
                              color: Colors.purple.shade300,
                              message: result['price'].toString(),
                              location: BannerLocation.bottomEnd,
                              child: FadeInImage(
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                                placeholder:
                                    AssetImage('assets/images/book-1.png'),
                                image: NetworkImage(
                                  result['image'],
                                ),
                              ),
                            ),
                          ),
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade500,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'نام کتاب',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                result['name'],
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: isVisible ?? false,
                                child: FlatButton(
                                  onPressed: () {
                                    saveAsTrade();
                                  },
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    '  خرید تمام شد ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.purple.shade400,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'نام نویسنده',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                result['author'],
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'دانشکده',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                result['faculty'],
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'توضیحات',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                result['description'],
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () {
                            _checkAccessibility();
                          },
                          child: Container(
                            height: 80,
                            width: 200,
                            decoration: BoxDecoration(
                                gradient: mainButton,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(253, 192, 84, 1),
                                    offset: Offset(0, 5),
                                    blurRadius: 10.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(9.0)),
                            child: Center(
                              child: Text('گفت و گو',
                                  style: const TextStyle(
                                      color: const Color(0xfffefefe),
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 20.0)),
                            ),
                          ),
                        )
                      ],
                    ),
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

  _showDialog(String title) async{
    var result = await showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          title,
          textDirection: TextDirection.rtl,
        ),
        content: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'باشه !',
            style: TextStyle(color: kPrimaryColor),
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
    Navigator.pop(context, true);
  }

  saveAsTrade() async {
    http.Response response = await http.put(
      '${url}/?tradeID=$tradeId',
      headers: {
        HttpHeaders.authorizationHeader: token,
        "content-type": "application/json",
      },
      body: convert.jsonEncode({
        'state': true,
        'price': price,
        'seller': seller_id,
        'buyer': buyer_id,
      }),
    );
    var jsonResponse = convert.jsonDecode(
        convert.utf8.decode(response.bodyBytes));
    print(jsonResponse);
    if(response.statusCode == 200){
      _showDialog('کتاب به $seller_username نسبت داده شد .');
    }
  }

  postReport() async {
    String text = controller.text;
    print(text);
    if (text.trim().length < 1) {
      // pass
    } else {
      http.Response result = await http.post(reportUrl,
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
          body: convert.jsonEncode({
            "trade": tradeId,
            "accuser": userId,
            "accused": otherId,
            "text": text,
          }));
      print(result.body);
    }
    Navigator.pop(context);
  }

  _checkAccessibility() async {
    String chatUrl = '$baseUrl/api/room-list/create';
    var response = await getChatRoom(chatUrl);
    print(convert.jsonDecode(response.body));
    int room_id = convert.jsonDecode(response.body)['room_id'];
    if (username == seller_username) {
      Navigator.pushNamed(context, ChatScreen.id, arguments: {
        'room': room_id,
        'user_id': userId,
        'username': username,
        'other_username': buyer_username,
      });
    } else {
      Navigator.pushNamed(context, ChatScreen.id, arguments: {
        'room': room_id,
        'user_id': userId,
        'username': username,
        'other_username': seller_username,
      });
    }
  }

  Future<http.Response> getChatRoom(String chatUrl) {
    if (username == seller_username) {
      return http.post(
        chatUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(<String, int>{
          'user_id': buyer_id,
        }),
      );
    } else {
      return http.post(
        chatUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(<String, int>{
          'user_id': seller_id,
        }),
      );
    }
  }

  openDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('متن شکایت خود را وارد کنید'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: controller,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.deepOrange,
              onPressed: () {
                postReport();
              },
              child: Text(
                'ثبت شکایت',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
