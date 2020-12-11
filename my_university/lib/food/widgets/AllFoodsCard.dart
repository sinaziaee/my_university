import 'package:flutter/material.dart';
import 'package:my_university/food/widgets/allfoods.dart';

import '../../constants.dart';


class AllFoodsCard extends StatelessWidget {
  final String name;
  final int price;
  final String picture ;
  final Function onPressed;
  final String Description;


  AllFoodsCard({this.name, this.price, this.picture, this.onPressed , this.Description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 200.0,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: FadeInImage(
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  image: (picture != null)
                      ? NetworkImage("http://danibazi9.pythonanywhere.com/$picture")
                      : AssetImage('assets/joojeh.png'),
                  placeholder: AssetImage('assets/joojeh.png')
                  ,
                ),
              ),
            ),
            ListTile(
              title: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: kTitle1Style,
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(" \ تومان $price", style: kSubtitleStyle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
