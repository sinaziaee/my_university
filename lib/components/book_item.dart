import 'package:flutter/material.dart';

import '../constants.dart';

class MyBookItem extends StatelessWidget {
  final url;
  final title;
  final description;
  final category;
  final cost;
  final onPressed;

  MyBookItem(this.url, this.title, this.description, this.category, this.cost,
      this.onPressed);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        padding: EdgeInsets.only(top: 15),
        height: 100,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: FadeInImage(
                          width: 60,
                          height: 60,
                          placeholder: AssetImage('assets/images/not_found.png'),
                          image: NetworkImage(url ?? baseUrl),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              title ?? 'Title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              description ?? 'Description',
                              style: TextStyle(
                                color: kLightBlackColor,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                category ?? 'category',
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
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    width: 100,
                    height: 25,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cost ?? 'ffffffgggggggggf',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 10,
                width: size.width * .65,
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
