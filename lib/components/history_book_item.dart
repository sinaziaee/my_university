import 'package:flutter/material.dart';

import '../constants.dart';

class MyBookItem extends StatelessWidget {
  final String name, author, url, otherUser;
  final int seller, user, buyer;
  final Function onPressed;

  MyBookItem(
      {this.name,
      this.author,
      this.url,
      this.seller,
      this.buyer,
      this.user,
      this.otherUser,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    String whatTheFuck = '';

    if (user == seller) {
      whatTheFuck = 'انتظار برای فروش';
    } else {
      whatTheFuck = 'انتظار برای رزرو';
    }

    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(38.5),
          child: Container(
            color: Colors.grey[100],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                            Text(
                              otherUser,
                              style: TextStyle(
                                color: kLightBlackColor,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  whatTheFuck,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: kLightBlackColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FadeInImage(
                          height: 90,
                          width: 70,
                          fit: BoxFit.cover,
                          placeholder:
                              AssetImage('assets/images/book_unknown.png'),
                          image: (url != null)
                              ? NetworkImage(url)
                              : AssetImage('assets/images/book_unknown.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 7,
                  width: size.width * .65,
                  decoration: BoxDecoration(
                    color: (user==seller)? KSellBook : KBuyBook,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
