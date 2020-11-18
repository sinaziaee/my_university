import 'package:flutter/material.dart';

import '../constants.dart';

class ReadingListCard extends StatelessWidget {
  final String image;
  final String title;
  final String auth;


  const ReadingListCard({
    Key key,
    this.image,
    this.title,
    this.auth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 245,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 10),
                //     blurRadius: 33,
                //     color: kShadowColor,
                //   ),
                // ],
              ),
            ),
          ),
          FadeInImage(
            width: 150,
            height: 150,
            image: (image != '')?NetworkImage(image):AssetImage('assets/images/book-1.png'),
            placeholder: AssetImage('assets/images/book-1.png'),
          ),
          Positioned(
            top: 160,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: auth,
                            style: TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),

                    ],
                  )
            ),
          ),
        ],
      ),
    );
  }
}
