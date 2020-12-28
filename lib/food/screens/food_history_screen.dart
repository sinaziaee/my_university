import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_university/food/widgets/order_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../constants.dart';

class History extends StatelessWidget {

  String token, orderHistoryUrl='$baseUrl/api/food/user/order/history/';
  int userId;

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/images/hotelBig.png"),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)
                        , bottomRight: Radius.circular(40))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text("", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),),
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.star, color: Colors.white,),
                                Icon(Icons.star, color: Colors.white,),
                                Icon(Icons.star, color: Colors.white,),
                                Icon(Icons.star, color: Colors.white,),
                                Icon(Icons.star, color: Colors.white,),
                                Text(" 250 Reviews", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13
                                ),)
                              ],
                            )
                          ],
                        ),

                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white
                          ),
                          child: Center(
                            child: Icon(Icons.favorite,color: Colors.redAccent, size: 35,),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Text(" سلف آزاد دانشگاه علم و صنعت ایران", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                      ),),
                    )
                  ],
                ),
              ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
                      child: FutureBuilder(
                        future: getToken(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                            return FutureBuilder(
                              future: http.get(orderHistoryUrl, headers: {
                                HttpHeaders.authorizationHeader: token,
                              }),
                                builder: (context, snapshot){
                              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                                http.Response response = snapshot.data;
                                if (response.statusCode >= 400) {
                                  print(response.statusCode);
                                  print(response.body);
                                  print(
                                      '$orderHistoryUrl');
                                  return Center(
                                    child: Text(
                                      'مشکلی درارتباط با سرور پیش آمد',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  );
                                }
                                var jsonResponse = convert.jsonDecode(
                                    convert.utf8.decode(response.bodyBytes));
                                print(jsonResponse);
                                List<Map> mapList = [];
                                int count = 0;
                                // print(jsonResponse);
                                for (Map map in jsonResponse) {
                                  count++;
                                  mapList.add(map);
                                  // print(map.toString());
                                }
                                if (count == 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(50,30,50,10),
                                        child: Image(
                                            image: AssetImage("assets/images/order.png")
                                        ),
                                      ),
                                      Center(
                                          child: Text(
                                            'غذایی امروز سفارش داده نشده \n لطفا سفارش خود را ثبت کنید',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                }
                                return Container(
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      List items = mapList[index]['items'];
                                      List foodNames = [];
                                      List foodCounts = [];
                                      List foodImage = [];
                                      int counter = 0;
                                      for (var each in items) {
                                        foodNames.add(each["name"]);
                                        foodCounts.add(each["count"]);
                                        foodImage.add(each["image"]);
                                        counter++;
                                      }
                                      return FoodHistoryItem(
                                        name: 'name_user',
                                        price: mapList[index]['total_price'],
                                        requestId: mapList[index]['order_id'],
                                        foodCounts: foodCounts,
                                        foodNames: foodNames,
                                        counter: counter,
                                        foodImage: foodImage,
                                        image: mapList[index]['image'],
                                        time_period: mapList[index]['last_update'],
                                      );
                                    },
                                    itemCount: count,
                                  ),
                                );                }
                              else {
                                return Center(child: CircularProgressIndicator(),);
                              }
                            });
                          }
                          else {
                            return Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

          ),
        );

  }
}
