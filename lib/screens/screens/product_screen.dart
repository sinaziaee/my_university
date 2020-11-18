import 'dart:io';
import 'dart:convert' as convert;

import 'package:dt_front/components/product.dart';
import 'package:dt_front/components/product_display.dart';
import 'package:dt_front/screens/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'chat_screen.dart';

class ProductPage extends StatefulWidget {
  static String id = 'product_screen';
  int book_id;
  String token;

  //final Product product;

  ProductPage({this.book_id, this.token});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map args;

  String token;
  int book_id, seller_id;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    book_id = args['book_id'];
    token = args['token'];
    seller_id = args['seller_id'];

    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget viewProductButton = InkWell(
      onTap: () {
        _checkAccessibility();
      },
      child: Container(
        height: 80,
        width: width / 1.5,
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
          child: Text("گفت و گو با فروشنده ",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    TextEditingController controller = TextEditingController();

    postRequest() {
      print(controller.text);
      Navigator.pop(context);
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
                color: Colors.purple.shade300,
                onPressed: () {
                  postRequest();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        child: Icon(Icons.camera),
      ),
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
          ' جزئیات کتاب',
          style: const TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: FutureBuilder(
        future: http.get(
            'http://danibazi9.pythonanywhere.com/api/bookbse/stocks?stockID=$book_id',
            headers: {HttpHeaders.authorizationHeader: this.token}),
        builder: (context, snap) {
          if (snap.hasData && snap.connectionState == ConnectionState.done) {
            http.Response response = snap.data;
            Map result =
                convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
            print(result);
            var product_book = Product(
              'http://danibazi9.pythonanywhere.com/media/' + result['image'],
              result['name'].toString(),
              result['description'].toString(),
              result['price'],
              result['publisher'],
              result['author'],
            );

            // return Container();

            return Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.0,
                      ),
                      ProductDisplay(product: product_book),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'نام کتاب',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(product_book.name),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'توضیحات',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(product_book.description),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'نویسنده',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(product_book.author),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: Column(
                          //     children: [
                          //       Padding(
                          //         padding: EdgeInsets.only(right: 10),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: [
                          //             Text(
                          //               'ناشر',
                          //               style: TextStyle(fontSize: 25),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(right: 10),
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: [
                          //             Text(product_book.author),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  // child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       SizedBox(
                  //         height: 80.0,
                  //       ),
                  //       ProductDisplay(product: product_book),
                  //       SizedBox(
                  //         height: 16.0,
                  //       ),
                  //       Padding(
                  //         padding:
                  //             const EdgeInsets.only(left: 20.0, right: 16.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             RichText(
                  //                 textAlign: TextAlign.right,
                  //                 textDirection: TextDirection.rtl,
                  //                 text: TextSpan(
                  //                   text: product_book.name,
                  //                   style: const TextStyle(
                  //                       color: Colors.black,
                  //                       fontWeight: FontWeight.w200,
                  //                       fontFamily: "Montserrat",
                  //                       fontSize: 20.0),
                  //                 )),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 24.0,
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20.0),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: <Widget>[
                  //             Container(
                  //               width: 90,
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                 color: Color(0xFFFFFF),
                  //                 borderRadius: BorderRadius.circular(4.0),
                  //                 border: Border.all(
                  //                     color: Color(0xFFFFFF), width: 0.5),
                  //               ),
                  //               child: Center(
                  //                 child: new Text(
                  //                   "توضیحات",
                  //                   style: const TextStyle(
                  //                       color: Colors.grey,
                  //                       fontWeight: FontWeight.w300,
                  //                       fontStyle: FontStyle.normal,
                  //                       fontFamily: "Montserrat",
                  //                       fontSize: 20),
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 16.0,
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.only(
                  //             left: 20.0, right: 40.0, bottom: 130),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             RichText(
                  //               text: TextSpan(
                  //                 text: product_book.description,
                  //                 style: const TextStyle(
                  //                     color: Colors.black,
                  //                     fontWeight: FontWeight.w200,
                  //                     fontFamily: "NunitoSans",
                  //                     fontStyle: FontStyle.normal,
                  //                     fontSize: 16.0),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: bottomPadding != 20 ? 20 : bottomPadding),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Color.fromRGBO(255, 255, 255, 0),
                          Color.fromRGBO(253, 192, 84, 0.5),
                          Color.fromRGBO(253, 192, 84, 1),
                        ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter)),
                    width: width,
                    height: 120,
                    child: Center(child: viewProductButton),
                  ),
                ),
              ],
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

  _checkAccessibility() async {
    String chatUrl = '$baseUrl/api/room-list/create';
    print('*********************************');
    print(seller_id);
    print(token);
    http.Response response = await http.post(
      chatUrl,
      headers: {
        HttpHeaders.authorizationHeader: token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.jsonEncode({
        'user_id': seller_id,
      }),
    );
    print(response.body);
    // print('seller_id:' + seller_id.toString());
    // print('token:' + token);
    // print(response.statusCode);
    // Map jsonResponse = convert.jsonDecode(response.body);
    // print(jsonResponse);
    Navigator.pushNamed(context, ChatScreen.id, arguments: {
      'room': 1,
      'first_name': 'sina',
      'last_name': 'ziaee',
    });
  }
}
