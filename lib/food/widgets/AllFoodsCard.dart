import 'package:flutter/material.dart';
import 'package:my_university/food/widgets/allfoods.dart';

import '../../constants.dart';


class AllFoodsCard extends StatelessWidget {
  final AllFoods product;
  AllFoodsCard({this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: kTitle1Style,
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(" \ تومان ${product.price}", style: kSubtitleStyle),
              ],
            ),
            // trailing: Container(
            //   width: 40.0,
            //   height: 40.0,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     border: Border.all(color: kOrangeColor),
            //   ),
            //   child: Icon(
            //     Icons.add,
            //     color: kOrangeColor,
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}
