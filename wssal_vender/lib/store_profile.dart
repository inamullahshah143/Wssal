import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'home.dart';
import 'functions.dart';
import 'login_page.dart';

class StoreProfile extends StatefulWidget {
  final tokenUser;
  StoreProfile(this.tokenUser);

  @override
  _StoreProfileState createState() => _StoreProfileState(tokenUser);
}

class _StoreProfileState extends State<StoreProfile> {
  final tokenUser;
  _StoreProfileState(this.tokenUser);
  final _formKey = GlobalKey<FormState>();
  List<File> multifile = [];
  List<File> coverfile = [];
  List<File> logfile = [];
  var len;
  var len1;
  var len2;
  var latitude1;
  var longitude1;

  Set<Marker> markers = {};

  String firstname;
  String lastname;
  String shopName;
  var shoplatitude;
  var shoplongitude;
  String comments;
  String shopdescription;
  String shopAddress;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shopaddressController = TextEditingController();
  TextEditingController shopdescriptionController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController buisnessCategoryController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController documentsController = TextEditingController();
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(milliseconds: 500),
    //     (Timer t) => _getlocation());

    _getlocation();
    // getUserLocations();
  }

  _getlocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        latitude1 = value.latitude;
        longitude1 = value.longitude;

        print('latitude mine : $latitude1');
        print('longitude mine: $longitude1');
      });
    });
  }

  Future<LocationData> getuserLocation() async {
    Location location = Location();
    return location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 85),
                  child: Text(
                    'Store Profile',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Text(
                    'Your phone number +201003456789',
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 45, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    width: width,
                    child: TextFormField(
                      controller: firstnameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        firstname = value;
                      },

                      // onFieldSubmitted: (value) {
                      //   print(value);
                      //   setState(() {
                      //     addressList.add(value);
                      //   });
                      //   addressController.clear();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // icon: Icon(
                        //   Icons.pin_drop_sharp,
                        //   color: Color.fromRGBO(193, 199, 208, 1),
                        // ),
                        // hintText: '     First Name'
                        hintText: 'First Name',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
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
                      controller: lastnameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        lastname = value;
                      },
                      // onFieldSubmitted: (value) {
                      //   print(value);
                      //   setState(() {
                      //     addressList.add(value);
                      //   });
                      //   addressController.clear();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                // Container(
                //     margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(244, 245, 247, 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     // margin: EdgeInsets.only(left: 30),
                //     height: 50,
                //     width: width,
                //     child: TextFormField(
                //       controller: phoneController,
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return "This field is required";
                //         } else {
                //           return null;
                //         }
                //       },
                //       onChanged: (value) {
                //         phone = value;
                //       },
                //       // onFieldSubmitted: (value) {
                //       //   print(value);
                //       //   setState(() {
                //       //     addressList.add(value);
                //       //   });
                //       //   addressController.clear();
                //       // },
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           // icon: Icon(
                //           //   Icons.pin_drop_sharp,
                //           //   color: Color.fromRGBO(193, 199, 208, 1),
                //           // ),
                //           hintText: '     Phone Number'),
                //     )),
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
                      controller: shopaddressController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        shopAddress = value;
                      },
                      // onFieldSubmitted: (value) {
                      //   print(value);
                      //   setState(() {
                      //     addressList.add(value);
                      //   });
                      //   addressController.clear();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // icon: Icon(
                        //   Icons.pin_drop_sharp,
                        //   color: Color.fromRGBO(193, 199, 208, 1),
                        // ),
                        hintText: 'Shop Address',

                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
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
                      controller: shopdescriptionController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        shopdescription = value;
                      },
                      // onFieldSubmitted: (value) {
                      //   print(value);
                      //   setState(() {
                      //     addressList.add(value);
                      //   });
                      //   addressController.clear();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // icon: Icon(
                        //   Icons.calendar_today_outlined,
                        //   color: Color.fromRGBO(193, 199, 208, 1),
                        // ),
                        hintText: 'Shop Description',

                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                // Container(
                //     margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(244, 245, 247, 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     padding: EdgeInsets.only(left: 10),
                //     height: 50,
                //     width: width,
                //     child: TextFormField(
                //       controller: cityController,
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return "This field is required";
                //         } else {
                //           return null;
                //         }
                //       },
                //       onChanged: (value) {
                //         city = value;
                //       },
                //       // onFieldSubmitted: (value) {
                //       //   print(value);
                //       //   setState(() {
                //       //     addressList.add(value);
                //       //   });
                //       //   addressController.clear();
                //       // },
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           // icon: Icon(
                //           //   Icons.calendar_today_outlined,
                //           //   color: Color.fromRGBO(193, 199, 208, 1),
                //           // ),
                //           hintText: '     City'),
                //     )),
                // Container(
                //     margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(244, 245, 247, 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     // margin: EdgeInsets.only(left: 30),
                //     height: 50,
                //     width: width,
                //     child: TextFormField(
                //       controller: countryController,
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return "This field is required";
                //         } else {
                //           return null;
                //         }
                //       },
                //       onChanged: (value) {
                //         country = value;
                //       },
                //       // onFieldSubmitted: (value) {
                //       //   print(value);
                //       //   setState(() {
                //       //     addressList.add(value);
                //       //   });
                //       //   addressController.clear();
                //       // },
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           // icon: Icon(
                //           //   Icons.calendar_today_outlined,
                //           //   color: Color.fromRGBO(193, 199, 208, 1),
                //           // ),
                //           hintText: '     Country'),
                //     )),
                // Container(
                //     margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(244, 245, 247, 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     // margin: EdgeInsets.only(left: 30),
                //     height: 50,
                //     width: width,
                //     child: TextFormField(
                //       controller: stateController,
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return "This field is required";
                //         } else {
                //           return null;
                //         }
                //       },
                //       onChanged: (value) {
                //         state = value;
                //       },
                //       // onFieldSubmitted: (value) {
                //       //   print(value);
                //       //   setState(() {
                //       //     addressList.add(value);
                //       //   });
                //       //   addressController.clear();
                //       // },
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           // icon: Icon(
                //           //   Icons.calendar_today_outlined,
                //           //   color: Color.fromRGBO(193, 199, 208, 1),
                //           // ),
                //           hintText: '     State'),
                //     )),
                // Container(
                //     margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(244, 245, 247, 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     // margin: EdgeInsets.only(left: 30),
                //     height: 50,
                //     width: width,
                //     child: TextFormField(
                //       controller: zipcodeController,
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return "This field is required";
                //         } else {
                //           return null;
                //         }
                //       },
                //       onChanged: (value) {
                //         zipcode = value;
                //       },
                //       // onFieldSubmitted: (value) {
                //       //   print(value);
                //       //   setState(() {
                //       //     addressList.add(value);
                //       //   });
                //       //   addressController.clear();
                //       // },
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           // icon: Icon(
                //           //   Icons.calendar_today_outlined,
                //           //   color: Color.fromRGBO(193, 199, 208, 1),
                //           // ),
                //           hintText: '     ZipCode'),
                //     )),
                // Container(
                //     margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(244, 245, 247, 1),
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     // margin: EdgeInsets.only(left: 30),
                //     height: 50,
                //     width: width,
                //     child: TextFormField(
                //       controller: buisnessCategoryController,
                //       validator: (value) {
                //         if (value.isEmpty) {
                //           return "This field is required";
                //         } else {
                //           return null;
                //         }
                //       },
                //       onChanged: (value) {
                //         buisnesscategory = value;
                //       },
                //       // onFieldSubmitted: (value) {
                //       //   print(value);
                //       //   setState(() {
                //       //     addressList.add(value);
                //       //   });
                //       //   addressController.clear();
                //       // },
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           focusedBorder: InputBorder.none,
                //           enabledBorder: InputBorder.none,
                //           errorBorder: InputBorder.none,
                //           disabledBorder: InputBorder.none,
                //           // icon: Icon(
                //           //   Icons.calendar_today_outlined,
                //           //   color: Color.fromRGBO(193, 199, 208, 1),
                //           // ),
                //           hintText: '     Buisness Category'),
                //     )),
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
                      controller: commentsController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        comments = value;
                      },
                      // onFieldSubmitted: (value) {
                      //   print(value);
                      //   setState(() {
                      //     addressList.add(value);
                      //   });
                      //   addressController.clear();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // icon: Icon(
                        //   Icons.calendar_today_outlined,
                        //   color: Color.fromRGBO(193, 199, 208, 1),
                        // ),
                        hintText: 'Comment',

                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
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
                      controller: shopNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        shopName = value;
                      },
                      // onFieldSubmitted: (value) {
                      //   print(value);
                      //   setState(() {
                      //     addressList.add(value);
                      //   });
                      //   addressController.clear();
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // icon: Icon(
                        //   Icons.calendar_today_outlined,
                        //   color: Color.fromRGBO(193, 199, 208, 1),
                        // ),
                        hintText: 'Shop Title',

                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                InkWell(
                  onTap: () {
                    setState(() {
                      multifile = [];
                    });
                    FilePicker.platform
                        .pickFiles(allowMultiple: false)
                        .then((value) {
                      value.files.forEach((element) async {
                        multifile.add(File(element.path));
                        setState(() {
                          len = multifile.length;
                          print('$len');
                        });
                      });
                    });
                    // _showPicker2(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      // color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 130,
                    width: width,
                    child: len != null
                        ? Container(
                            margin:
                                EdgeInsets.only(top: 25, left: 25, right: 25),
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
                                child: Text(
                                  'You have Selected $len Files',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1)),
                                )),
                            // child: Image.file(
                            //   _image1,
                            //   fit: BoxFit.cover,
                            // ),
                          )
                        : Container(
                            margin:
                                EdgeInsets.only(top: 25, left: 25, right: 25),
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
                                  'Select Documents of User',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                ),
                                Icon(Icons.camera_alt_sharp,
                                    size: 30,
                                    color: Color.fromRGBO(182, 189, 200, 1)),
                              ],
                            ),
                          ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      coverfile = [];
                    });
                    FilePicker.platform
                        .pickFiles(allowMultiple: false)
                        .then((value) {
                      value.files.forEach((element) async {
                        coverfile.add(File(element.path));
                        setState(() {
                          len1 = coverfile.length;
                          print('$len1');
                        });
                      });
                    });
                    // _showPicker2(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      // color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 130,
                    width: width,
                    child: len1 != null
                        ? Container(
                            margin:
                                EdgeInsets.only(top: 25, left: 25, right: 25),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 245, 247, 1),
                              // color: Colors.yellow,
                              borderRadius: BorderRadius.circular(15),
                              // image: Image.file(file)
                            ),
                            height: 130,
                            width: width,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'You have Selected $len1 Files',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                )),
                            // child: Image.file(
                            //   _image1,
                            //   fit: BoxFit.cover,
                            // ),
                          )
                        : Container(
                            margin:
                                EdgeInsets.only(top: 25, left: 25, right: 25),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 130,
                            width: width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Select Cover Image',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                ),
                                Icon(Icons.camera_alt_sharp,
                                    size: 30,
                                    color: Color.fromRGBO(182, 189, 200, 1)),
                              ],
                            ),
                          ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      logfile = [];
                    });
                    FilePicker.platform
                        .pickFiles(allowMultiple: false)
                        .then((value) {
                      value.files.forEach((element) async {
                        logfile.add(File(element.path));
                        setState(() {
                          len2 = logfile.length;
                          print('$len2');
                        });
                      });
                    });
                    // _showPicker2(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      // color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 130,
                    width: width,
                    child: len2 != null
                        ? Container(
                            margin:
                                EdgeInsets.only(top: 25, left: 25, right: 25),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 245, 247, 1),
                              // color: Colors.yellow,
                              borderRadius: BorderRadius.circular(15),
                              // image: Image.file(file)
                            ),
                            height: 130,
                            width: width,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'You have Selected $len2 Files',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                )),
                            // child: Image.file(
                            //   _image1,
                            //   fit: BoxFit.cover,
                            // ),
                          )
                        : Container(
                            margin:
                                EdgeInsets.only(top: 25, left: 25, right: 25),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 130,
                            width: width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Select Logo Image',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.camera_alt_sharp,
                                  size: 30,
                                  color: Color.fromRGBO(182, 189, 200, 1),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                Container(
                  height: height / 4,
                  width: width,
                  margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                  child: FutureBuilder(
                    future: getuserLocation(),
                    builder: (context, AsyncSnapshot<LocationData> snapshot) {
                      if (snapshot.hasData) {
                        return GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: markers,
                          // mapType: MapType.normal,
                          // onMapCreated: (GoogleMapController controller) {

                          // },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(snapshot.data.latitude,
                                  snapshot.data.longitude),
                              zoom: 15),
                          onTap: (latlong) {
                            setState(() {
                              print("latitude Taped = ${latlong.latitude}");
                              print("longitude Taped = ${latlong.longitude}");
                              shoplatitude = latlong.latitude;
                              shoplongitude = latlong.longitude;
                              final _snackBar = SnackBar(
                                  content:
                                      Text('$shoplatitude $shoplongitude'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_snackBar);
                              // markers.add(Marker(
                              //     markerId: MarkerId("Shopp"),
                              //     position: LatLng(latitude, longitude)));
                            });
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else {
                        return CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        );
                      }
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    print({
                      "firstname": "$firstname",
                      "lastname": "$lastname",
                      "comments": "$comments",
                      "shop_title": "$shopName",
                      'shop_latitude': '$shoplatitude',
                      'shop_longitude': '$shoplongitude',
                      "shop_description": "$shopdescription",
                      "shop_address": "$shopAddress",
                      // "documents": multifile,
                      // 'shop_cover': coverfile,
                      // 'shop_logo': logfile
                       "documents": multifile,
                      'shop_cover': coverfile,
                      'shop_logo': logfile
                    });
                    if (_formKey.currentState.validate()) {
                      if (multifile.isEmpty) {
                        final _snackBar = SnackBar(
                            content: Text('Documents of User is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else if (coverfile.isEmpty) {
                        final _snackBar =
                            SnackBar(content: Text('Coverfile is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else if (logfile.isEmpty) {
                        final _snackBar =
                            SnackBar(content: Text('Logo file is missing'));
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
                                  becomeVender(context);
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
                        'Submit',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }

//  var firstname;
//   var lastname;
//   var phone;
//   var firstAddress;
//   var secondAddres;
//   var city;
//   var country;
//   var state;
//   var zipcode;
//   var buisnesscategory;
//   var comments;
//   var shopName;
  becomeVender(context) async {
  MultipartFile x ;
  MultipartFile y ;
    MultipartFile z ;
    multifile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x = value;
      });
    });
    coverfile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        // y.add(value);
        y= value;
      });
    });
    logfile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        z = value;
      });
    });

    Timer(Duration(seconds: 1), () async {
      try {
        var formData = FormData.fromMap({
         
          "firstname": "$firstname",
          "lastname": "$lastname",
          "comments": "$comments",
          "shop_title": "$shopName",
          'shop_latitude': '$shoplatitude',
          'shop_longitude': '$shoplongitude',
          "shop_description": "$shopdescription",
          "shop_address": "$shopAddress",
          "documents": x,
          'shop_cover': y,
          'shop_logo': z
         
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $tokenUser';

        print({
          "firstname": "$firstname",
          "lastname": "$lastname",
          "comments": "$comments",
          "shop_title": "$shopName",
          'shop_latitude': '$shoplatitude',
          'shop_longitude': '$shoplongitude',
          "shop_description": "$shopdescription",
          "shop_address": "$shopAddress",
          "documents": x,
          'shop_cover': y,
          'shop_logo': z
        });
        var response =
            await dio.post("$apiBaseURL/user/request", data: formData);
        print("Become Vender: $response");

        var gg = response.data;
        print('${response.data['message']}');
        if (gg['message'] == 'Request Sent!') {
          print('fgdhdjfkf');
          showAlert(
            context: context,
            title: "Account Successfully created",
            actions: [
              AlertAction(
                  text: "Ok ",
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
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
