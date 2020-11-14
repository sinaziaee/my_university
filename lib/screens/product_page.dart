
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_university/components/product.dart';
import 'package:my_university/screens/product_display.dart';
import '../app_properties.dart';
import 'package:http/http.dart' as http;


get_book(int stockId, String token) async{

  print('hell111111');

// http.get('http://danibazi9.pythonanywhere.com/api/bookbse/stocks?stockID=$stockId');
  http.Response result = await http.get('http://danibazi9.pythonanywhere.com/api/bookbse/stocks?stockID=1', headers: {
    HttpHeaders.authorizationHeader: 'Token 4132b2c84b33da1e99704dc7c3f7f0f879ab67d4'
  });

  print(result.statusCode);

  print('hell2222222');
  print(result.body);

}





List<Product> products = [
  Product(
      'assets/headphones_2.png',
      'Skullcandy headset L325',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      102.99),
  Product(
      'assets/images/book-1.png',
      'کتاب هالیدی فیزیک عمومی',
      '  کتابی بسیار زیبا و با قابلیت دو گانه سوزی مناسب برای همه فصول جادار زیبا مطمئن',
      //'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      555),
  Product(
      'assets/headphones.png',
      'Blackzy PRO hedphones M003',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      152.99),
];

class ProductPage extends StatefulWidget {
  static String id = 'product_screen';
  //final Product product;

  //ProductPage({Key key, this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(products[1]);
}

class _ProductPageState extends State<ProductPage> {
  final Product product;

  _ProductPageState(this.product);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget viewProductButton  = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => null)),
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade400,
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("نمایش محصول",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: new SvgPicture.asset('assets/icons/search_icon.svg', fit: BoxFit.scaleDown,), onPressed: ()=> Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => null)),)
        ],
        title: Text(
          ' جزئیات کتاب',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 18.0),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                ProductDisplay(product: product),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 16.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                        color: const Color(0xFFFEFEFE),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),

                SizedBox(
                  height: 24.0,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                          border:
                          Border.all(color: Color(0xFFFFFF), width: 0.5),
                        ),
                        child: Center(
                          child: new Text("Details",
                              style: const TextStyle(
                                  color: const Color(0xeefefefe),
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                    padding:
                    EdgeInsets.only(left: 20.0, right: 40.0, bottom: 130),
                    child: new Text(
                        product.description,
                        style: const TextStyle(
                            color: Color.fromRGBO(253, 192, 84, 1),
                            fontWeight: FontWeight.w800,
                            fontFamily: "NunitoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0)))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                  top: 8.0, bottom: bottomPadding != 20 ? 20 : bottomPadding),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:[
                        Color.fromRGBO(255, 255, 255, 0),
                        Color.fromRGBO(253, 192, 84, 0.5),
                        Color.fromRGBO(253, 192, 84, 1),
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
              width: width,
              height: 120,
              child: Center(
                  child: viewProductButton),
            ),
          ),
        ],
      ),
    );
  }
}
