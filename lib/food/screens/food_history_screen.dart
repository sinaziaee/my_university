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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
                    return Container(
                      child: Center(
                        child: Text(
                          'غذایی امروز سفارش داده نشده',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    );
                  }
                  return Container(
                    height: size.height * 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        List items = mapList[index]['items'];
                        List foodNames = [];
                        List foodCounts = [];
                        int counter = 0;
                        for (var each in items) {
                          foodNames.add(each["name"]);
                          foodCounts.add(each["count"]);
                          counter++;
                        }
                        return FoodHistoryItem(
                          name: 'name_user',
                          price: mapList[index]['total_price'],
                          requestId: mapList[index]['order_id'],
                          foodCounts: foodCounts,
                          foodNames: foodNames,
                          counter: counter,
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
    );
  }
}
