import 'package:flutter/material.dart';

import '../constants.dart';

class TradeItem extends StatelessWidget {
  final String url, name, author;
  final sellerId, userId;

  TradeItem({this.url, this.author, this.name, this.sellerId, this.userId});

  @override
  Widget build(BuildContext context) {

    bool isSeller = false;
    var size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "فروخته شده",
                              style: TextStyle(
                                fontSize: 10,
                                color: kLightBlackColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    FadeInImage(
                      placeholder: AssetImage('assets/images/book-1.png'),
                      image: (url!='')?NetworkImage(url):AssetImage('assets/images/book-1.png'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 7,
              width: size.width * .65,
              decoration: BoxDecoration(
                color: isSeller ? KSellBook : KBuyBook,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
