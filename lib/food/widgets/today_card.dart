
import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import '../../constants.dart';



class TodayCard extends StatelessWidget {

  final int id ;
  final String name;
  final int price;
  final String picture ;
  final Function onPressed;
  final String description;
  final int remain;
  final Size size;

  TodayCard({this.id,this.name, this.price, this.picture,
    this.onPressed , this.description, this.remain, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0,),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey[100],
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: onPressed ,
          child: Container(
            height: size.height * 0.25,
            width: size.width * 0.45,
            padding: EdgeInsets.all(2),
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
                      Text("${replaceFarsiNumber(price.toString())} ریال " ,
                          textDirection: TextDirection.rtl, style: PersianFonts.Shabnam),
                      // Text("00", style: kSubtitle2Style),
                    ],
                  ),
                  trailing: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.red,
                    ),
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
