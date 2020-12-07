import 'package:flutter/material.dart';
import 'package:my_university/food/widgets/todayFood.dart';

class OrderCard extends StatefulWidget {
  final String name;
  final int price;
  final String picture ;


  OrderCard({this.name, this.price, this.picture,});

  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  String name ;
  int price ;
  String picture  ;
  int remain ;
  int number = 1;

  // List<TodayFoods> TodayFoodList = [
  //   TodayFoods(
  //     name: "جوج",
  //     price: 18000,
  //     image: "assets/joojeh.png",
  //   ),
  //   TodayFoods(
  //     name: "سلطانی",
  //     price: 20000,
  //     image: "assets/mix.png",
  //   ),
  // ];



  @override
  Widget build(BuildContext context) {

    Map args = ModalRoute.of(context).settings.arguments;
    // name = args["namefood"];
    // price = args["price"];
    // picture = args["image"];
    remain = args["remain"];



    return Card(

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD3D3D3), width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 45.0,
              height: 73.0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          setState(() {
                            if(number< remain){
                              number++;
                            }
                          });

                        },
                        child: Icon(Icons.keyboard_arrow_up,
                            color: Color(0xFFD3D3D3))),
                    Text(
                      number.toString(),
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            if(number>1){
                              number--;
                            }
                          });

                        },
                        child: Icon(Icons.keyboard_arrow_down,
                            color: Color(0xFFD3D3D3))),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 70.0,
              width: 70.0,
              // child: Image(
              //   image: AssetImage(picture),
              // ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.picture),
                      fit: BoxFit.cover

                  ),

                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(
                        // color: Colors.black,
                        blurRadius: 5.0,
                        offset: Offset(0.0, 2.0))
                  ]
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  widget.price.toString(),
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Container(
                  height: 25.0,
                  width: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("تومان",
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5.0,
                          ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Text(
                          //     "x",
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
