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
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Column(
            children: [
              Text(
                time_period.substring(0,10),
                style: TextStyle(fontSize: 10),
              ),
              Text(
                time_period.substring(11,16),
                style: TextStyle(fontSize: 10),
              ),
              Text(
                price.toString().substring(0, price.toString().length-2) + ' تومان',
                style: TextStyle(fontSize: 10),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          title: ListView.builder(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      foodNames[index] + ' ' + foodCounts[index].toString() + ' عدد',
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                    SizedBox(width: 10,),
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
      ),
    );
  }
}
