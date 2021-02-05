import 'package:flutter/material.dart';
import 'package:my_university/food/widgets/allfoods.dart';
import 'package:persian_fonts/persian_fonts.dart';

import '../../constants.dart';


class AllFoodsCard extends StatelessWidget {
  final String name;
  final int price;
  final String picture ;
  final Function onPressed;
  final String Description;
  final Size size;

  AllFoodsCard({this.name, this.price, this.picture, this.onPressed , this.Description, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0, bottom: 10),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey[100],
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: onPressed,
          child: Container(
            width: size.width * 0.45,
            height: size.height * 0.3,
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: FadeInImage(
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      image: (picture != null)
                          ? NetworkImage("$baseUrl/$picture")
                          : AssetImage('assets/joojeh.png'),
                      placeholder: AssetImage('assets/joojeh.png')
                      ,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    name,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    style: PersianFonts.Shabnam,
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(" ${replaceFarsiNumber(price.toString())} ریال ",
                          textDirection: TextDirection.rtl , style: PersianFonts.Shabnam),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
