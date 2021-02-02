import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;
import 'dart:ui' as ui;
import 'package:persian_date/persian_date.dart';
import 'package:shamsi_date/shamsi_date.dart';

String begin_json, end_json;

DateTime begin = DateTime.now();
DateTime end = DateTime.now();
String event_type = "event";
Color mycolor = Colors.white;

class NewEventScreen extends StatefulWidget {
  static String id = 'new_event';

  @override
  _NewEventScreenState createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String postEventUrl = '$baseUrl/api/event/user/';
  Jalali date = Jalali.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //TextEditingController ownership = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String token, selectedBookName;
  int selectedFacultyId, selectedBookId;
  int userId;
  bool showSpinner = false, isAddingCompletelyNewBook = false;
  String base64Image;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  File imageFile;

  int index = 0;

  // working on selecting and cropping images ****************************************************

  Future<void> _pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);

      setState(() {
        imageFile = selected;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage() async {
    try {
      File cropped = await ImageCropper.cropImage(
        cropStyle: CropStyle.rectangle,
        sourcePath: imageFile.path,
      );

      setState(() {
        imageFile = cropped ?? imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  void _clear() {
    setState(() {
      imageFile = null;
    });
  }

  _showEventTypesDialog() {
    return showDialog(
        context: context,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  //ListView.builder(
                  InkWell(
                    onTap: () {
                      setState(() {
                        event_type = "حضوری";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'حضوری',
                              textDirection: ui.TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      setState(() {
                        event_type = "آنلاین";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        'آنلاین',
                        textDirection: ui.TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      //),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // *********************************************************************************************
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.purple.shade300,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple.shade300,
            elevation: 0,
            title: Text(
              'ثبت رویداد جدید',
              textDirection: ui.TextDirection.rtl,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            color: Colors.purple.shade300,
            margin: EdgeInsets.only(top: 20),
            child: FutureBuilder(
              future: getToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ModalProgressHUD(
                    inAsyncCall: showSpinner,
                    color: Colors.purple.shade200,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfffff8ee),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        // decoration: BoxDecoration(boxShadow: [
                                        //   BoxShadow(
                                        //     color: mycolor,
                                        //     spreadRadius: 5,
                                        //     blurRadius: 10,
                                        //     offset: Offset(0, 3),
                                        //   )
                                        // ]),
                                        height: 40,
                                        width: 200,
                                        child: TextField(
                                          textDirection: ui.TextDirection.rtl,
                                          controller: nameController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 20),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'نام رویداد  :  ',
                                        textDirection: ui.TextDirection.rtl,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: mycolor,
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                        height: 40,
                                        width: 150,
                                        child: TextField(
                                          textDirection: ui.TextDirection.rtl,
                                          controller: location,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 20),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'محل برگزاری  :  ',
                                        textDirection: ui.TextDirection.rtl,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: Text(
                                    ' : عکس رویداد',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'انتخاب عکس : ',
                                                textDirection:
                                                    ui.TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 0.5,
                                          width: double.infinity,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            selectFromCamera();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'از دوربین‌',
                                                  textDirection:
                                                      ui.TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.purple),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.purple,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            selectFromGallery();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'از گالری',
                                                  textDirection:
                                                      ui.TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.purple),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  Icons.insert_photo,
                                                  color: Colors.purple,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  height: (imageFile != null) ? 150 : 100,
                                  width: (imageFile != null) ? 150 : 100,
                                  child: Column(
                                    children: [
                                      if (imageFile != null) ...[
                                        Image.file(
                                          imageFile,
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        // Uploader(file: _imageFile),
                                      ] else ...[
                                        Image(
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/add_image.png'),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            if (imageFile != null) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FlatButton(
                                    onPressed: _cropImage,
                                    child: Icon(Icons.crop),
                                  ),
                                  FlatButton(
                                    onPressed: _clear,
                                    child: Icon(Icons.refresh),
                                  ),
                                ],
                              ),
                            ] else ...[
                              SizedBox(),
                            ],

                            // SizedBox(
                            //   height: 20,
                            // ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            if (isAddingCompletelyNewBook == false)
                              ...[]
                            else ...[
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],

                            SizedBox(
                              height: 20,
                            ),

                            //description
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: Text(
                                    ' : توضیحات',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //description
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: mycolor,
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                  offset: Offset(0, 3),
                                )
                              ]),
                              height: 100,
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: TextField(
                                textDirection: ui.TextDirection.rtl,
                                maxLines: 40,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //price
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: mycolor,
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                        height: 40,
                                        width: 100,
                                        child: TextField(
                                          //textDirection: ui.TextDirection.rtl,
                                          controller: priceController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 20),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'قیمت :   ',
                                        textDirection: ui.TextDirection.rtl,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'زمان شروع رویداد :   ',
                                    textDirection: ui.TextDirection.rtl,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                        Text(begin_json ?? 'زمان شروع رویداد',
                                            style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 15,
                                              //fontWeight: 5,
                                            )),
                                    onPressed: () {
                                      // showPickerDateCustom(context , true);
                                      showCalendarDialog1();
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'زمان پایان رویداد :   ',
                                    textDirection: ui.TextDirection.rtl,
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(end_json ?? 'زمان پایان رویداد',
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 15,
                                          //fontWeight: 5,
                                        )),
                                    onPressed: () {
                                      // showPickerDateCustom(context , false);
                                      showCalendarDialog2();
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: mycolor,
                                            spreadRadius: 5,
                                            blurRadius: 15,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                        height: 40,
                                        width: 100,
                                        child: TextField(
                                          controller: capacity,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(bottom: 20),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'ظرفیت :   ',
                                        textDirection: ui.TextDirection.rtl,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300],
                                        ),
                                        margin: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              _showEventTypesDialog();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 30,
                                                  left: 10,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Container(
                                                // color: Colors.grey[300],
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(Icons.arrow_drop_down),
                                                    Text(
                                                        event_type ??
                                                            'گزینه ای انتخاب نشده',
                                                        style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontSize: 15,
                                                          //fontWeight: 5,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ' : نوع برگزاری',
                                        //textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                margin: EdgeInsets.only(left: 100, right: 100),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FlatButton(
                                        height: 20,
                                        minWidth: 20,
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onPressed: () {
                                          validateData();
                                          // postNewBook();
                                        },
                                        child: Text(
                                          'ثبت',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        color: Colors.purple.shade400,
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: SizedBox(),
                                    // ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  validateData() {
    if (nameController.text.length == 0) {
      _showDialog(context, 'نام رویداد را اضافه کنید !');
      return;
    }

    if (location.text.length == 0) {
      _showDialog(context, 'محل برگزاری رویداد را اضافه کنید !');
      return;
    }

    if (capacity.text.length == 0) {
      _showDialog(context, 'ظرفیت رویداد را اضافه کنید !');
      return;
    }

    if (priceController.text.length == 0) {
      _showDialog(context, 'هزینه شرکت در رویداد را اضافه کنید !');
      return;
    }

    if (descriptionController.text.length == 0) {
      _showDialog(context, 'توضیحات رویداد را اضافه کنید !');
      return;
    }

    if (begin == DateTime.now()) {
      _showDialog(context, 'زمان شروع را مشخص کنید !');
      return;
    }

    if (end == DateTime.now()) {
      _showDialog(context, 'زمان پایان را مشخص کنید !');
      return;
    }

    if (event_type == "event") {
      _showDialog(context, 'نوع برگزاری را مشخص کنید !');
      return;
    }

    postNewEvent();
  }

  postNewEvent() async {
    setState(() {
      showSpinner = true;
    });

    try {
      http.Response response;

      if (imageFile != null && imageFile.uri != null) {
        String base64file = convert.base64Encode(imageFile.readAsBytesSync());

        print("here if !!!!");
        //String t1 = jsonEncode(begin);
        //String t2 = jsonEncode(end);

        response = await http.post(
          postEventUrl,
          headers: {
            HttpHeaders.authorizationHeader: token,
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: convert.json.encode({
            'name': nameController.text,
            'cost': int.parse(priceController.text),
            'capacity': int.parse(capacity.text),
            'hold_type': event_type,
            'start_time': begin_json.toString(),
            'end_time': end_json.toString(),
            'location': location.text,
            'description': descriptionController.text,
            'filename': imageFile.path.split('/').last,
            'image': base64file,
          }),
        );
      } else {
        print("Im here Else !!!!");

        //String t1 = jsonEncode(begin);
        //String t2 = jsonEncode(end);
        print("begin_json : $begin_json");
        print("end_json : $end_json");

        response = await http.post(
          postEventUrl,
          headers: {
            HttpHeaders.authorizationHeader: token,
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: convert.json.encode({
            'name': nameController.text,
            'cost': int.parse(priceController.text),
            'capacity': int.parse(capacity.text),
            //'Organizer': organizerController,
            'hold_type': event_type,
            'start_time': begin_json.toString(),
            'end_time': end_json.toString(),
            'location': location.text,
            'description': descriptionController.text,
          }),
        );
      }

      print(response.body);
      print(response.statusCode);

      if (response.statusCode >= 400) {
        print(response.body);
        _showDialog(context, "متاسفانه مشکلی پیش آمد.");
      } else {
        success(context, "رویداد اضافه شد");
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print('myError: $e');
      setState(() {
        showSpinner = false;
      });
    }
  }

  _showDialog(BuildContext context, String title) async{
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطا',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)..show();
  }

  success(BuildContext context, String title) async{
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'موفقیت',
        desc: title,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.green)..show();
  }

  selectFromGallery() {
    _pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    _pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  void showCalendarDialog1() {
    String dateToShow = '${date.year}/${date.month}/${date.day}';
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          // initial: '1399/12/20 19:50',
          // initial: '1399/12/20',
          type: 'datetime',
          initial: dateToShow,
          color: kPrimaryColor,
          onSelect: (date) {
            print(date);
            List times = date.toString().split('/');
            int year = int.parse(times[0]);
            int month = int.parse(times[1]);
            int day = int.parse(times[2]);
            Jalali j = Jalali(year, month, day);
            this.date = j;
            Gregorian g = j.toGregorian();
            selectedDate1 = g.toDateTime();
            print(selectedDate1);
            setState(() {});
          },
        );
      },
    );
  }

  void showCalendarDialog2() {
    String dateToShow = '${date.year}/${date.month}/${date.day}';
    showDialog(
      context: context,
      builder: (BuildContext _) {
        return PersianDateTimePicker(
          // initial: '1399/12/20 19:50',
          // initial: '1399/12/20',
          type: 'datetime',
          initial: dateToShow,
          color: kPrimaryColor,
          onSelect: (date) {
            print(date);
            List times = date.toString().split('/');
            int year = int.parse(times[0]);
            int month = int.parse(times[1]);
            int day = int.parse(times[2]);
            Jalali j = Jalali(year, month, day);
            this.date = j;
            Gregorian g = j.toGregorian();
            selectedDate2 = g.toDateTime();
            print(selectedDate2);
            setState(() {});
          },
        );
      },
    );
  }

}
