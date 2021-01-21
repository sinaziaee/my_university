import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BookItem extends StatelessWidget {
  final String name, url, author, faculty, publisher, cost, timeStamp;
  final int book_id, seller_id;
  final Function onPressed;

  BookItem({this.name,
    this.url,
    this.faculty,
    this.publisher,
    this.book_id,
    this.seller_id,
    this.author,
    this.cost,
    this.timeStamp,
    this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Card(
          elevation: 30,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 30, right: 10, top: 10, bottom: 10),
                child: Banner(
                  textStyle : TextStyle(fontSize: 18),
                  color: Colors.purple.shade300,
                  message: replaceFarsiNumber(cost.toString()),
                  location: BannerLocation.bottomEnd,
                  child: ClipRRect(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5),
                    //   border: Border.all(
                    //     color: Colors.grey,
                    //     width: 1,
                    //   ),
                    // ),

                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/book_unknown.png'),
                      image: (url!='')?NetworkImage(url): AssetImage('assets/images/book_unknown.png'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 30  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(name , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                      SizedBox(height: 10,),
                      Text("نویسنده: $author" , textAlign: TextAlign.right),
                      Text("دانشکده: $publisher" , textAlign: TextAlign.right,),
                      // Text(timeStamp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
