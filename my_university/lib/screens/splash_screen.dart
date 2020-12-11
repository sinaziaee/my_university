import 'package:my_university/components/default_button.dart';
import 'package:my_university/components/splash_content.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "به اپلیکیشن دانشگاه من خوش آمدید \n پلتفرم جامع ارائه خدمات دانشجویی ",
      "image": "assets/images/screen1.png"
    },

    {
      "text":
      "خرید و فروش کتاب و جزوات دانشگاهی",
      "image": "assets/images/screen2.png"
    },

    {
      "text":
      "سامانه هوشمند رزرو غذای دانشجو",
      "image": "assets/images/screen3.png"
    },

    {
      "text": "مشاوره و راهنمای سوالات دانشجو \n  و هر آنچه یک دانشجو به آن نیاز دارد",
      "image": "assets/images/screen4.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                              (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(flex: 3),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.popAndPushNamed(context, LoginScreen.id);
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
