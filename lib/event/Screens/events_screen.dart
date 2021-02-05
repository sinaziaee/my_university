import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'dart:convert' as convert;
import 'dart:ui' as ui;
import 'package:shamsi_date/shamsi_date.dart';
import '../../constants.dart';
import 'event_details_screen.dart';

String begin_json, end_json;

DateTime begin = DateTime.now();
DateTime end = DateTime.now();
String eventType;
Color myColor = Colors.white;

class AllEventsScreen extends StatefulWidget {
  static String id = 'all_events_screen';

  @override
  _AllEventsScreenState createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen>
    with TickerProviderStateMixin {
  String eventsUrl = '$baseUrl/api/event/user/all/',
      token,
      eventDemandUrl = '$baseUrl/api/event/user/register/',
      myEventsUrl = '$baseUrl/api/event/user/register/',
      cultureDeputiesUrl = '$baseUrl/api/event/user/culture-deputies/';
  CardController controller; //Use this to trigger swap.
  Map args;
  int _page = 0;

  //******************************************************************************************************//
  String postEventUrl = '$baseUrl/api/event/user/';
  Jalali date = Jalali.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String cultureDeputy;
  int cultureDeputyId;

  //TextEditingController ownership = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String selectedBookName;
  int selectedFacultyId, selectedBookId;
  int userId;
  bool showSpinner = false, isAddingCompletelyNewBook = false;
  String base64Image;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  File imageFile;
  int index = 0;

  String pageTitle = 'سامانه رویدادها';

  //******************************************************************************************************//

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    token = args['token'];
    print(token);
    userId = args['user_id'];
    return Scaffold(
      // backgroundColor: Colors.blueGrey[200],
      backgroundColor: Colors.purple.shade300,
      appBar: AppBar(
        // backgroundColor: Colors.blueGrey[200],
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          pageTitle,
          textDirection: TextDirection.rtl,
          style: PersianFonts.Shabnam.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.event_available,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.event_busy_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          // Icon(Icons.call_split, size: 30),
          // Icon(Icons.perm_identity, size: 30),
        ],
        // color: Colors.blueGrey[200],
        color: Colors.purple.shade300,
        // buttonBackgroundColor: Colors.blueGrey[200],
        buttonBackgroundColor: Colors.purple.shade300,
        backgroundColor: Color(0xfffff8ee),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    if (_page == 0) {
      return availablePage();
    } else if (_page == 1) {
      return myEventsPage();
    } else {
      return addPage();
    }
  }

  Widget addPage() {
    return Container(
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
                        height: 40,
                        width: 200,
                        child: TextField(
                          textDirection: ui.TextDirection.rtl,
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: kBorderSideInActive,
                            focusedBorder: kBorderSideActive,
                          ),
                        ),
                      ),
                      Text(
                        'نام رویداد  :  ',
                        textDirection: ui.TextDirection.rtl,
                        style: PersianFonts.Shabnam.copyWith(
                          color: kPrimaryColor,
                          fontSize: 20,
                        ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        child: TextField(
                          textDirection: ui.TextDirection.rtl,
                          minLines: 3,
                          maxLines: 5,
                          controller: location,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            enabledBorder: kBorderSideInActive,
                            focusedBorder: kBorderSideActive,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          'محل برگزاری  :  ',
                          textDirection: ui.TextDirection.rtl,
                          style: PersianFonts.Shabnam.copyWith(
                            color: kPrimaryColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    ' : عکس رویداد',
                    style: PersianFonts.Shabnam.copyWith(
                      color: kPrimaryColor,
                      fontSize: 20,
                    ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'انتخاب عکس : ',
                                textDirection: ui.TextDirection.rtl,
                                style: TextStyle(color: Colors.black),
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'از دوربین‌',
                                  textDirection: ui.TextDirection.rtl,
                                  style: TextStyle(color: Colors.purple),
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'از گالری',
                                  textDirection: ui.TextDirection.rtl,
                                  style: TextStyle(color: Colors.purple),
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
                  // height: (imageFile != null) ? 200 : 100,
                  width: (imageFile != null) ? 300 : 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (imageFile != null) ...[
                        Image.file(
                          imageFile,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        // Uploader(file: _imageFile),
                      ] else ...[
                        Image(
                          width: 200,
                          height: 100,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/add_image.png'),
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
                    style: PersianFonts.Shabnam.copyWith(
                      color: kPrimaryColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                textDirection: ui.TextDirection.rtl,
                maxLines: 40,
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: kBorderSideInActive,
                  focusedBorder: kBorderSideActive,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        child: TextField(
                          //textDirection: ui.TextDirection.rtl,
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: kBorderSideInActive,
                            focusedBorder: kBorderSideActive,
                          ),
                        ),
                      ),
                      Text(
                        'قیمت :   ',
                        textDirection: ui.TextDirection.rtl,
                        style: PersianFonts.Shabnam.copyWith(
                          color: kPrimaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'زمان شروع رویداد :   ',
                    textDirection: ui.TextDirection.rtl,
                    style: PersianFonts.Shabnam.copyWith(
                      color: kPrimaryColor,
                      fontSize: 20,
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                        (begin_json != null) ? changeDateTimeToShamsi(begin_json) : 'زمان شروع رویداد',
                      style: PersianFonts.Shabnam.copyWith(
                        color: kPrimaryColor,
                        fontSize: 15,
                      ),
                    ),
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
                    style: PersianFonts.Shabnam.copyWith(
                      color: kPrimaryColor,
                      fontSize: 20,
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text((end_json != null) ? changeDateTimeToShamsi(end_json) : 'زمان پایان رویداد',
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
                        height: 40,
                        width: 100,
                        child: TextField(
                          controller: capacity,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: kBorderSideInActive,
                            focusedBorder: kBorderSideActive,
                          ),
                        ),
                      ),
                      Text(
                        'ظرفیت :   ',
                        textDirection: ui.TextDirection.rtl,
                        style: PersianFonts.Shabnam.copyWith(
                          color: kPrimaryColor,
                          fontSize: 20,
                        ),
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
                          borderRadius: BorderRadius.circular(10),
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
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              _showEventTypesDialog();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: 30, left: 10, top: 10, bottom: 10),
                              child: Container(
                                // color: Colors.grey[300],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.arrow_drop_down),
                                    Text(
                                      eventType ?? 'انتخاب نشده',
                                      style: PersianFonts.Shabnam.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
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
                        style: PersianFonts.Shabnam.copyWith(
                          color: kPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ارسال به معاونت فرهنگی',
                        //textDirection: TextDirection.rtl,
                        style: PersianFonts.Shabnam.copyWith(
                          color: kPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              _showCultureDeputySelectionDialog();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  right: 30, left: 10, top: 10, bottom: 10),
                              child: Container(
                                // color: Colors.grey[300],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.arrow_drop_down),
                                    Spacer(),
                                    Text(
                                      cultureDeputy ?? 'انتخاب نشده',
                                      textAlign: TextAlign.center,
                                      style: PersianFonts.Shabnam.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  FlatButton(
                    height: 20,
                    minWidth: 20,
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 50,
                      right: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                  // Expanded(
                  //   flex: 1,
                  //   child: SizedBox(),
                  // ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget myEventsPage() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffff8ee),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            http.Response response = snapshot.data;
            if (response.statusCode >= 400) {
              print(response.statusCode);
              print(response.body);
              try {
                String jsonResponse =
                    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
                if (jsonResponse.startsWith('ERROR: You haven\'t been')) {
                  return errorWidget('شما به عنوان ارشد دانشکده انتخاب نشدید.');
                } else {
                  return errorWidget('sth else');
                }
              } catch (e) {
                print(e);
                return errorWidget('مشکلی درارتباط با سرور پیش آمد');
              }
            }
            var jsonResponse =
                convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
            print(jsonResponse);
            List<Map> mapList = [];
            int eventCount = 0;
            for (Map map in jsonResponse) {
              eventCount++;
              mapList.add(map);
            }
            if (eventCount == 0) {
              return errorWidget('رویدادی وجود ندارد.');
            }
            return Stack(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: TinderSwapCard(
                      swipeUp: true,
                      swipeDown: true,
                      orientation: AmassOrientation.BOTTOM,
                      totalNum: eventCount,
                      stackNum: 5,
                      swipeEdge: 4.0,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.width,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      minHeight: MediaQuery.of(context).size.width * 0.8,
                      cardBuilder: (context, index) => Card(
                        // color: Colors.blueGrey[200],
                        color: Colors.purple.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            navigateToEventDetailScreen(
                                mapList[index]['event_id']);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: PhysicalModel(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeInImage(
                                    height: 200,
                                    width: 300,
                                    placeholder:
                                        AssetImage('assets/images/elmos.png'),
                                    image: NetworkImage(
                                      '$baseUrl${mapList[index]['image']}',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  mapList[index]['name'],
                                  textAlign: TextAlign.end,
                                  style: PersianFonts.Shabnam.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'از ${changeTimeToShamsi(
                                    mapList[index]['start_time']
                                        .toString()
                                        .substring(0, 10),
                                  )} تا ${changeTimeToShamsi(
                                    mapList[index]['end_time']
                                        .toString()
                                        .substring(0, 10),
                                  )}',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                  style: PersianFonts.Shabnam.copyWith(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  tryingToParticipate(
                                      false, mapList[index]['event_id']);
                                  controller.triggerLeft();
                                },
                                padding: EdgeInsets.symmetric(
                                    horizontal: 19, vertical: 10),
                                child: Text(
                                  ' شرکت نمیکنم',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      cardController: controller = CardController(),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        /// Get swiping card's alignment
                        if (align.x < 0) {
                          //Card is LEFT swiping
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        /// Get orientation & index of swiped card!
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'رویداد های من',
                        style: PersianFonts.Shabnam.copyWith(
                            color: Colors.black, fontSize: 20),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: SpinKitWave(
                color: kPrimaryColor,
              ),
            );
          }
        },
        future: http.get(
          '$myEventsUrl',
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
      ),
    );
  }

  changeDateTimeToShamsi(String time) {
    String hourMin = time.substring(11, time.length);
    time = time.substring(0,10);
    String timeToShow = '';
    List<String> times = time.split('-');
    print(times);
    Gregorian g = Gregorian(int.parse(times[0].toString()),
        int.parse(times[1].toString()), int.parse(times[2].toString()));
    Jalali j = g.toJalali();
    print(j);
    timeToShow =
    '${int.parse(j.year.toString())}-${int.parse(j.month.toString())}-${int.parse(
      j.day.toString(),
    )}';
    print('timeToShow ' + timeToShow);
    String tel = replaceFarsiNumber(timeToShow + ' ' + hourMin);
    print('----- $tel');
    return tel;
  }

  changeTimeToShamsi(String time) {
    String timeToShow = '';
    List<String> times = time.split('-');
    print(times);
    Gregorian g = Gregorian(int.parse(times[0].toString()),
        int.parse(times[1].toString()), int.parse(times[2].toString()));
    Jalali j = g.toJalali();
    print(j);
    timeToShow =
        '${int.parse(j.year.toString())}-${int.parse(j.month.toString())}-${int.parse(
      j.day.toString(),
    )}';
    print('timeToShow ' + timeToShow);
    String tel = replaceFarsiNumber(timeToShow);
    print('----- $tel');
    return tel;
  }

  Widget availablePage() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffff8ee),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            http.Response response = snapshot.data;
            if (response.statusCode >= 400) {
              print(response.statusCode);
              print(response.body);
              try {
                String jsonResponse =
                    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
                if (jsonResponse.startsWith('ERROR: You haven\'t been')) {
                  return errorWidget('شما به عنوان ارشد دانشکده انتخاب نشدید.');
                } else {
                  return errorWidget('sth else');
                }
              } catch (e) {
                print(e);
                return errorWidget('مشکلی درارتباط با سرور پیش آمد');
              }
            }
            var jsonResponse =
                convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
            List<Map> mapList = [];
            int eventCount = 0;
            for (Map map in jsonResponse) {
              eventCount++;
              mapList.add(map);
            }
            if (eventCount == 0) {
              return errorWidget('رویدادی وجود ندارد.');
            }
            return Stack(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: TinderSwapCard(
                      swipeUp: true,
                      swipeDown: true,
                      orientation: AmassOrientation.BOTTOM,
                      totalNum: eventCount,
                      stackNum: 5,
                      swipeEdge: 4.0,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.width,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      minHeight: MediaQuery.of(context).size.width * 0.8,
                      cardBuilder: (context, index) => Card(
                        // color: Colors.blueGrey[200],
                        color: Colors.purple.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            navigateToEventDetailScreen(
                                mapList[index]['event_id']);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: PhysicalModel(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeInImage(
                                    height: 200,
                                    width: 300,
                                    placeholder:
                                        AssetImage('assets/images/elmos.png'),
                                    image: NetworkImage(
                                      '$baseUrl${mapList[index]['image']}',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  mapList[index]['name'],
                                  textAlign: TextAlign.end,
                                  style: PersianFonts.Shabnam.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'از ${changeTimeToShamsi(mapList[index]['start_time'].toString().substring(0, 10))} تا ${changeTimeToShamsi(
                                    mapList[index]['end_time']
                                        .toString()
                                        .substring(0, 10),
                                  )}',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                  style: PersianFonts.Shabnam.copyWith(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Spacer(),
                                  FlatButton(
                                    onPressed: () {
                                      // tryingToParticipate(false, mapList[index]);
                                      controller.triggerLeft();
                                    },
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 10),
                                    child: Text(
                                      ' شرکت نمیکنم',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Spacer(),
                                  FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    onPressed: () {
                                      tryingToParticipate(
                                          true, mapList[index]['event_id']);
                                      controller.triggerRight();
                                    },
                                    child: Text(
                                      'شرکت میکنم',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    color: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      cardController: controller = CardController(),
                      swipeUpdateCallback:
                          (DragUpdateDetails details, Alignment align) {
                        /// Get swiping card's alignment
                        if (align.x < 0) {
                          //Card is LEFT swiping
                        } else if (align.x > 0) {
                          //Card is RIGHT swiping
                        }
                      },
                      swipeCompleteCallback:
                          (CardSwipeOrientation orientation, int index) {
                        /// Get orientation & index of swiped card!
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'رویداد های موجود',
                        style: PersianFonts.Shabnam.copyWith(
                            color: Colors.black, fontSize: 20),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: SpinKitWave(
                color: kPrimaryColor,
              ),
            );
          }
        },
        future: http.get(
          '$eventsUrl',
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ),
      ),
    );
  }

  Widget errorWidget(String message) {
    return Center(
      child: Container(
        child: Text(
          message,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void tryingToParticipate(bool isParticipating, eventId) async {
    print('here : $isParticipating');
    print('event_id: $eventId');
    print(eventDemandUrl);
    Map map = Map();
    map['event_id'] = eventId;
    map['register'] = (isParticipating).toString();
    http.Response response = await http
        .post(eventDemandUrl, body: convert.json.encode(map), headers: {
      HttpHeaders.authorizationHeader: token,
      "Accept": "application/json",
      "content-type": "application/json",
    });
    if (response.statusCode >= 400) {
      print(response.statusCode);
      print(response.body);
      discuss(context, 'مشکلی پیش آمد');
      setState(() {});
    } else {
      success(context, isParticipating
          ? 'شما در رویداد ثبت نام شدید'
          : 'ثبت نام شما لغو شد');
      setState(() {});
    }
  }

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
                        eventType = "حضوری";
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
                        eventType = "آنلاین";
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

  validateData() {
    if (nameController.text.length == 0) {
      discuss(context, 'نام رویداد را اضافه کنید !');
      return;
    }

    if (location.text.length == 0) {
      discuss(context, 'محل برگزاری رویداد را اضافه کنید !');
      return;
    }

    if (capacity.text.length == 0) {
      discuss(context, 'ظرفیت رویداد را اضافه کنید !');
      return;
    }

    if (priceController.text.length == 0) {
      discuss(context, 'هزینه شرکت در رویداد را اضافه کنید !');
      return;
    }

    if (descriptionController.text.length == 0) {
      discuss(context, 'توضیحات رویداد را اضافه کنید !');
      return;
    }

    if (begin == DateTime.now()) {
      discuss(context, 'زمان شروع را مشخص کنید !');
      return;
    }

    if (end == DateTime.now()) {
      discuss(context, 'زمان پایان را مشخص کنید !');
      return;
    }

    if (eventType == null) {
      discuss(context, 'نوع برگزاری را مشخص کنید !');
      return;
    }

    if (cultureDeputyId == null) {
      discuss(context, 'لطفا معاونت آموزشی مقصد را انتخاب کنید !');
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
            'hold_type': eventType,
            'culture_deputy_id': cultureDeputyId,
            'start_time': '${begin_json.toString()}:00',
            'end_time': '${end_json.toString()}:00',
            'location': location.text,
            'description': descriptionController.text,
            'filename': imageFile.path.split('/').last,
            'image': base64file,
          }),
        );
      } else {
        print("Im here Else !!!!");
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
            'hold_type': eventType,
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
        print('================================================');
        print(response.body);
        print('================================================');
        discuss(context, "متاسفانه مشکلی پیش آمد.");
      } else {
        success(context, "رویداد به کارتابل معاونت مربوطه فرستاده شد");
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
            List dateTime = date.split(' ');
            List times = dateTime[0].toString().split('/');
            int year = int.parse(times[0]);
            int month = int.parse(times[1]);
            int day = int.parse(times[2]);
            Jalali j = Jalali(year, month, day);
            this.date = j;
            Gregorian g = j.toGregorian();
            selectedDate1 = g.toDateTime();
            begin_json = selectedDate1.toString().substring(0,10) + ' ' + dateTime[1];
            // print(selectedDate1);
            print('---- $begin_json');
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
          type: 'datetime',
          initial: dateToShow,
          color: kPrimaryColor,
          onSelect: (date) {
            print(date);
            List dateTime = date.split(' ');
            List times = dateTime[0].toString().split('/');
            int year = int.parse(times[0]);
            int month = int.parse(times[1]);
            int day = int.parse(times[2]);
            Jalali j = Jalali(year, month, day);
            this.date = j;
            Gregorian g = j.toGregorian();
            print('------ $g');
            selectedDate2 = g.toDateTime();
            end_json = selectedDate2.toString().substring(0,10) + ' ' + dateTime[1];
            print('---- $end_json');
            setState(() {});
          },
        );
      },
    );
  }

  void navigateToEventDetailScreen(int eventId) {
    Navigator.pushNamed(context, EventDetailsScreen.id, arguments: {
      'event_id': eventId,
      'token': token,
      'user_id': userId,
    });
  }

  void _showCultureDeputySelectionDialog() async {
    print('11111111111111111111111111111111111');
    http.Response response = await http.get(cultureDeputiesUrl,
        headers: {HttpHeaders.authorizationHeader: token});
    print(response.body);
    var jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print('==================================================================================================================');
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
            child: Text('معاونت فرهنگی وجود ندارد'),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            height: 400,
            width: 250,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, index) {
                return Container(
                  width: 230,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.purple.shade200,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        cultureDeputyId = mapList[index]['id'];
                        setState(() {
                          cultureDeputy = mapList[index]['faculty'];
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              '${mapList[index]['first_name']} ${mapList[index]['last_name']}',
                              textAlign: TextAlign.center,
                              style: PersianFonts.Shabnam.copyWith(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'معاونت فرهنگی ${mapList[index]['faculty']}',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: PersianFonts.Shabnam.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
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
}
