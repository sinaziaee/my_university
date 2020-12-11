import "package:flutter/material.dart";
import 'package:my_university/food/widgets/allfoods.dart';

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
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kBlackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: FadeInImage(
                  fit: BoxFit.fill,
                  image: (picture != null)
                      ? NetworkImage("http://danibazi9.pythonanywhere.com/$picture")
                      : AssetImage('assets/joojeh.png'),
                  placeholder: AssetImage('assets/joojeh.png')
                  ,
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              name,
              style: kTitle1Style.copyWith(fontSize: 23.0),
            ),
            SizedBox(height: 25.0),
            Row(
              children: [
                Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       if(counter>1){
                    //         counter--;
                    //       }
                    //     });
                    //   },
                    //   child: Container(
                    //     width: 40.0,
                    //     height: 40.0,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: kGreyColor),
                    //     ),
                    //     child: Icon(
                    //       Icons.remove,
                    //       color: kOrangeColor,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: 15.0),
                    Text(
                      "رستوران بسته است",
                      style: kDescriptionStyle.copyWith(color: Colors.red),
                    ),
                    // SizedBox(width: 15.0),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       counter++;
                    //     });
                    //   },
                    //   child: Container(
                    //     width: 40.0,
                    //     height: 40.0,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: kOrangeColor),
                    //     ),
                    //     child: Icon(
                    //       Icons.add,
                    //       color: kOrangeColor,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\ تومان ${price}",
                      style: kTitle1Style.copyWith(fontSize: 25.0),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 25.0),
            Align(alignment: Alignment.topRight,
                child: Container(child: Text(description, style: kDescriptionStyle))),
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
                  style: kTitle2Style.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
