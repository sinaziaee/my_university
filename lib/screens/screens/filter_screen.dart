import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';


class FilterScreen extends StatefulWidget {
  static String id = 'filter_screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double lowPrice = 20000;
  double highPrice = 50000;
  RangeValues rangeValues = RangeValues(10000, 100000);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        title: Text(
          'اعمال فیلتر',
          style: TextStyle(color: kPrimaryColor),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'متن جستجو شده',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 45,
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  Text(
                    'انتخاب دسته بندی',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Material(
                          child: InkWell(
                            highlightColor: Colors.black,
                            onTap: () {
                              _openDialog();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: 10, left: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.only(
                                left: 5,
                                right: 5,
                                top: 2,
                                bottom: 2,
                              ),
                              child: Container(
                                color: Colors.grey[300],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.arrow_drop_down),
                                    Text('همه دسته ها'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'دسته آگهی :',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(rangeValues.start.round().toString() + 'ت '),
                          SizedBox(width: size.width * 0.2),
                          Text(rangeValues.end.round().toString() + 'ت '),
                        ],
                      ),
                      trailing: Text('بازه ی قیمت'),
                      title: RangeSlider(
                          activeColor: kPrimaryColor,
                          inactiveColor: Colors.grey,
                          values: rangeValues,
                          min: 0,
                          max: 200000,
                          onChanged: (val) {
                            setState(() {
                              print(val);
                              rangeValues = val;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {},
                    color: kPrimaryColor,
                    minWidth: size.width - 40,
                    height: size.height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'اعمال فیلتر',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          FontAwesomeIcons.filter,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _openDialog() {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'انتخاب',
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.grey[600]),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: () {
                onPressed('دانشکده کامپیوتر');
              },
              child: Text(
                'دانشکده کامپیوتر',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده عمومی');
              },
              child: Text(
                'دانشکده عمومی',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده معارف');
              },
              child: Text(
                'دانشکده معارف',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده برق');
              },
              child: Text(
                'دانشکده برق',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده شیمی');
              },
              child: Text(
                'دانشکده شیمی',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده فیزیک');
              },
              child: Text(
                'دانشکده فیزیک',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده مهندسی شیمی');
              },
              child: Text(
                'دانشکده مهندسی شیمی',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده مکانیک');
              },
              child: Text(
                'دانشکده مکانیک',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده معماری');
              },
              child: Text(
                'دانشکده معماری',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده عمران');
              },
              child: Text(
                'دانشکده عمران',
                textAlign: TextAlign.end,
              ),
            ),
            FlatButton(
              onPressed: () {
                onPressed('دانشکده علوم کامپیوتر');
              },
              child: Text(
                'دانشکده علوم کامپیوتر',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  onPressed(String name) {
    print(name);
    Navigator.pop(context);
  }
}
