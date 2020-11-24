import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

int userID;

getSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String lastName = prefs.getString('last_name');
  String firstName = prefs.getString('first_name');
  String username = prefs.getString('username');
  //TODO
  userID = await prefs.getInt('user_id');
}

class TradeItem extends StatelessWidget {
  final String url, name, author, seller_username, buyer_username;
  final int seller, buyer;
  final bool status;

  TradeItem(
      {this.url,
      this.author,
      this.name,
      this.seller,
      this.status,
      this.buyer,
      this.seller_username,
      this.buyer_username});

  @override
  Widget build(BuildContext context) {
    getSharedPreferences();

    var size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 30),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            author,
                            style: TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                          Text(
                            (userID == seller)
                                ? buyer_username
                                : seller_username,
                            style: TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              (userID == seller) ? "فروخته شده" : "خریده شده",
                              style: TextStyle(
                                fontSize: 10,
                                color: kLightBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInImage(
                      placeholder: AssetImage('assets/images/book-1.png'),
                      image: (url != '')
                          ? NetworkImage(url)
                          : AssetImage('assets/images/book-1.png'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 7,
              width: size.width * .65,
              decoration: BoxDecoration(
                color: (userID == seller) ? KSellBook : KBuyBook,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
