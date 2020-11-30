import 'package:flutter/material.dart';
import 'package:my_university/food/screens/AllFoodDetails.dart';
import 'package:my_university/food/screens/TodayFoodDetails.dart';
import 'package:my_university/food/widgets/AllFoodsCard.dart';
import 'package:my_university/food/widgets/allfoods.dart';
import 'package:my_university/food/widgets/product_card.dart';
import 'package:my_university/food/widgets/todayFood.dart';

import '../../constants.dart';



class DeliveryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 18.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "لیست غذاهای امروز",
              style: kTitle1Style.copyWith(fontSize: 22.0),
            ),
            Container(
              width: double.infinity,
              height: 250.0,
              child: ListView.builder(
                itemCount: TodayFoodList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var product = TodayFoodList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodayFoodDetails(product: product),
                        ),
                      );
                    },
                    child: ProductCard(
                      product: product,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height:20,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("منوی رستوران (غیر قابل فروش)",
                  style: kTitle1Style.copyWith(fontSize: 22.0)
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.only(right: 18.0),
            //   child: Image.asset(
            //     "assets/banner.png",
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            GridView.builder(
              itemCount: AllFoodList.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0 / 1.3,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: (context, index) {
                var product = AllFoodList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllFoodDetails(product: product),
                      ),
                    );
                  },
                  child: AllFoodsCard(
                    product: product,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
