import 'package:my_university/components/product.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;

  const ProductDisplay({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
       Container(
        margin: EdgeInsets.only(
          bottom: 30,
        ),
        height: MediaQuery.of(context).size.height * 0.32,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25,
                    offset: Offset(8, 8),
                    spreadRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25,
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
                  image: NetworkImage(product.image),
                ),
              ),
            ),

            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // gradient: new LinearGradient(
                //   colors: [
                //     Colors.black.withOpacity(0.3),
                //     Colors.transparent,
                //     Colors.black.withOpacity(0.3),
                //   ],
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                // ),
              ),
            ),
          ],
        ),
      ),
        Text(
          // "Conjure Women",
          product.name,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          //"By Afia Atakora",
          "  نویسنده: ${product.author}  ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
           "${product.price} تومان ",
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
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 40,
              right: 20,
            ),
            child: Text(product.description,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.5,
                height: 1.5,
              ),
            ),
          ),
        ),

    ]
    );



      // Container(
      // child: Stack(
      //   children: <Widget>[
      //     Positioned(
      //         top: 30.0,
      //         right: 0,
      //         child: Container(
      //             width: MediaQuery.of(context).size.width / 1.5,
      //             height: 85,
      //             padding: EdgeInsets.only(right: 24),
      //             decoration: new BoxDecoration(
      //                 color: darkGrey,
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(8.0),
      //                     bottomLeft: Radius.circular(8.0)),
      //                 boxShadow: [
      //                   BoxShadow(
      //                       color: Color.fromRGBO(0, 0, 0, 0.16),
      //                       offset: Offset(0, 3),
      //                       blurRadius: 6.0),
      //                 ]),
      //             child: Align(
      //               alignment: Alignment(1, 0),
      //               child: RichText(
      //                 text: TextSpan(children: [
      //                   TextSpan(
      //                       text: '\ ${product.price}',
      //                       style: const TextStyle(
      //                           color: const Color(0xFFFFFFFF),
      //                           fontWeight: FontWeight.w400,
      //                           fontFamily: "Montserrat",
      //                           fontSize: 36.0)),
      //                   TextSpan(
      //                       text: ' Rial',
      //                       style: const TextStyle(
      //                           color: const Color(0xFFFFFFFF),
      //                           fontWeight: FontWeight.w400,
      //                           fontFamily: "Montserrat",
      //                           fontSize: 36.0))
      //                 ]),
      //               ),
      //             ))),
      //     Align(
      //       alignment: Alignment(-1, 0),
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      //         child: Container(
      //           height: screenAwareSize(150, context),
      //           child: Stack(
      //             children: <Widget>[
      //               Padding(
      //                 padding: const EdgeInsets.only(
      //                   bottom: 18.0,
      //                 ),
      //                 child: Container(
      //                   child: Hero(
      //                     tag: product.image,
      //                     child: FadeInImage(
      //                       width: 150,
      //                       height: 150,
      //                       fit: BoxFit.cover,
      //                       placeholder:
      //                           AssetImage('assets/images/book-1.png'),
      //                       image: NetworkImage(product.image),
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
          // Positioned(
          //   left: 20.0,
          //   bottom: 0.0,
          //   child: RawMaterialButton(
          //     onPressed: () => Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) => null)),
          //     constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
          //     child:
          //         Icon(Icons.favorite, color: Color.fromRGBO(255, 137, 147, 1)),
          //     elevation: 0.0,
          //     shape: CircleBorder(),
          //     fillColor: Color.fromRGBO(255, 255, 255, 0.4),
          //   ),
          // )
    //     ],
    //   ),
    // );
  }
}
