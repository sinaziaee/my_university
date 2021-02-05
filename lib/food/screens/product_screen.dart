import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:my_university/components/product.dart';
import 'package:my_university/components/product_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../kheft/chat_screen.dart';

bool showSpinner = false;
bool isVisible = false;

class ProductPage extends StatefulWidget {
  static String id = 'product_screen';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map args;

  bool isBuyer = true;
  String text = 'درخواست', messageText = "گفت و گو";

  String token, username, seller_username, image, description, buyer_username;
  int stock_id, seller_id, userId, tradeId, buyerId, price, book_id;

  String reportUrl = '$baseUrl/api/bookbse/trades/report';
  String stockUrl = '$baseUrl/api/bookbse/stocks/';
  String demandUrl = '$baseUrl/api/bookbse/demands/';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    username = prefs.getString('username');
    if (seller_id == userId) {
      isBuyer = false;
      text = 'قبول درخواست';
      messageText = "گفت و گو";
    }
    return token;
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    stock_id = args['stock_id'];
    book_id = args['bookId'];
    token = args['token'];
    seller_id = args['seller_id'];
    seller_username = args['seller_username'];
    buyer_username = args['buyer_username'];
    buyerId = args['buyer'];
    print('buyer: $buyerId');
    bool vis = args['isVisible'];
    if (vis != null) {
      isVisible = vis;
    }

    print('***********************');
    print('stock_id: $stock_id');

    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget viewProductButton = InkWell(
      onTap: () {
        _checkAccessibility();
      },
      child: Container(
        height: 60,
        width: width / 2,
        decoration: BoxDecoration(
            gradient: mainButton,
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text(messageText,
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

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

    return Scaffold(
      backgroundColor: Color(0xfffff8ee),

      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            openDialog();
          },
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.campaign),
        ),
      ),

      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: http.get('$stockUrl?stockID=$stock_id',
                  headers: {HttpHeaders.authorizationHeader: this.token}),
              builder: (context, snap) {
                if (snap.hasData &&
                    snap.connectionState == ConnectionState.done) {
                  http.Response response = snap.data;

                  Map result = convert
                      .jsonDecode(convert.utf8.decode(response.bodyBytes));
                  // print(result);
                  image = '$baseUrl/media/${result['image']}';
                  price = result['price'];
                  description = result['description'];
                  print(result);
                  var product_book = Product(
                    '$baseUrl/media/' + result['image'],
                    result['name'].toString(),
                    result['description'].toString(),
                    result['price'],
                    result['publisher'],
                    result['author'],
                  );

                  // return Container();

                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Home2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 100,
                        // left: 50,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfffff8ee),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          requestForBook();
                                        },
                                        color: Colors.teal,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          text,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                      children:[
                                        Container(
                                          margin: EdgeInsets.only(
                                            bottom: 0,
                                          ),
                                          height: MediaQuery.of(context).size.height * 0.32,
                                          width: MediaQuery.of(context).size.width * 0.45,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.3),
                                                      blurRadius: 10,
                                                      offset: Offset(8, 8),
                                                      spreadRadius: 3,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.3),
                                                      blurRadius: 10,
                                                      offset: Offset(-8, -8),
                                                      spreadRadius:2,
                                                    )
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: FadeInImage(
                                                    // width: 150,
                                                    // height: 150,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                    AssetImage('assets/images/book-1.png'),
                                                    image: NetworkImage('$baseUrl/media/${result['image']}'),
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          // "Conjure Women",
                                          result['name'],
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          //"By Afia Atakora",
                                          "  نویسنده: ${result['author']}  ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          " ${replaceFarsiNumber(result['price'].toString())} ریال " , textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.all(24),
                                          height: 8,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                            left: 40,
                                            right: 20,
                                          ),
                                          child: Text(result['description'], textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 20,
                                              letterSpacing: 1.5,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom:
                                      bottomPadding != 20 ? 20 : bottomPadding),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(255, 255, 255, 0),
                                            Color.fromRGBO(255, 255, 255, 0),
                                            Color.fromRGBO(255, 255, 255, 0),
                                          ],
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter)),
                                  width: width,
                                  height: 100,
                                  child: Center(child: viewProductButton),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
        future: getToken(),
      ),
    );
  }

  postReport() async {
    String text = controller.text;
    print(text);
    if (text.trim().length < 1) {
      // pass
    } else {
      http.Response result = await http.post(reportUrl,
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            HttpHeaders.authorizationHeader: token,
          },
          body: convert.jsonEncode({
            "trade": tradeId,
            "accuser": userId,
            "accused": seller_id,
            "text": text,
          }));
      print(result.body);
    }
    Navigator.pop(context);
  }

  acceptRequest() async {
    print('*************************');
    print('bookId: $book_id');
    print('*************************');
    if (buyerId == null) {
      print('buyerId is null');
    }
    String acceptUrl = '${demandUrl}accept/';
    http.Response response = await http.post(
      acceptUrl,
      body: convert.jsonEncode({
        'seller': seller_id,
        'client': buyerId,
        'image': image,
        'price': price,
        'state': false,
        'description': description,
        'book': book_id,
        'bookId': book_id,
        'stock_id': stock_id,
      }),
      headers: {
        HttpHeaders.authorizationHeader: token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode > 400) {
      _showDialog('مشکلی پیش آمد');
    } else {
      success('درخواست کاربر قبول شد.');
    }
    print(jsonResponse);
  }

  requestForBook() async {
    if (isBuyer == false) {
      acceptRequest();
      return;
    }
    print('stock_id: $stock_id');
    print('seller: $seller_id');
    print('client: $userId');
    print('image: $image');
    http.Response response = await http.post(demandUrl,
        headers: {
          HttpHeaders.authorizationHeader: token,
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: convert.jsonEncode({
          'bookId': book_id,
          "book": book_id,
          "seller": seller_id,
          "client": userId,
          'imageUrl': image,
          'price': price,
          'description': description,
          'stock_id': stock_id,
        }));
    print(response.statusCode);
    var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
    print(jsonResponse);
    if (response.statusCode == 400) {
      _showDialog('شما قبلا برای این کتاب درخواست داده اید.');
      return;
    }
    success('درخواست خرید برای فروشنده فرستاده شد');
    // setState(() {
    //   showSpinner = false;
    // });
  }

  _showDialog(String title) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطا',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  success(String title) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'موفقیت',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.green)
      ..show();
  }

  _checkAccessibility() async {
    String chatUrl = '$baseUrl/api/room-list/create';
    var response = await getChatRoom(chatUrl);
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
