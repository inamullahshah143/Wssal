import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wssal_vender/storeInformation.dart';

import 'functions.dart';

List<File> avatar = [];
var leng;
var userId;
var name;
var email;
var phone;
var paypal_email;
var password;

class UpdateVenderProfile extends StatefulWidget {
  final data;
  UpdateVenderProfile(this.data);

  @override
  _UpdateVenderProfileState createState() => _UpdateVenderProfileState(data);
}

class _UpdateVenderProfileState extends State<UpdateVenderProfile> {
  final data;
  _UpdateVenderProfileState(this.data);

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    paypal_email = data['paypal_email'];
    userId = data['id'];

    print('name = $name');
    print('email = $email');
    print('phone = $phone');
    print('paypal_email = $paypal_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Update Profile",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: width,
                    child: TextFormField(
                      initialValue: '$name',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),

                Container(
                    margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: width,
                    child: TextFormField(
                      initialValue: '$email',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: width,
                    child: TextFormField(
                      initialValue: '$phone',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phone = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: width,
                    child: TextFormField(
                      initialValue: '$paypal_email',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        paypal_email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: 'paypal_email',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),

                Container(
                    margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: width,
                    child: TextFormField(
                      // initialValue: '$paypal_email',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else if (value.length < 8) {
                          return "This field required minimum 10 character";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                InkWell(
                  onTap: () {
                    setState(() {
                      avatar = [];
                    });
                    FilePicker.platform
                        .pickFiles(allowMultiple: false)
                        .then((value) {
                      value.files.forEach((element) async {
                        avatar.add(File(element.path));
                        setState(() {
                          leng = avatar.length;
                          print('$leng');
                        });
                      });
                    });
                    // _showPicker2(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 130,
                    width: 150,
                    child: leng != null
                        ? Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 245, 247, 1),
                              // color: Colors.yellow,
                              borderRadius: BorderRadius.circular(15),
                              // image: Image.file(file)
                            ),
                            height: 130,
                            width: 150,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('You have Selected $leng Files')),
                            // child: Image.file(
                            //   _image1,
                            //   fit: BoxFit.cover,
                            // ),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 130,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Select Avator',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                ),
                                Icon(Icons.camera_alt_outlined,
                                    size: 30,
                                    color: Color.fromRGBO(182, 189, 200, 1)),
                              ],
                            ),
                          ),
                  ),
                ),

//  List<File> avatar = [];
//   var leng;
// var name;
// var email;
// var phone;
// var paypal_email;
// var password;
                InkWell(
                  onTap: () {
                    print({
                      "name": "$name",
                      "email": "$email",
                      "phone": "$phone",
                      "paypal_email": "$paypal_email",
                      'password': '$password',
                      'avatar': avatar,
                    });
                    if (_formKey.currentState.validate()) {
                      if (avatar.isEmpty) {
                        final _snackBar = SnackBar(
                            content: Text('Avatar of User is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else {
                        showAlert(
                          context: context,
                          title: "Your Request is Being Proced ",
                          actions: [
                            AlertAction(
                                text: "Ok ",
                                isDestructiveAction: true,
                                onPressed: () {
                                  updateVenderProfile(context);
                                }),
                          ],
                          cancelable: true,
                        );
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 199, 0, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                    height: 50,
                    width: width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateVenderProfile(context) async {
    MultipartFile x;
    MultipartFile y;
    MultipartFile z;
    avatar.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x = value;
      });
    });

    Timer(Duration(seconds: 1), () async {
      try {
        var formData = FormData.fromMap({
          "_method": "PUT",
          "name": "$name",
          "email": "$email",
          "phone": "$phone",
          'paypal_email': '$paypal_email',
          'password': '$password',
          "avatar": x,
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $stringValue';

        print({
          "name": "$name",
          "email": "$email",
          "phone": "$phone",
          'paypal_email': '$paypal_email',
          'password': '$password',
          "avatar": x,
        });
        var response = await dio.post("$apiBaseURL/vendor/profile/$userId",
            data: formData);
        print("Become Vender: $response");

        var gg = response.data;
        print('${response.data['message']}');
        if (gg['message'] == 'Profile updated successfully') {
          print('Profile updated successfully');
          showAlert(
            context: context,
            title: "Profile updated successfully",
            actions: [
              AlertAction(
                  text: "Ok ",
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => StoreInformation(),
                      ),
                    );
                  }),
            ],
            cancelable: true,
          );
        }
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          print(e.response.data);
          print(e.response.headers);
          // print(e.response.request)
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          // print(e.request);
          print(e.message);
        }
      }
    });
  }
}
