import 'package:flutter/material.dart';

import '../constants.dart';




class ReadingListCard extends StatelessWidget {
  final String image;
  final String title;
  final String auth;
  final Function onPressed;
  final String text;
  const ReadingListCard({
    Key key,
    this.image,
    this.title,
    this.auth,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("bookname$title");

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(left: 24, bottom: 40),
        height: 245,
        width: 202,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Banner(
                color: Colors.purple.shade300,
                message: text ?? '??',
                location: BannerLocation.bottomEnd,
                child: Container(
                  height: 221,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(29),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: FadeInImage(
                width: 130,
                height: 130,
                fit: BoxFit.cover,
                image: NetworkImage(image),
                placeholder: AssetImage('assets/images/book-1.png'),
              ),
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
      ),
    );
  }
}