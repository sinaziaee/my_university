
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_university/screens/books_screen.dart';

class GridDashboard extends StatefulWidget {


  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  @override
  Widget build(BuildContext context) {
    Items item1 = new Items(
        title: "خفت کتاب",
        subtitle: "خرید , فروش , تبادل",
        img: "assets/images/khaft.png",

    );

    Items item2 = new Items(
      title: "سامانه تغذیه",
      subtitle: "رزرو اتوماتیک غذا",
      img: "assets/images/food.png",
    );
    Items item3 = new Items(
      title: "ثبت نام در رویداد ها",
      subtitle: "",
      img: "assets/images/map.png",
    );
    Items item4 = new Items(
      title: "اخبار دانشگاه",
      subtitle: "اطلاع از آخرین قوانین ",
      img: "assets/images/elmos.png",
    );
    Items item5 = new Items(
      title: "درباره ما",
      subtitle: "گروه برنامه نویسی دولاور",
      img: "assets/images/logo.png",
    );
    Items item6 = new Items(
      title: "سوالات متداول",
      subtitle: "",
      img: "assets/images/setting.png",
    );

    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(onTap:(){
              setState(() {
                  Navigator.pushNamed(context, BooksScreen.id);
              });
            },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 72,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items extends StatefulWidget {
  final String title;
  final String subtitle;
  final String img;
  Items({this.title, this.subtitle, this.img });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

