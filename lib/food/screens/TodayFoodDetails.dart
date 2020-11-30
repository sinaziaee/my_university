import "package:flutter/material.dart";
import 'package:my_university/food/widgets/todayFood.dart';

import '../../constants.dart';


class TodayFoodDetails extends StatefulWidget {
  final TodayFoods product;
  TodayFoodDetails({this.product});

  @override
  _TodayFoodDetailsState createState() => _TodayFoodDetailsState();
}

class _TodayFoodDetailsState extends State<TodayFoodDetails> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
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
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.more_horiz,
        //       color: kBlackColor,
        //     ),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  widget.product.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              widget.product.name,
              style: kTitle1Style.copyWith(fontSize: 23.0),
            ),
            SizedBox(height: 25.0),
            Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if(counter>1){
                            counter--;
                          }
                        });
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kGreyColor),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: kOrangeColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      counter.toString(),
                      style: kTitle1Style,
                    ),
                    SizedBox(width: 15.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          counter++;
                        });
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kOrangeColor),
                        ),
                        child: Icon(
                          Icons.add,
                          color: kOrangeColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\ تومان ${widget.product.price}",
                      style: kTitle1Style.copyWith(fontSize: 25.0),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 25.0),
            Text(
              "$counter pc (${widget.product.weight}) gram",
              style: kSubtitleStyle.copyWith(color: kOrangeColor),
            ),
            SizedBox(height: 25.0),
            Text(widget.product.description, style: kDescriptionStyle),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Row(
          children: [
            // IconButton(
            //   icon: Icon(
            //     isLiked ? Icons.favorite : Icons.favorite_border,
            //     color: Colors.red,
            //   ),
            //   onPressed: () {
            //     setState(() {
            //       (!isLiked) ? isLiked = true : isLiked = false;
            //     });
            //   },
            // ),
            SizedBox(width: 25.0),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: kOrangeColor,
                child: Text(
                  "Add to Bucket",
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
