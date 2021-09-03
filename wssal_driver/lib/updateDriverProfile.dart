import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dash_chat/dash_chat.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wssal_driver/person/personInformation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'function.dart';

List<File> avatar = [];
List<File> id_picture = [];
var leng;
var leng1;
var userId;
var name;
var email;
var phone;
var paypal_email;
var password;
var vehicle_name;
var plate_number;
var model;
var id_number;
var id_expiry;
var vehicle_latitude;
var vehicle_longitude;

class UpdateDriverProfile extends StatefulWidget {
  final data;
  UpdateDriverProfile(this.data);

  @override
  _UpdateDriverProfileState createState() => _UpdateDriverProfileState(data);
}

class _UpdateDriverProfileState extends State<UpdateDriverProfile> {
  final data;
  _UpdateDriverProfileState(this.data);

  final _formKey = GlobalKey<FormState>();

  Set<Marker> markers = {};
  @override
  void initState() {
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    paypal_email = data['paypal_email'];
    userId = data['id'];
    vehicle_name = data['driver_vehicle']['vehicle_name'];
    plate_number = data['driver_vehicle']['plate_number'];
    model = data['driver_vehicle']['modal'];
    id_number = data['driver_vehicle']['id_number'];
    id_expiry = data['driver_vehicle']['id_expiry'];
    vehicle_latitude = data['driver_vehicle']['vehicle_latitude'];
    vehicle_longitude = data['driver_vehicle']['vehicle_longitude'];
    print('vehicle_name = $vehicle_name');
    print('plate_number = $plate_number');
    print('model = $model');
    print('id_number = $id_number');
    print('id_expiry = $id_expiry');
    print('vehicle_latitude = $vehicle_latitude');
    print('vehicle_longitude = $vehicle_longitude');
    print('name = $name');
    print('email = $email');
    print('phone = $phone');
    print('paypal_email = $paypal_email');
      // _getlocation();
    super.initState();
  }
  
  // _getlocation() {
  //   Location location = Location();
  //   location.getLocation().then((value) {
  //     setState(() {
  //       latitude1 = value.latitude;
  //       longitude1 = value.longitude;

  //       print('latitude mine : $latitude1');
  //       print('longitude mine: $longitude1');
  //     });
  //   });
  // }
 Future<LocationData> getuserLocation() async {
    Location location = Location();
    return location.getLocation();
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
                  padding: EdgeInsets.all(8),
                  width: width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Driver Information',
                      style: TextStyle(
                          color: Color.fromRGBO(182, 189, 200, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
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
                        hintText: 'Name',
                        hintStyle: TextStyle(
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
                        hintText: 'Email',
                        hintStyle: TextStyle(
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
                        hintText: 'Phone',
                        hintStyle: TextStyle(
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
                        hintText: 'paypal_email',
                        hintStyle: TextStyle(
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
                        hintText: 'Password',
                        hintStyle: TextStyle(
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
                  child: TextFormField(
                    initialValue: '$id_number',
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
                      id_number = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Id Number',
                      hintStyle: TextStyle(
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
                      hintText: 'id_expiry',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                    onChanged: (dt) {
                      setState(() {
                        model = dt;
                        print('Selected date: $id_expiry');
                      });
                    },
                  ),
                ),
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
                    width: width,
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
                            width: width,
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
                            width: width,
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

                InkWell(
                  onTap: () {
                    setState(() {
                      id_picture = [];
                    });
                    FilePicker.platform
                        .pickFiles(allowMultiple: false)
                        .then((value) {
                      value.files.forEach((element) async {
                        id_picture.add(File(element.path));
                        setState(() {
                          leng1 = id_picture.length;
                          print('$leng1');
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
                    width: width,
                    child: leng1 != null
                        ? Container(
                            padding: EdgeInsets.all(5),
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
                                child: Text('You have Selected $leng1 Files')),
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
                                  'Select ID_Picture',
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

                Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Vehicle Information',
                      style: TextStyle(
                          color: Color.fromRGBO(182, 189, 200, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),

// var vehicle_name;
// var plate_number;
// var model;
// var id_number;
// var id_expiry;
// var vehicle_latitude;
// var vehicle_longitude;

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
                      initialValue: '$vehicle_name',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        vehicle_name = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Vehicle Name',
                        hintStyle: TextStyle(
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
                      initialValue: '$plate_number',
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        plate_number = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Plate Number',
                        hintStyle: TextStyle(
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
                      hintText: 'model',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                    onChanged: (dt) {
                      setState(() {
                        model = dt;
                        print('Selected date: $model');
                      });
                    },
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
                            vehicle_latitude = latlong.latitude;
                            vehicle_longitude = latlong.longitude;
                            final _snackBar = SnackBar(
                                content:
                                    Text('$vehicle_latitude $vehicle_longitude'));
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

    // name = data['name'];
    // email = data['email'];
    // phone = data['phone'];
    // paypal_email = data['paypal_email'];
    // userId = data['id'];
    // vehicle_name = data['driver_vehicle']['vehicle_name'];
    // plate_number = data['driver_vehicle']['plate_number'];
    // model = data['driver_vehicle']['modal'];
    // id_number = data['driver_vehicle']['id_number'];
    // id_expiry = data['driver_vehicle']['id_expiry'];
    // vehicle_latitude = data['driver_vehicle']['vehicle_latitude'];
    // vehicle_longitude = data['driver_vehicle']['vehicle_longitude'];


                  onTap: () {

                    print({
                      "name": "$name",
                      "email": "$email",
                      "phone": "$phone",
                      "paypal_email": "$paypal_email",
                      'password': '$password',
                      'avatar': avatar,
                      'id_picture': id_picture,
                      'model': '$model',
                      'id_number': '$id_number',
                      'id_expiry': '$id_expiry',
                      'vehicle_latitude': '$vehicle_latitude',
                      'vehicle_longitude': '$vehicle_longitude',
                      'vehicle_name': '$vehicle_name',
                      'plate_number': '$plate_number',
                      });
                    if (_formKey.currentState.validate()) {
                      if (avatar.isEmpty) {
                        final _snackBar = SnackBar(
                            content: Text('Avatar of Driver is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else if(id_picture.isEmpty){
                       final _snackBar = SnackBar(
                            content: Text('Id_Picture of Driver is missing'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }else if(email == null){
                        final _snackBar = SnackBar(
                          content:
                              Text('Email of Driver id missing'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }
                      else if(paypal_email == null){
                        final _snackBar = SnackBar(
                          content:
                              Text('Paypal_Email of Driver id missing'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      } else if(vehicle_latitude  == null){
                        final _snackBar = SnackBar(
                          content:
                              Text('Please Select Vehicle Location from Map'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }else if(model == null){
                        final _snackBar = SnackBar(
                          content:
                              Text('Please Select Vehicle Model Date From Callender'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }else if(id_expiry == null){
                        final _snackBar = SnackBar(
                          content:
                              Text('Please Select ID_Expiry Date From Callender'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                      }
                      else {
                        showAlert(
                          context: context,
                          title: "Your Request is Being Proced ",
                          actions: [
                            AlertAction(
                                text: "Ok ",
                                isDestructiveAction: true,
                                onPressed: () {
                                  updatedriverProfile(context);
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
                        'Update Profile',
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

  updatedriverProfile(context) async {
    MultipartFile x;
    MultipartFile y;

    avatar.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x = value;
      });
    });

    id_picture.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        y = value;
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
          'vehicle_name':'$vehicle_name',
          'plate_number':'$plate_number',
          'modal':'$model',
          'id_number':'$id_number',
          'id_expiry':'$id_expiry',
          'vehicle_longitude':'$vehicle_latitude',
          'vehicle_latitude':'$vehicle_latitude',
          "avatar": x,
          'id_picture': y
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $stringValue';

        print({
         "_method": "PUT",
          "name": "$name",
          "email": "$email",
          "phone": "$phone",
          'paypal_email': '$paypal_email',
          'password': '$password',
          'vehicle_name':'$vehicle_name',
          'plate_number':'$plate_number',
          'modal':'$model',
          'id_number':'$id_number',
          'id_expiry':'$id_expiry',
          'vehicle_longitude':'$vehicle_latitude',
          'vehicle_latitude':'$vehicle_latitude',
          "avatar": x,
          'id_picture': y
        });
        var response = await dio.post(
            "https://wassldev.einnovention.tech/api/driver/profile/$userId",
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
                        builder: (BuildContext context) => PersonInformation(),
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
