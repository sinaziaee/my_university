import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_university/components/custom_text_field.dart';
import 'package:my_university/constants.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'home_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  // static final String path = "lib/src/pages/settings/settings1.dart";
  static String id = 'settings_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showSpinner = false;
  String token, firstName, lastName, username, email, phone, image;
  int userId;
  Size size;
  FocusNode node;
  File imageFile;
  String userDetailUrl = '$baseUrl/api/account/properties/update';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    firstName = prefs.getString('first_name');
    lastName = prefs.getString('last_name');
    username = prefs.getString('username');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    image = prefs.getString('image');
    userId = prefs.getInt('user_id');
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    print('$baseUrl$image');
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'تنظیمات',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  Map map = {
                    'image': image.toString(),
                  };
                  Navigator.popAndPushNamed(context, HomeScreen.id, arguments: {
                    'first_name': firstName,
                    'last_name': lastName,
                    'username': username,
                    'email': email,
                    'token': token,
                    'user_id': userId,
                    'image': image,
                    'phone': phone,
                  });
                },
              ),
            ],
          ),
          body: FutureBuilder(
            future: getToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: Colors.purple,
                              child: InkWell(
                                onTap: () {
                                  _showSheet();
                                },
                                child: Container(
                                  height: 90,
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Spacer(),
                                      CircleAvatar(
                                        radius: 40,
                                        // backgroundImage: NetworkImage(avatars[0]),
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            (image != null && image.length != 0)
                                                ? NetworkImage(
                                                    '$baseUrl$image',
                                                  )
                                                : AssetImage(
                                                    'assets/images/unkown.png'),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${firstName} ${lastName}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      // Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            Card(
                              elevation: 4.0,
                              margin: const EdgeInsets.fromLTRB(
                                  32.0, 8.0, 32.0, 16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      Icons.phone,
                                      color: Colors.purple,
                                    ),
                                    title: Text(
                                        phone ?? 'شماره ی موبایلی ثبت نشده'),
                                    // trailing: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      //open change password
                                    },
                                  ),
                                  _buildDivider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.email,
                                      color: Colors.purple,
                                    ),
                                    title: Text(
                                      '${email}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    // trailing: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      //open change language
                                    },
                                  ),
                                  _buildDivider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Colors.purple,
                                    ),
                                    title: Text("${username}"),
                                    // trailing: Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      //open change location
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: -20,
                        child: Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 00,
                        left: 00,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.powerOff,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showLogoutDialog(context, "آیا اطمینان دارید ؟");
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/login_bottom.png",
                          width: size.width * 0.6,
                        ),
                      ),
                    ],
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
        onWillPop: () async {
          Navigator.popAndPushNamed(context, HomeScreen.id, arguments: {
            'first_name': firstName,
            'last_name': lastName,
            'username': username,
            'email': email,
            'token': token,
            'user_id': userId,
            'image': image,
            'phone': phone,
          });
          return false;
        });
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  showLogoutDialog(BuildContext context, String message) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: ' خروج از برنامه',
        desc: message,
        btnOkOnPress: () {
          logoutApp();
        },
        btnOkText: "بله",
        btnOkIcon: Icons.check_circle,
        btnOkColor: Colors.green,
        btnCancelOnPress: () {},
        btnCancelText: "خیر",
        btnCancelIcon: Icons.cancel,
        btnCancelColor: Colors.red)
      ..show();
  }

  void logoutApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }

  onSelectImagePressed() {
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
                    textDirection: TextDirection.rtl,
                    style: PersianFonts.Shabnam.copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
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
                      textDirection: TextDirection.rtl,
                      style: PersianFonts.Shabnam.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: kPrimaryColor,
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
                      textDirection: TextDirection.rtl,
                      style: PersianFonts.Shabnam.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.insert_photo,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectFromGallery() {
    _pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    _pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);

      setState(() {
        imageFile = selected;
      });
      Navigator.pop(context);
      _showSheet();
    } catch (e) {
      print(e);
    }
  }

  void _showSheet() {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    phoneController.text = phone;
    usernameController.text = username;
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      context: context,
      builder: (BuildContext context, ScrollController scrollController,
          double bottomSheetOffset) {
        return SafeArea(
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    if (imageFile != null) ...[
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          onTap: onSelectImagePressed,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[200],
                              radius: 80,
                              backgroundImage: FileImage(imageFile),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          onTap: onSelectImagePressed,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[200],
                              radius: 60,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/add_image.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      node: node,
                      controller: phoneController,
                      hintText: 'شماره ی موبایل',
                      iconData: Icons.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      node: node,
                      controller: firstNameController,
                      hintText: 'نام',
                      iconData: Icons.person,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      node: node,
                      controller: lastNameController,
                      hintText: 'نام خانوادگی',
                      iconData: Icons.person,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        validateData();
                      },
                      child: Text(
                        'ذخیره تغییرات',
                        style: PersianFonts.Shabnam.copyWith(
                            color: Colors.white, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      anchors: [0, 0.5, 1],
    );
  }

  validateData() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    if (firstName.length == 0) {
      discuss(context, 'لطفا نام را وارد کنید');
      return;
    }
    if (lastName.length == 0) {
      discuss(context, 'لطفا نام خانوادگی را وارد کنید');
      return;
    }
    if (phone.length == 0) {
      discuss(context, 'لطفا تلفن را وارد کنید');
      return;
    }
    postNewInformation(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        username: username);
  }

  postNewInformation({
    String firstName,
    String lastName,
    String phone,
    String username,
  }) async {
    setState(() {
      showSpinner = true;
    });
    print(userDetailUrl);
    try {
      http.Response response;
      Map map = Map();
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      if (imageFile != null) {
        String base64file = convert.base64Encode(imageFile.readAsBytesSync());
        map['filename'] = imageFile.path.split('/').last;
        map['image'] = base64file;
      }
      if (phone.length != 0) {
        map['mobile_number'] = phone;
      }
      response = await http.post(
        userDetailUrl,
        headers: {
          HttpHeaders.authorizationHeader: token,
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: convert.jsonEncode(map),
      );
      print('***************************');
      print(response.body);
      print('***************************');
      if (response.statusCode < 300) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        Map map = jsonResponse;
        Navigator.pop(context);
        success(context, "ویرایش اطلاعات با موفقیت انجام شد");
        updateUserInformation(phone, firstName, lastName, map['image']);
      } else {
        // print(response.body);
        // Navigator.pop(context);
        discuss(context, "متاسفانه مشکلی پیش آمد.");
      }
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print('myError: $e');
      setState(() {
        showSpinner = false;
      });
      // Navigator.pop(context);
      discuss(context, "متاسفانه مشکلی پیش آمد.");
    }
  }

  updateUserInformation(
      String phone, String firstName, String lastName, image) async {
    print(image);
    print(phone);
    print(firstName);
    print(lastName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
    prefs.setString('first_name', firstName);
    prefs.setString('last_name', lastName);
    prefs.setString('image', image);
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
  }
}
