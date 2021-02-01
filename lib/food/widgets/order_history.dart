import 'package:flutter/material.dart';

import '../../constants.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                replaceFarsiNumber(price.toString().substring(0, price.toString().length-2)) + ' ریال',
                style: TextStyle(fontSize: 15 , color: Colors.black),
                textDirection: TextDirection.rtl,
              ),
              Text(
                replaceFarsiNumber(time_period.substring(0,10)),
                style: TextStyle(fontSize: 10),
              ),
              Text(
                replaceFarsiNumber(time_period.substring(11,16)),
                style: TextStyle(fontSize: 10),
              ),

            ],
          ),
          title: ListView.builder(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        foodNames[index] + ' ' + foodCounts[index].toString() + ' عدد',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                    // SizedBox(width: 10,),
                    FadeInImage(
              fit: BoxFit.fill,
              width: 50,
              height: 50,
              image: NetworkImage(
              "$baseUrl/${foodImage[index]}"),
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
