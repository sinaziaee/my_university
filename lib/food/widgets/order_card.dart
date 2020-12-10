import 'package:flutter/material.dart';
import 'package:my_university/food/widgets/todayFood.dart';

class OrderCard extends StatefulWidget {
  String name;
  int price;
  String picture ;
  int number = 1 ;
  Function onremove;

  OrderCard({this.name, this.price, this.picture, this.number , this.onremove });

  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  String name ;
  int price ;
  String picture  ;
  int remain ;
  int number = 1;


  List<TodayFoods>
  TodayFoodList = [
    // TodayFoods(
    //   name: "جوج",
    //   price: 18000,
    //   image: "assets/joojeh.png",
    // ),
    //
    // TodayFoods(
    //   name: "سلطانی",
    //   price: 20000,
    //   image: "assets/mix.png",
    // ),
  ];



  @override
  Widget build(BuildContext context) {

    Map args = ModalRoute.of(context).settings.arguments;
    widget.name = args["namefood"];
    widget.price = args["price"];
    widget.picture = args["image"];
    remain = args["remain"];


    TodayFoodList.add(
        TodayFoods(
            image: widget.picture,
            price: widget.price ,
            name: widget.name ));


    return Dismissible(
      key: ValueKey(args["serve_id"]),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        // Provider.of<Cart>(context, listen: false).removeItem(productId);
      },

      child: Card(
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
                height: 80.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                // child: Image(
                //   image: AssetImage(picture),
                // ),
                child : Expanded(
                  child: Center(
                    child:
                    Image.network("http://danibazi9.pythonanywhere.com/${widget.picture}"),
                    // FadeInImage(
                    //   fit: BoxFit.fill,
                    //   image: (picture != null)
                    //       ? NetworkImage("http://danibazi9.pythonanywhere.com/${widget.picture}")
                    //       : AssetImage('assets/joojeh.png'),
                    //   placeholder: NetworkImage("http://danibazi9.pythonanywhere.com/${widget.picture}")
                    //   ,
                    // ),
                  ),
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
                onTap: widget.onremove,
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
