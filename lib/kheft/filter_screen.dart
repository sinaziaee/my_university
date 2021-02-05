import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persian_fonts/persian_fonts.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FilterScreen extends StatefulWidget {
  static String id = 'filter_screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map args;

  String selectedFaculty, token, selectedBookName;
  int selectedBookId;
  String facultiesUrl = '$baseUrl/api/professors/faculties';
  TextEditingController searchController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  int min = 0, max = 200000;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    String search = args['search'];
    String faculty = args['faculty'];
    int min = args['min'];
    token = args['token'];
    int max = args['max'];
    if (search != null) {
      searchController.text = search;
    }
    if (faculty != null && selectedFaculty == null) {
      selectedFaculty = faculty;
    }
    if (min != null) {
      // rangeValues = RangeValues(min * 1.0, max * 1.0);
      this.min = min;
      minController.text = min.toString();
    }
    if (max != null) {
      // rangeValues = RangeValues(min * 1.0, max * 1.0);
      this.max = max;
      maxController.text = max.toString();
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfffff8ee),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        title: Text(
          'اعمال فیلتر',
          style: PersianFonts.Shabnam.copyWith(color: kPrimaryColor),
        ),
        elevation: 1,
        backgroundColor: Color(0xfffff8ee),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfffff8ee),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ' : متن جستجو شده',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 45,
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      controller: searchController,
                      onChanged: (val) {
                        print(searchController.text);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 22.5, left: 5, right: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                  Text(
                    ' : انتخاب دسته بندی',
                    style:
                        PersianFonts.Shabnam.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 2,
                            bottom: 2,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              highlightColor: Colors.transparent,
                              onTap: () {
                                onFacultyPressed();
                              },
                              child: Container(
                                // color: Colors.grey[300],
                                padding: EdgeInsets.only(
                                    right: 10, left: 10, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.arrow_drop_down),
                                    Text(selectedFaculty ?? 'همه دانشکده ها'),
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
                          'دانشکده :',
                          textDirection: TextDirection.rtl,
                          style: PersianFonts.Shabnam,
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
                    margin: EdgeInsets.only(left: 30),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: minController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 22.5, left: 5, right: 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'حداقل قیمت :',
                            textDirection: TextDirection.rtl,
                            style: PersianFonts.Shabnam,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 30),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: maxController,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text('حداکثر قیمت :',
                              textDirection: TextDirection.rtl,
                              style: PersianFonts.Shabnam),
                        ],
                      ),
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
                    onPressed: () {
                      onPressed();
                    },
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
                          style: PersianFonts.Shabnam.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
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

  onFacultyPressed() async {
    print('token: $token');
    http.Response response = await http.get(
      facultiesUrl,
      headers: {HttpHeaders.authorizationHeader: token},
    );
    var jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print('*****************************');
    print(jsonResponse);
    List<Map> mapList = [];
    int count = 0;
    for (Map each in jsonResponse) {
      count++;
      mapList.add(each);
    }
    if (count == 0) {
      showDialog(
        context: context,
        child: AlertDialog(
          content: Center(
            child: Text('دانشکده ای وجود ندارد'),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        child: AlertDialog(
          content: Container(
            height: 400,
            width: 250,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple.shade100,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          selectedFaculty = mapList[index]['name'];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Center(
                          child: Text(
                            mapList[index]['name'],
                            textAlign: TextAlign.center,
                            style: PersianFonts.Shabnam.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }

  onPressed() {
    String search = searchController.text;
    if (this.min > this.max) {
      discuss(context, 'حداقل قیمت نمیتواند از حداکثر قیمت بیشتر باشد.');
    }
    if (this.min > 200000) {
      minController.text = '200000';
      this.min = 200000;
    }
    if (this.max > 200000) {
      minController.text = '200000';
      this.max = 200000;
    }
    if (this.min < 0) {
      minController.text = '0';
      this.min = 0;
    }
    if (this.max < 0) {
      maxController.text = '0';
      this.max = 0;
    }
    if (search.trim().length == 0) {
      search = null;
    }
    String faculty = selectedFaculty;
    print('selected faculty: $selectedFaculty');
    int min, max;
    if (minController.text.length != 0 && maxController.text.length != 0) {
      min = int.parse(minController.text);
      max = int.parse(maxController.text);
    }

    print('min: $min ,  max: $max');
    // Navigator.pop(context, {'search': search, "faculty": faculty, "min": min, "max": max});
    Map map = {'search': search, "faculty": faculty, "min": min, "max": max};
    Navigator.pop(context, map);
  }
}
