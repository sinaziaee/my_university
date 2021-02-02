import "package:flutter/material.dart";
import 'package:persian_fonts/persian_fonts.dart';

import '../../constants.dart';

class AllFoodDetails extends StatefulWidget {
  static String id = 'AllDetail_screen';


  final String name;
  final int price;
  final String picture ;


  AllFoodDetails({this.name, this.price, this.picture});

  @override
  _AllFoodDetailsState createState() => _AllFoodDetailsState();
}

class _AllFoodDetailsState extends State<AllFoodDetails> {

  String name;
  int price;
  String picture ;
  String description;
  int counter = 1;


  @override
  Widget build(BuildContext context) {

    Map args = ModalRoute.of(context).settings.arguments;
    name = args["namefood"];
    price = args["price"];
    picture = args["image"];
    description = args["desc"];


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'توضیحات غذا',
          style: PersianFonts.Shabnam.copyWith(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: FadeInImage(
                  fit: BoxFit.fill,
                  image: (picture != null)
                      ? NetworkImage("$baseUrl/$picture")
                      : AssetImage('assets/joojeh.png'),
                  placeholder: NetworkImage(
                      "$baseUrl/$picture")
                  ,
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              name,textAlign: TextAlign.right,
              style: PersianFonts.Shabnam.copyWith(fontSize: 23.0),
            ),
            SizedBox(height: 25.0),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      "رستوران بسته است",
                      style: PersianFonts.Shabnam.copyWith(color: Colors.red),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${replaceFarsiNumber(price.toString())} ریال ", textDirection: TextDirection.rtl,
                        style: PersianFonts.Shabnam.copyWith(fontSize: 25.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 25.0),
            Align(alignment: Alignment.topRight,
                child: Container(child: Text(description, textAlign: TextAlign.right,
                    style: PersianFonts.Shabnam))),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Row(
          children: [

            Expanded(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: kOrangeColor,
                child: Text(
                  "لطفا در زمان رزرو خرید کنید",
                  style: PersianFonts.Shabnam.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
