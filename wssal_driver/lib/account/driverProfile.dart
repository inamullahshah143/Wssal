import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';
// import 'package:pattern_formatter/date_formatter.dart';
import 'package:wssal_driver/account/vehicleProfile.dart';
import 'package:wssal_driver/function.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wssal_driver/home.dart';

import 'LogIn.dart';

var len;

var len1;

List<File> photofile = [];
List<File> idCardPicfile = [];
String drivername;
var idnumber;
var idexpiry;
String vehiclename;
var vehicleplatenumber;
var vehiclemodel;
TextEditingController drivernameController = TextEditingController();
// TextEditingController driverphoneController = TextEditingController();
TextEditingController driveridnumberController = TextEditingController();
TextEditingController driveridexpirydateController = TextEditingController();
TextEditingController vehiclenameController = TextEditingController();
TextEditingController vehicleplatenumberController = TextEditingController();
TextEditingController vehiclemodelController = TextEditingController();

class DriverProfile extends StatefulWidget {
  // const DriverProfile({ Key? key }) : super(key: key);
  final drivertoken;
  DriverProfile(this.drivertoken);
  // drivertoken
  @override
  _DriverProfileState createState() => _DriverProfileState(drivertoken);
}

class _DriverProfileState extends State<DriverProfile> {
  final drivertoken;
  _DriverProfileState(this.drivertoken);
  final _formKey = GlobalKey<FormState>();
  DateTime date1;
  var latitude1;
  var longitude1;
  String lat;
  String lng;
  LatLng lock = LatLng(31.5204, 74.3587);

  Set<Marker> markers = {};
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 180),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Driver Profile ',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 136, 142, 1),
                          fontSize: 22),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Your phone number +201003456789',
                      style: TextStyle(
                          color: Color.fromRGBO(149, 159, 175, 1),
                          fontSize: 16),
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.only(left: 10),
                  height: 50,
                  width: width,
                  child: TextFormField(
                    controller: drivernameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      drivername = value;
                    },
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
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(195, 153, 141, 1)
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  )),

              Container(
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                padding: EdgeInsets.only(left: 10),
                child: DateTimePickerFormField(
                  inputType: InputType.date,
                  format: DateFormat("dd-MM-yyyy"),
                  initialDate: DateTime(2019, 1, 1),
                  editable: false,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Id Expiry date',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        // color: Color.fromRGBO(195, 153, 141, 1)
                        color: Color.fromRGBO(182, 189, 200, 1)),
                    // hasFloatingPlaceholder: false
                  ),
                  onChanged: (dt) {
                    // setState(() => date = dt);
                    setState(() {
                      idexpiry = dt;
                      print('Selected date: $idexpiry');
                    });

                    // print('Selected date: $date1');
                  },
                ),
              ), // TextField(
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     DateInputFormatter(),
              //   ],
              // ),
              //             Container(
              //                 margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              //                 decoration: BoxDecoration(
              //                   color: Color.fromRGBO(244, 245, 247, 1),
              //                   borderRadius: BorderRadius.circular(15),
              //                 ),
              //                 height: 50,
              //                 width: width,
              //                 child: TextFormField(
              //                   controller: driverphoneController,
              //                   validator: (value) {
              //                     if (value.isEmpty) {
              //                       return "This field is required";
              //                     } else {
              //                       return null;
              //                     }
              //                   },
              //                   //                   String drivername;
              //                   // var phone;
              //                   // var idnumber;
              //                   // var idexpiry;
              //                   // String vehiclename;
              //                   //  var vehicleplatenumber;
              //                   //  var vehiclemodel;
              // //   TextEditingController drivernameController = TextEditingController();
              // // TextEditingController driverphoneController = TextEditingController();
              // // TextEditingController driveridnumberController = TextEditingController();
              // // TextEditingController driveridexpirydateController = TextEditingController();
              // // TextEditingController vehiclenameController = TextEditingController();
              // // TextEditingController vehicleplatenumberController = TextEditingController();
              // // TextEditingController vehiclemodelController = TextEditingController();
              //                   onChanged: (value) {
              //                     phone = value;
              //                   },
              //                   // onFieldSubmitted: (value) {
              //                   //   print(value);
              //                   //   setState(() {
              //                   //     addressList.add(value);
              //                   //   });
              //                   //   addressController.clear();
              //                   // },
              //                   decoration: InputDecoration(
              //                       border: InputBorder.none,
              //                       focusedBorder: InputBorder.none,
              //                       enabledBorder: InputBorder.none,
              //                       errorBorder: InputBorder.none,
              //                       disabledBorder: InputBorder.none,
              //                       // icon: Icon(
              //                       //   Icons.calendar_today_outlined,
              //                       //   color: Color.fromRGBO(193, 199, 208, 1),
              //                       // ),
              //                       labelText: '     Phone'),
              //                 )),
              Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: driveridnumberController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else if (value.length < 10) {
                        return "This field must be 10 digit";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      idnumber = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Id Number',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(195, 153, 141, 1)
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  )),
              // Container(
              //     margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              //     decoration: BoxDecoration(
              //       color: Color.fromRGBO(244, 245, 247, 1),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     height: 50,
              //     width: width,
              //     padding: EdgeInsets.only(left: 10),
              //     child: TextFormField(
              //       controller: driveridexpirydateController,
              //       validator: (value) {
              //         if (value.isEmpty) {
              //           return "This field is required";
              //         } else {
              //           return null;
              //         }
              //       },
              //       //                   String drivername;
              //       // var phone;
              //       // var idnumber;
              //       // var idexpiry;
              //       // String vehiclename;
              //       //  var vehicleplatenumber;
              //       //  var vehiclemodel;
              //       //   TextEditingController drivernameController = TextEditingController();
              //       // TextEditingController driverphoneController = TextEditingController();
              //       // TextEditingController driveridnumberController = TextEditingController();
              //       // TextEditingController driveridexpirydateController = TextEditingController();
              //       // TextEditingController vehiclenameController = TextEditingController();
              //       // TextEditingController vehicleplatenumberController = TextEditingController();
              //       // TextEditingController vehiclemodelController = TextEditingController();
              //       onChanged: (value) {
              //         idexpiry = value;
              //       },
              //       // onFieldSubmitted: (value) {
              //       //   print(value);
              //       //   setState(() {
              //       //     addressList.add(value);
              //       //   });
              //       //   addressController.clear();
              //       // },
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         enabledBorder: InputBorder.none,
              //         errorBorder: InputBorder.none,
              //         disabledBorder: InputBorder.none,
              //         // icon: Icon(
              //         //   Icons.calendar_today_outlined,
              //         //   color: Color.fromRGBO(193, 199, 208, 1),
              //         // ),
              //         labelText: 'Id Expiry date',
              //         labelStyle: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600,
              //             // color: Color.fromRGBO(195, 153, 141, 1)
              //             color: Color.fromRGBO(182, 189, 200, 1)),
              //       ),
              //     )),
              Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: vehicleplatenumberController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    //                   String drivername;
                    // var phone;
                    // var idnumber;
                    // var idexpiry;
                    // String vehiclename;
                    //  var vehicleplatenumber;
                    //  var vehiclemodel;
                    //   TextEditingController drivernameController = TextEditingController();
                    // TextEditingController driverphoneController = TextEditingController();
                    // TextEditingController driveridnumberController = TextEditingController();
                    // TextEditingController driveridexpirydateController = TextEditingController();
                    // TextEditingController vehiclenameController = TextEditingController();
                    // TextEditingController vehicleplatenumberController = TextEditingController();
                    // TextEditingController vehiclemodelController = TextEditingController();
                    onChanged: (value) {
                      vehicleplatenumber = value;
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
                      labelText: 'vehicle plate number',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                padding: EdgeInsets.only(left: 10),
                child: DateTimePickerFormField(
                  inputType: InputType.date,
                  format: DateFormat("dd-MM-yyyy"),
                  initialDate: DateTime(2019, 1, 1),
                  editable: false,
                  decoration: InputDecoration.collapsed(
                    hintText: 'vehicle model',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        // color: Color.fromRGBO(195, 153, 141, 1)
                        color: Color.fromRGBO(182, 189, 200, 1)),
                    // hasFloatingPlaceholder: false
                  ),
                  onChanged: (dt) {
                    // setState(() => date = dt);
                    setState(() {
                      vehiclemodel = dt;
                      print('Selected date: $vehiclemodel');
                    });

                    // print('Selected date: $date1');
                  },
                ),
                // child: TextFormField(
                //   controller: vehiclemodelController,
                //   validator: (value) {
                //     if (value.isEmpty) {
                //       return "This field is required";
                //     } else {
                //       return null;
                //     }
                //   },
                //   onChanged: (value) {
                //     vehiclemodel = value;
                //   },
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     focusedBorder: InputBorder.none,
                //     enabledBorder: InputBorder.none,
                //     errorBorder: InputBorder.none,
                //     disabledBorder: InputBorder.none,
                //     labelText: 'vehicle model',
                //     labelStyle: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: Color.fromRGBO(182, 189, 200, 1)),
                //   ),
                // )
              ),
              Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: vehiclenameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    //                   String drivername;
                    // var phone;
                    // var idnumber;
                    // var idexpiry;
                    // String vehiclename;
                    //  var vehicleplatenumber;
                    //  var vehiclemodel;
                    //   TextEditingController drivernameController = TextEditingController();
                    // TextEditingController driverphoneController = TextEditingController();
                    // TextEditingController driveridnumberController = TextEditingController();
                    // TextEditingController driveridexpirydateController = TextEditingController();
                    // TextEditingController vehiclenameController = TextEditingController();
                    // TextEditingController vehicleplatenumberController = TextEditingController();
                    // TextEditingController vehiclemodelController = TextEditingController();
                    onChanged: (value) {
                      vehiclename = value;
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
                      labelText: 'vehicle name',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(195, 153, 141, 1)
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  )),
              InkWell(
                onTap: () {
                  setState(() {
                    idCardPicfile = [];
                  });
                  FilePicker.platform
                      .pickFiles(allowMultiple: true)
                      .then((value) {
                    value.files.forEach((element) async {
                      idCardPicfile.add(File(element.path));
                      setState(() {
                        len = idCardPicfile.length;
                        print('$len');
                      });
                    });
                  });
                  // _showPicker2(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 130,
                  width: width,
                  child: len != null
                      ? Container(
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
                              child: Text('You have Selected $len Files')),
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
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Select Files',
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
                    photofile = [];
                  });
                  FilePicker.platform
                      .pickFiles(allowMultiple: true)
                      .then((value) {
                    value.files.forEach((element) async {
                      photofile.add(File(element.path));
                      setState(() {
                        len1 = photofile.length;
                        print('$len1');
                      });
                    });
                  });
                  // _showPicker2(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 130,
                  width: width,
                  child: len1 != null
                      ? Container(
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
                              child: Text('You have Selected $len1 Files')),
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
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Select Driver Picture',
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
                onTap: () async {
                  print({
                    "name": '$drivername',
                    "id_number": "$idnumber",
                    'id_expiry': "$idexpiry",
                    'vehicle_name': "$vehiclename",
                    'plate_number': "$vehicleplatenumber",
                    'modal': "$vehiclemodel",
                    'vehicle_latitude': '$lat',
                    'vehicle_longitude': '$lng',
                    'photo': photofile,
                    'id_picture': idCardPicfile,
                  });
                  //                   var vehiclelatitude;
                  // var vehiclelongitude;
                  if (_formKey.currentState.validate()) {
                    if (photofile.isEmpty) {
                      final _snackBar =
                          SnackBar(content: Text('Photo of Driver is missing'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    } else if (idCardPicfile.isEmpty) {
                      final _snackBar = SnackBar(
                          content: Text('ID_Card of Driver is missing'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    } else if (lat == null && lng == null) {
                      final _snackBar = SnackBar(
                          content:
                              Text('Please Select Vehicle Location from Map'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    } else {
                      print('Ahmad');
                      showAlert(
                        context: context,
                        title: "Driver Request is creating please wait",
                        actions: [
                          AlertAction(
                              text: "Ok",
                              isDestructiveAction: true,
                              onPressed: () {
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (BuildContext context) =>
                                //           Varifyphonenumber(phonenumber)),
                                // );
                                addDriverRequest(context);
                              }),
                        ],
                        cancelable: true,
                      );
                    }
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 199, 0, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('Create Account')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addDriverRequest(context) async {
    List<MultipartFile> x = [];
    List<MultipartFile> y = [];
    idCardPicfile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x.add(value);
      });
    });
    photofile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        y.add(value);
      });
    });
    Timer(Duration(seconds: 1), () async {
      try {
        var formData = FormData.fromMap({
          "name": '$drivername',
          "id_number": "$idnumber",
          'id_expiry': "$idexpiry",
          'vehicle_name': "$vehiclename",
          'plate_number': "$vehicleplatenumber",
          'modal': "$vehiclemodel",
          'vehicle_latitude': '$lat',
          'vehicle_longitude': '$lng',
          'photo': y[0],
          'id_picture': x[0],
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $drivertoken';

        print({
          "name": '$drivername',
          "id_number": "$idnumber",
          'id_expiry': "$idexpiry",
          'vehicle_name': "$vehiclename",
          'plate_number': "$vehicleplatenumber",
          'modal': "$vehiclemodel",
          'vehicle_latitude': '$lat',
          'vehicle_longitude': '$lng',
          'photo': y[0],
          'id_picture': x[0],
          "token": 'Bearer $stringValue'
        });
        var response = await dio.post(
            "https://wassldev.einnovention.tech/api/user/driverRequest",
            data: formData);
        print("Become Driver: $response");

        Map gg = response.data;
        print('gg = $gg');
        print('message = ${gg['message']}');
        if (gg['message'] == 'Successfullly created!') {
          print('Successfully created!');
          showAlert(
            context: context,
            title: "Successfully created!",
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
        } else {
          showAlert(
            context: context,
            title: "Driver Not Created",
            actions: [
              AlertAction(
                  text: "Ok ",
                  isDestructiveAction: true,
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => Home(),
                    //   ),
                    // );
                  }),
            ],
            cancelable: true,
          );
        }
      } on DioError catch (e) {
        if (e.response != null) {
          print(e.response.data);
          print(e.response.headers);
        } else {
          print(e.message);
        }
      }
    });
  }
}
