import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
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
      backgroundColor:Color(0xfffff8ee) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.campaign),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: Colors.teal,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(color: darkGrey),
      //   // leading: IconButton(
      //   //   onPressed: () {
      //   //     cancelDialog();
      //   //   },
      //   //   icon: Icon(
      //   //     Icons.cancel,
      //   //     color: Colors.white,
      //   //   ),
      //   // ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.chevron_right,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ],
      //   title: Text(
      //     ' جزئیات کتاب',
      //     style: const TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30.0),
      //   ),
      // ),
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
                  print('------------------------------------------------------------------------------------');
                  print(response.statusCode);
                  print(response.body);
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
                  if (seller_id == userId) {
                    otherId = buyer_id;
                  } else {
                    otherId = seller_id;
                  }
                  seller_username = result['seller_username'];
                  buyer_username = result['client_username'];
                  print(result);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Center(
                            child: Banner(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.purple.shade300,
                              message: replaceFarsiNumber(result['price'].toString()) ,
                              location: BannerLocation.bottomEnd,
                              child: Container(

                                child: FadeInImage(
                                  height: 180,
                                  width: 150,
                                  fit: BoxFit.cover,
                                    image: (result['image'] != null)
                                        ? NetworkImage(result['image'])
                                        : AssetImage('assets/images/book-1.png'),
                                    placeholder: AssetImage('assets/images/book-1.png')
                                ),
                              ),
                            ),
                          ),
                          height: 250,
                          decoration: BoxDecoration(
                          image: DecorationImage(
                          image: AssetImage("assets/images/Home2.png"),
                          fit: BoxFit.cover),
                            // color: Colors.orange.shade500,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                  // "Conjure Women",
                                  result['name'],
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
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
                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text(
                          //       result['name'],
                          //       textDirection: TextDirection.rtl,
                          //       textAlign: TextAlign.right,
                          //     ),
                          //   ],
                          // ),
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
                              // Expanded(
                              //   child: Text(
                              //     'نویسنده : ',
                              //     style: TextStyle(
                              //         color: Colors.black, fontSize: 22),
                              //     textDirection: TextDirection.rtl,
                              //     textAlign: TextAlign.right,
                              //   ),
                              // ),
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
                                // "Conjure Women",
                                result['author'],
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                'نویسنده : ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
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
                              // Text(
                              //   'دانشکده : ',
                              //   style: TextStyle(
                              //       color: Colors.black, fontSize: 22),
                              //   textDirection: TextDirection.rtl,
                              //   textAlign: TextAlign.right,
                              // ),
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
                                style: TextStyle(fontSize: 25,
                                  fontWeight: FontWeight.w700,),
                              ),
                              Text(
                                'دانشکده : ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
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
                              // Text(
                              //   'توضیحات',
                              //   style: TextStyle(
                              //       color: Colors.black, fontSize: 18),
                              //   textDirection: TextDirection.rtl,
                              //   textAlign: TextAlign.right,
                              // ),
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
                                style: TextStyle(fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'توضیحات : ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
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
                            height: 60,
                            width: 180,
                            decoration: BoxDecoration(
                                gradient: mainButton,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color.fromRGBO(253, 192, 84, 1),
                                //     offset: Offset(0, 5),
                                //     blurRadius: 10.0,
                                //   )
                                // ],
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
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطا',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)..show();
  }

  success(String title) async{
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'موفقیت',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.green)..show();
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
    var jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(jsonResponse);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success('کتاب به $seller_username نسبت داده شد .');
    } else {
      _showDialog('مشکلی پیش آمد');
    }
  }

  postReport() async {
    String text = controller.text;
    print(text);
    if (text.trim().length < 1) {
      // pass
      _showDialog('لطفا شکایت خود را وارد کنید ');
    } else {
      http.Response result = await http.post('$reportUrl/?tradeID=$tradeId',
          headers: {
            HttpHeaders.authorizationHeader: token,
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: convert.jsonEncode({
            "trade": tradeId,
            "accuser": userId,
            "accused": otherId,
            "text": text,
          }));
      print(result.statusCode);
      if (result.statusCode >= 400) {
        // Navigator.pop(context);
        _showDialog('مشکلی پیش آمد.');
      } else {
        // Navigator.pop(context);
        success('شکایت شما با موفقیت ثبت شد.');
      }
      print(result.body);
    }
  }

  cancelDialog() async {
    var result = await showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          'آیا مطمین از لغو رزرو هستید ؟',
          textDirection: TextDirection.rtl,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'آره',
                style: TextStyle(color: Colors.green),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'نه',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
    if (result == true) {}
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
          "Accept": "application/json",
          "content-type": "application/json",
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
          "Accept": "application/json",
          "content-type": "application/json",
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
