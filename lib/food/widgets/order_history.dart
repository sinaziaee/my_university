import 'package:flutter/material.dart';

class FoodHistoryItem extends StatelessWidget {
  final String name , image;
  final int requestId, counter;
  final double price;
  final String time_period;
  final List foodNames, foodCounts , foodImage;

  FoodHistoryItem({
    this.image,
    this.name,
    this.requestId,
    this.time_period,
    this.foodCounts,
    this.foodNames,
    this.counter,
    this.price,
    this.foodImage
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 2,
      child: ListTile(
        leading: Column(
          children: [
            Text(
              "",
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 5,),
            Text(
              price.toString().substring(0, price.toString().length-2) + ' تومان',
              style: TextStyle(fontSize: 12),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        title: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  foodNames[index] + ' ' + foodCounts[index].toString() + ' عدد',
                  textDirection: TextDirection.rtl,
                ),
                  FadeInImage(
            fit: BoxFit.fill,
            width: 50,
            height: 50,
            image: NetworkImage(
            "http://danibazi9.pythonanywhere.com/${foodImage[index]}"),
            placeholder: AssetImage('assets/joojeh.png'),
            )
              ],
            );
          },
          itemCount: counter,
          shrinkWrap: true,
        ),

      ),
    );
  }
}
