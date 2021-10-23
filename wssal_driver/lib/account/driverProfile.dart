import 'dart:async';
import 'dart:math';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:wssal_driver/function.dart';
import 'dart:io';
import 'package:intl/intl.dart';
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
TextEditingController driveridnumberController = TextEditingController();
TextEditingController driveridexpirydateController = TextEditingController();
TextEditingController vehiclenameController = TextEditingController();
TextEditingController vehicleplatenumberController = TextEditingController();
TextEditingController vehiclemodelController = TextEditingController();

class DriverProfile extends StatefulWidget {
  final drivertoken;
  final String phoneNo;
  DriverProfile({@required this.drivertoken, @required this.phoneNo});
  @override
  _DriverProfileState createState() =>
      _DriverProfileState(drivertoken: drivertoken, phoneNo: phoneNo);
}

class _DriverProfileState extends State<DriverProfile> {
  final drivertoken;
  final String phoneNo;
  _DriverProfileState({@required this.drivertoken, @required this.phoneNo});
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
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Driver Profile ',
                      style: TextStyle(
                          color: Color.fromRGBO(128, 136, 142, 1),
                          fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Your phone number ${phoneNo}',
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
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(182, 189, 200, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: width,
                  padding: EdgeInsets.only(left: 10),
                  child: DateTimePickerFormField(
                    inputType: InputType.date,
                    format: DateFormat("dd-MM-yyyy"),
                    initialDate: DateTime(2019, 1, 1),
                    editable: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 17.5),
                      labelText: 'ID Card Expiry Date',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(182, 189, 200, 1),
                      ),
                    ),
                    onChanged: (dt) {
                      setState(() {
                        idexpiry = dt;
                        print('Selected date: $idexpiry');
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                      labelText: 'ID Card Number',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(182, 189, 200, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: width,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      vehicleplatenumber = value;
                    },
                    controller: vehicleplatenumberController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Vehicle Plate Number',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: width,
                  padding: EdgeInsets.only(left: 10),
                  child: DateTimePickerFormField(
                    inputType: InputType.date,
                    format: DateFormat("dd-MM-yyyy"),
                    initialDate: DateTime(2019, 1, 1),
                    editable: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 17.5),
                      labelText: 'Vehicle Model',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(182, 189, 200, 1),
                      ),
                    ),
                    onChanged: (dt) {
                      setState(() {
                        vehiclemodel = dt;
                        print('Selected date: $vehiclemodel');
                      });
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                      onChanged: (value) {
                        vehiclename = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: 'Vehicle Name',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(182, 189, 200, 1),
                        ),
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 130,
                            width: width,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('You have Selected $len Files'),
                            ),
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 130,
                            width: width,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('You have Selected $len1 Files'),
                            ),
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
                            TableRow(
                              children: [
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
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Latitude:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "$lng",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 350,
                  alignment: Alignment.center,
                  width: double.infinity,
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
                      'vehicle_latitude':
                          '${roundDouble(double.parse(lat), 4)}',
                      'vehicle_longitude':
                          '${roundDouble(double.parse(lng), 4)}',
                      'photo': photofile,
                      'id_picture': idCardPicfile,
                    });
                    if (_formKey.currentState.validate()) {
                      if (photofile.isEmpty) {
                        final _snackBar = SnackBar(
                            content: Text('Photo of Driver is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else if (idCardPicfile.isEmpty) {
                        final _snackBar = SnackBar(
                            content: Text('ID_Card of Driver is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else if (lat == null && lng == null) {
                        final _snackBar = SnackBar(
                            content: Text(
                                'Please Select Vehicle Location from Map'));
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
                                  addDriverRequest(context);
                                }),
                          ],
                          cancelable: true,
                        );
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 20),
                    height: 50,
                    width: width,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 199, 0, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Create Account'),
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
          "token": 'Bearer $drivertoken'
        });
        var response = await dio.post(
            "https://einnovention.co.uk/wassl/public/api/user/driverRequest",
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
                  text: "Ok ", isDestructiveAction: true, onPressed: () {}),
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

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
