
import 'package:flutter/material.dart';
import '../../constants.dart';



class TodayCard extends StatelessWidget {

  final int id ;
  final String name;
  final int price;
  final String picture ;
  final Function onPressed;
  final String description;
  final int remain;


  TodayCard({this.id,this.name, this.price, this.picture,
    this.onPressed , this.description, this.remain});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ,
      child: Container(
        height: 245,
        width: 202,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // isRecommended
            //     ? Chip(
            //         backgroundColor: kRedColor,
            //         padding: EdgeInsets.symmetric(
            //           horizontal: 10.0,
            //           vertical: 8.0,
            //         ),
            //         label: Text(
            //           "Top",
            //           style: kChipStyle,
            //         ),
            //       )
            //     : Container(),
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
                  Text(" \ ریال ${price}", style: kSubtitleStyle),
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
    );
  }
}
