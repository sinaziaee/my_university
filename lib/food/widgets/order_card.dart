import 'package:flutter/material.dart';
import 'package:my_university/food/screens/delivery_tab.dart';

class OrderCard extends StatelessWidget{

  final String name, picture;
  final int price, number;
  final Function onRemove, onDecrease, onIncrease;

  OrderCard({this.name, this.price, this.picture, this.number, this.onRemove, this.onDecrease, this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red[900], width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 60,
              height: 85.0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        onTap: onIncrease,
                        child: Icon(Icons.add_circle,
                            color: Colors.red[900])),
                    Text(
                      number.toString(),
                      style: TextStyle(fontSize: 18.0, color : Colors.red[900]),
                    ),
                    InkWell(
                        onTap: onDecrease,
                        child: Icon(Icons.remove_circle,
                            color: Colors.red[900])),
                    // SizedBox(height: 10,)
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
              child : Center(
                child:
                FadeInImage(
                  fit: BoxFit.fill,
                  width: 70,
                  height: 70,
                  image: NetworkImage("http://danibazi9.pythonanywhere.com/${picture}"),
                  placeholder: AssetImage('assets/joojeh.png'),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    price.toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
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
            ),
            Spacer(),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.cancel,
                color: Colors.red[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
