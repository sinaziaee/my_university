import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String facultiesUrl = '$baseUrl/api/bookbse/faculties';
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
                      controller: searchController,
                      onChanged: (val) {
                        print(searchController.text);
                      },
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
                              // _openDialog();
                              _showFacultiesDialog();
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
                      trailing: Text('حداقل قیمت  '),
                      title: Container(
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: minController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      trailing: Text('حداکثر قیمت  '),
                      title: Container(
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: maxController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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

  _showFacultiesDialog() async {
    http.Response response = await http
        .get(facultiesUrl, headers: {HttpHeaders.authorizationHeader: token});
    var jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
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
            width: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    selectedFaculty = mapList[index]['name'];
                    print(selectedFaculty);
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        mapList[index]['name'],
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }

  openDialog(String title) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          title,
          textDirection: TextDirection.rtl,
        ),
        content: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('باشه!'),
        ),
      ),
    );
  }

  onPressed() {
    String search = searchController.text;
    if(this.min > this.max){
      openDialog('حداقل قیمت نمیتواند از حداکثر قیمت بیشتر باشد.');
    }
    if(this.min > 200000){
      minController.text = '200000';
      this.min = 200000;
    }
    if(this.max > 200000){
      minController.text = '200000';
      this.max = 200000;
    }
    if(this.min < 0){
      minController.text = '0';
      this.min = 0;
    }
    if(this.max < 0){
      maxController.text = '0';
      this.max = 0;
    }
    if (search.trim().length == 0) {
      search = null;
    }
    String faculty = selectedFaculty;
    print('selected faculty: $selectedFaculty');
    int min, max;
    if(minController.text.length != 0 && maxController.text.length != 0){
      min = int.parse(minController.text);
      max = int.parse(maxController.text);
    }

    print('min: $min ,  max: $max');
    // Navigator.pop(context, {'search': search, "faculty": faculty, "min": min, "max": max});
    Map map = {'search': search, "faculty": faculty, "min": min, "max": max};
    Navigator.pop(context, map);
  }
}
