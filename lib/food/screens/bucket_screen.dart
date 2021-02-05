import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:my_university/food/screens/food_history_screen.dart';
import 'package:my_university/food/widgets/order_card.dart';
import 'package:my_university/kheft/chat_rooms_screen.dart';
import '../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'delivery_tab.dart';

class Bucket extends StatefulWidget {
  static String id = 'bucket_screen';

  @override
  _BucketState createState() => _BucketState();
}

class _BucketState extends State<Bucket> {
  bool showSpinner = false;
  int serveID;
  String orderAddUrl = '$baseUrl/api/food/user/order/add/';

  String postFoodUrl =
      '$baseUrl/api/food/user/order/add/';

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int count = DeliveryTab.listTodayFoods.length;
    if (count == 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
            height: height * 0.6,
            width: width,
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius:
              BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:30 ),
                    child: Text(
                      'سبد خرید سلف آزاد',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:30),
                  child: Icon(Icons.add_shopping_cart, color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50,50,50,10),
              child: Image(
                  image: AssetImage("assets/images/bucket.png")
              ),
            ),
            Center(
              child: Text('سبد غذا خالیه!', style: TextStyle(fontSize: 25), textDirection: TextDirection.rtl,),
            ),
          ],
        ),
        bottomNavigationBar: _buildTotalContainer(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
          child: Container(
          height: height * 0.6,
          width: width,
          decoration: BoxDecoration(
          color: Colors.red[900],
          borderRadius:
          BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)
    ),
    ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:30 ),
                    child: Text(
                      'سبد خرید سلف آزاد',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:30),
                  child: Icon(Icons.add_shopping_cart, color: Colors.white,
                  ),
                ),
              ],
            ),
      ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: 500,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: count,
          itemBuilder: (context, index) {
            return OrderCard(
              name: DeliveryTab.listTodayFoods[index].name,
              price: DeliveryTab.listTodayFoods[index].price,
              picture: DeliveryTab.listTodayFoods[index].image,
              number: DeliveryTab.listTodayFoods[index].number,
              onDecrease: () {
                onDecrease(index);
              },
              onIncrease: () {
                onIncrease(index);
              },
              onRemove: () {
                onRemove(index);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  onRemove(int index) {
    DeliveryTab.listTodayFoods.removeAt(index);
    setState(() {});
  }

  onDecrease(int index) {
    if(DeliveryTab.listTodayFoods[index].number == 1){
      // pass
    }
    else {
      DeliveryTab.listTodayFoods[index].number--;
    }
    setState(() {});
  }

  onIncrease(int index) {
    DeliveryTab.listTodayFoods[index].number++;
    setState(() {});
  }

  String getTotal(){
    int count = 0;
    for (int i=0;i<DeliveryTab.listTodayFoods.length;i++){
      count += DeliveryTab.listTodayFoods[i].price * DeliveryTab.listTodayFoods[i].number;
    }
    print(count);
    return count.toString();
  }

  Widget _buildTotalContainer() {
    return Container(
      height: 120.0,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "مجموع فاکتور ( به ریال ) ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  replaceFarsiNumber(getTotal()),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                postNewOrder();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => History()));
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.red[900]
                  ,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Center(
                  child: Text(
                    "تکمیل سفارش",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 20.0,
          // ),
        ],
      ),
    );
  }

  postNewOrder() async {
    Map map = Map();

    List maps = [];
    for (var each in DeliveryTab.listTodayFoods) {
      maps.add(each.toMap());
    }
    map['food_list'] = maps;

    http.Response response;

    response = await http.post(
      orderAddUrl,
      headers: {
        HttpHeaders.authorizationHeader: token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.jsonEncode(map),
    );
    if (response.statusCode >= 400) {
      print(response.body);
      _showDialog(context, "متاسفانه مشکلی پیش آمد");
    } else {
      success(context, "سفارش غذا با موفقیت انجام شد");
      DeliveryTab.listTodayFoods.clear();
    }
    setState(() {
      showSpinner = false;
    });
  }

  _showDialog(BuildContext context, String title) async{
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطا',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)..show();
  }

  success(BuildContext context, String title) async{
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'موفقیت',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.green)..show();
  }
}
