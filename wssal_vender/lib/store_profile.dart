import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'functions.dart';
import 'login_page.dart';

class StoreProfile extends StatefulWidget {
  final tokenUser;
  StoreProfile(this.tokenUser);

  @override
  _StoreProfileState createState() => _StoreProfileState(tokenUser);
}

class _StoreProfileState extends State<StoreProfile> {
  LatLng lock = LatLng(31.5204, 74.3587);
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
  List _tagitems = [];
  List<String> tagList = [];

  Set<Marker> markers = {};

  String firstname;
  String lastname;
  String shopName;
  String lat;
  String lng;
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
                        // labelText: '     First Name'
                        labelText: 'First Name',
                        labelStyle: TextStyle(
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
                        labelText: 'Last Name',
                        labelStyle: TextStyle(
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
                //           labelText: '     Phone Number'),
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
                        labelText: 'Shop Address',

                        labelStyle: TextStyle(
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
                        labelText: 'Shop Description',

                        labelStyle: TextStyle(
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
                //           labelText: '     City'),
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
                //           labelText: '     Country'),
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
                //           labelText: '     State'),
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
                //           labelText: '     ZipCode'),
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
                //           labelText: '     Buisness Category'),
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
                        labelText: 'Comment',

                        labelStyle: TextStyle(
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
                        labelText: 'Shop Title',

                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Color.fromRGBO(195, 153, 141, 1)
                            color: Color.fromRGBO(182, 189, 200, 1)),
                      ),
                    )),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(244, 245, 247, 1),
                  ),
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Tags(
                      alignment: WrapAlignment.start,
                      spacing: 2,
                      textField: TagsTextField(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(30, 92, 135, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        autofocus: false,
                        helperText: "Product Tags",
                        lowerCase: true,
                        inputDecoration: InputDecoration(
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: new BorderSide(
                                color: Colors.transparent, width: 3),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: new BorderSide(
                                color: Colors.transparent, width: 3),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: new BorderSide(
                                color: Colors.transparent, width: 3),
                          ),
                          // labelText: "attribute Values",
                          labelStyle: TextStyle(
                            // color: Color.fromRGBO(30, 92, 135, 1),
                            color: Colors.black45,
                            // fontSize: 16,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                        onSubmitted: (String str) {
                          if (_tagitems.length < 20) {
                            tagList.add(str);
                            setState(() {
                              // required
                              _tagitems.add(str);
                            });
                          } else {
                            print("Limit Reached");
                          }
                          print(tagList);
                        },
                      ),
                      itemCount: _tagitems.length, // required
                      itemBuilder: (int index) {
                        final item = _tagitems[index];

                        return ItemTags(
                          key: Key(index.toString()),
                          index: index, // required
                          title: item,

                          customData: item,
                          textStyle: TextStyle(
                            fontSize: 12,
                          ),
                          combine: ItemTagsCombine.withTextBefore,

                          removeButton: ItemTagsRemoveButton(
                            icon: Icons.remove,
                            size: 7,
                            onRemoved: () {
                              setState(() {
                                _tagitems.removeAt(index);
                              });
                              //required
                              return true;
                            },
                          ), // OR null,
                          onPressed: (item) => print(item),
                          onLongPressed: (item) => print(item),
                        );
                      },
                    ),
                  ),
                ),
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
                          len1 = logfile.length;
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
                                  'Select Logo Image',
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
                Container(
                  child: Divider(),
                ),
                Text(
                  'Address (Coordinates)',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                lat != null && lng != null
                    ? Container(
                        margin: EdgeInsets.all(25),
                        child: Table(
                          children: [
                            TableRow(children: [
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Latitude:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "$lat",
                                    style: TextStyle(fontSize: 16),
                                  ))
                            ]),
                            TableRow(children: [
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Latitude:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "$lng",
                                    style: TextStyle(fontSize: 16),
                                  ))
                            ]),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 350,
                  alignment: Alignment.center,
                  width: double.infinity,

                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                  ),

                  child: PlacePicker(
                    apiKey: 'AIzaSyAMp8UY-G3eUJeinsx6uwK-j0lXFYB_KWo',
                    initialPosition: lock,
                    useCurrentLocation: false,
                    selectInitialPosition: false,
                    usePlaceDetailSearch: true,
                    forceSearchOnZoomChanged: true,
                    automaticallyImplyAppBarLeading: false,
                    onPlacePicked: (result) {
                      setState(() {
                        lock = LatLng(result.geometry.location.lat,
                            result.geometry.location.lng);
                        lat = result.geometry.location.lat.toString();
                        lng = result.geometry.location.lng.toString();
                      });
                    },
                    pinBuilder: (context, state) {
                      if (state == PinState.Idle) {
                        return Icon(Icons.location_on, color: Colors.red);
                      } else {
                        return Icon(Icons.location_on_outlined,
                            color: Colors.red);
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
                      'shop_latitude': '$lat',
                      'shop_longitude': '$lng',
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
                      } else if (lat == null && lng == null) {
                        final _snackBar =
                            SnackBar(content: Text('Select Address'));
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
    MultipartFile x;
    MultipartFile y;
    MultipartFile z;
    multifile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x = value;
      });
    });
    coverfile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        // y.add(value);
        y = value;
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
          "category_id": "1",
          "firstname": "$firstname",
          "lastname": "$lastname",
          "comments": "$comments",
          "shop_title": "$shopName",
          'shop_latitude': '$lat',
          'shop_longitude': '$lng',
          "shop_description": "$shopdescription",
          "shop_address": "$shopAddress",
          "documents": x,
          'shop_cover': y,
          'shop_logo': z,
          'tags': _tagitems.toString().replaceAll("[", "").replaceAll("]", ""),
        });

        print({
          "category_id": "1",
          "firstname": "$firstname",
          "lastname": "$lastname",
          "comments": "$comments",
          "shop_title": "$shopName",
          'shop_latitude': '$lat',
          'shop_longitude': '$lng',
          "shop_description": "$shopdescription",
          "shop_address": "$shopAddress",
          "documents": x,
          'shop_cover': y,
          'shop_logo': z,
          'tags': _tagitems.toString().replaceAll("[", "").replaceAll("]", ""),
          'Authorization': 'Bearer $tokenUser'
        });
        var response = await Dio().post("$apiBaseURL/user/request",
            data: formData,
            options: Options(headers: {'Authorization': 'Bearer $tokenUser'}));
          
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
