import 'package:flutter/material.dart';
import 'package:my_university/components/about_item.dart';
import 'package:my_university/constants.dart';

class AboutUsScreen extends StatefulWidget {
  static String id = 'about_us_screen';
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: size.height * 0.07,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'درباره ی ما',
          style: kTitle1Style,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'تیم فنی توسعه دهنده',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: kDescriptionStyle.copyWith(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Develover',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: kDescriptionStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.055,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AboutItem(
                  size: size,
                  name: 'سید محمد مهدی رضوی',
                  skills: 'Front-End Developer',
                  path: 'assets/profile/seyyed.jpg',
                ),
                AboutItem(
                  size: size,
                  name: 'مهدی آراسته فرد',
                  skills: 'Front-End Developer',
                  path: 'assets/profile/mahdi.PNG',
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AboutItem(
                  size: size,
                  name: 'سینا ضیایی',
                  skills: 'Full-Stack Developer',
                  path: 'assets/profile/sina.jpg',
                ),
                AboutItem(
                  size: size,
                  name: 'دانیال بازمانده',
                  path: 'assets/profile/dani.jpg',
                  skills: 'Back-End Developer',
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),

            // AboutItem(
            //   size: size,
            //   name: 'علیرضا حقانی',
            //   skills: 'BackEnd Developer',
            //   path: 'assets/profile/ali.jpg',
            // ),
          ],
        ),
      ),
    );
  }
}
