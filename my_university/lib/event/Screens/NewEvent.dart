import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert' as convert;

class NewEvent extends StatefulWidget {
  static String id = 'new_event';

  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String postStockUrl = '$baseUrl/api/bookbse/stocks/';
  String bookUrl = '$baseUrl/api/bookbse/books/?bookID=0';
  String facultiesUrl = '$baseUrl/api/bookbse/faculties';
  String newBookUrl = '$baseUrl/api/bookbse/books/';
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String selectedFaculty, token, selectedBookName;
  int selectedFacultyId, selectedBookId;
  int userId;
  bool showSpinner = false, isAddingCompletelyNewBook = false;
  String base64Image;

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

  // *********************************************************************************************
  @override
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
              'ثبت رویداد جدید',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: kPrimaryColor ,
                fontSize: 25,
              ),
            ),

            elevation: 1,
            backgroundColor: Colors.white,
            centerTitle: true,
          ),


          body: FutureBuilder(
              future: getToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return ModalProgressHUD(
                    inAsyncCall: showSpinner,
                    color: Colors.purple.shade200,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(
                              height: 20,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: Text(
                                    'عکس رویداد',
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
                                                TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.grey[800]),
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
                                                  TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey[800],
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
                                                  TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Icon(
                                                  Icons.insert_photo,
                                                  color: Colors.grey[800],
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
                                  height: 200,
                                  width: 200,
                                  child: ListView(
                                    children: [
                                      if (imageFile != null) ...[
                                        Image.file(
                                          imageFile,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        // Uploader(file: _imageFile),
                                      ] else ...[
                                        Image(
                                          width: 200,
                                          height: 200,
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
                            ]

                            else ...[
                              SizedBox(),
                            ],

                            SizedBox(
                              height: 20,
                            ),


                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                ],
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

                              Container(
                                height: 45,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: TextField(
                                  textDirection: TextDirection.rtl,
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Container(
                                height: 45,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: TextField(
                                  textDirection: TextDirection.rtl,
                                  controller: publisherController,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'نام ناشر',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Container(
                                height: 45,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: TextField(
                                  textDirection: TextDirection.rtl,
                                  controller: authorController,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'نام نویسنده',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),


                              SizedBox(
                                height: 30,
                              ),


                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                              ),
                            ],

                            SizedBox(
                              height: 20,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: Text(
                                    'توضیحات',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  boxShadow : [
                                    BoxShadow(
                                      color: Colors.blueAccent.shade100,
                                      spreadRadius: 5,
                                      blurRadius: 15,
                                      //offset: Offset(0, 7),
                                    )
                                  ]
                              ),
                              height: 100,
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: TextField(
                                textDirection: TextDirection.rtl,
                                maxLines: 40,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 100,
                                    child: TextField(
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'قیمت :   ',
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 30,
                            ),


                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: FlatButton(
                                      padding:
                                      EdgeInsets.only(top: 5, bottom: 5),
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
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
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
                  );
                }

                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }));
    });
  }

  validateData() {
    String book_name = nameController.text;
    String book_description = descriptionController.text;


    postNewBook();

  }

  @override
  Future<Map<String, dynamic>> sendFiletodjango({
    File file,
  }) async {
    var endPoint = postStockUrl;
    Map data = {};
    String base64file = convert.base64Encode(file.readAsBytesSync());
    // String fileName = file.path.split("/").last;
    // data['name'] = fileName;
    data['image'] = base64file;
    data['book'] = 2;
    data['filename'] = 'sina';
    data['price'] = 20000;
    data['edition'] = 0;
    data['printno'] = 0;
    data['description'] = 'descriptionController.text';
    data['seller'] = 1;
    // print(data);
    try {
      http.Response response = await http.post(endPoint,
          headers: {
            HttpHeaders.authorizationHeader: token,
            "content-type": "application/json",
          },
          body: convert.json.encode(data));
      print(response.body);
    } catch (e) {
      throw (e.toString());
    }
  }



  postNewBook() async {
    setState(() {
      showSpinner = true;
    });
    try {
      if (isAddingCompletelyNewBook) {
        http.Response httpResponse = await http.post(newBookUrl,
            headers: {
              HttpHeaders.authorizationHeader: token,
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: convert.jsonEncode(
              {
                'name': nameController.text,
                'author': authorController.text,
                'publisher': publisherController.text,
                'faculty': selectedFacultyId,
                'field': 1,
              },
            ));
        if (httpResponse.statusCode == 201) {
          Map jsonBody = convert.jsonDecode(httpResponse.body);
          selectedBookId = jsonBody['id'];
        }
      }
      http.Response response;
      if (imageFile.uri != null) {
        String base64file = convert.base64Encode(imageFile.readAsBytesSync());

        response = await http.post(
          postStockUrl,
          headers: {
            HttpHeaders.authorizationHeader: token,
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: convert.json.encode({
            'book': selectedBookId,
            'price': int.parse(priceController.text),
            'edition': 0,
            'printno': 0,
            'filename': imageFile.path.split('/').last,
            'image': base64file,
            'description': descriptionController.text,
            'seller': userId,
          }),
        );
      } else {
        response = await http.post(
          postStockUrl,
          headers: {
            HttpHeaders.authorizationHeader: token,
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: convert.json.encode({
            'book': selectedBookId,
            'price': int.parse(priceController.text),
            'edition': 0,
            'printno': 0,
            'description': descriptionController.text,
            'seller': userId,
          }),
        );
      }

      if (response.statusCode == 201) {
        _showDialog(context, "کتاب اضافه شد");
      } else {
        print(response.body);
        _showDialog(context, "متاسفانه مشکلی پیش آمد.");
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

  _showDialog(BuildContext context, String message) {
    // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    AlertDialog dialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 20),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '!باشه',
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, child: dialog);
  }

  selectFromGallery() {
    _pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    _pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  _showBooksDialog() async {
    http.Response response = await http
        .get(bookUrl, headers: {HttpHeaders.authorizationHeader: token});
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
            child: Text('کتابی وجود ندارد'),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedBookId = mapList[index]['id'];
                          isAddingCompletelyNewBook = false;
                          setState(() {
                            selectedBookName = mapList[index]['name'];
                            nameController.text = selectedBookName;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                mapList[index]['name'],
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                mapList[index]['author'],
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _newBookDialog();
                    },
                    icon: Icon(Icons.add),
                    label: Text('اضافه کردن کتاب جدید'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  _newBookDialog() {
    Navigator.pop(context);
    setState(() {
      isAddingCompletelyNewBook = true;
    });
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
                    selectedFacultyId = mapList[index]['id'];
                    setState(() {
                      selectedFaculty = mapList[index]['name'];
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

  onPressed(String name) {
    setState(() {
      selectedFaculty = name;
    });
    print(name);
    Navigator.pop(context);
  }
}
