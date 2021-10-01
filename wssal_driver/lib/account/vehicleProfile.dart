import 'package:flutter/material.dart';
import 'package:wssal_driver/function.dart';
import 'dart:io';

import 'package:wssal_driver/wallet/dashboard/landing_screen.dart';

File _image;
File _image1;

class VehicleProfile extends StatefulWidget {
  // const VehicleProfile({ Key? key }) : super(key: key);

  @override
  _VehicleProfileState createState() => _VehicleProfileState();
}

class _VehicleProfileState extends State<VehicleProfile> {
  String _chosenValue;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 180),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Vehicle Profile',
                    style: TextStyle(
                        color: Color.fromRGBO(128, 136, 142, 1), fontSize: 22),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Your phone number +201003456789',
                    style: TextStyle(
                        color: Color.fromRGBO(149, 159, 175, 1), fontSize: 16),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 245, 247, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 50,
              width: width,
              padding: const EdgeInsets.all(05.0),
              child: DropdownButton<String>(
                value: _chosenValue,
                style: TextStyle(color: Colors.grey),
                items: <Map>[
                  {'title': 'ODDI', 'icon': Icon(Icons.car_repair_rounded)},
                  {
                    'title': 't',
                    'icon': Icon(Icons.electric_rickshaw),
                  },
                  {
                    'title': 'toktoki',
                    'icon': Icon(Icons.motorcycle_rounded),
                  }
                ].map<DropdownMenuItem<String>>((Map value) {
                  return DropdownMenuItem<String>(
                    value: value['title'],
                    child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(child: value['icon']),
                        TextSpan(
                            text: value['title'],
                            style:
                                TextStyle(fontSize: 17, color: Colors.black)),
                      ]),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _chosenValue = value;
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
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
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
                      labelText: '     Vehical Model'),
                )),
            Container(
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
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
                      labelText: '     Company Name'),
                )),
            Container(
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
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
                      labelText: '     Buying Date'),
                )),
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                // color: Color.fromRGBO(244, 245, 247, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 150,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // _showPicker(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(244, 245, 247, 1),
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 130,
                      width: 150,
                      child: _image != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 245, 247, 1),
                                // color: Colors.yellow,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 130,
                              width: 150,
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vehicle Picture',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.center_focus_weak_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_up_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _showPicker2(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(244, 245, 247, 1),
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 130,
                      width: 150,
                      child: _image1 != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 245, 247, 1),
                                // color: Colors.yellow,
                                borderRadius: BorderRadius.circular(15),
                                // image: Image.file(file)
                              ),
                              height: 130,
                              width: 150,
                              child: Image.file(
                                _image1,
                                fit: BoxFit.cover,
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Licence Picture',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.dashboard_outlined,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  Icon(
                                    Icons.arrow_circle_up_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // height: 150,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 245, 247, 1),
                        // color: Colors.yellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 50,
                      width: 150,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Previous',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 100.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.flutter_dash),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'You request submitted successfully',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Upon approval, you will receive a SMS and notification, it may take unto 24 hours to complete your profile.',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text(
                                                "ok",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          LandingScreen()),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });

                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //           VehicleProfile()),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 50,
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  // _imgFromCamera() async {
  //   PickedFile image = await ImagePicker.platform
  //       .pickImage(source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  // _imgFromGallery() async {
  //   PickedFile image = await ImagePicker.platform
  //       .pickImage(source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       _imgFromGallery();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     _imgFromCamera();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // //  Second Container
  // _imgFromCamera2() async {
  //   PickedFile image = await ImagePicker.platform
  //       .pickImage(source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     _image1 = File(image.path);
  //   });
  // }

  // _imgFromGallery2() async {
  //   PickedFile image = await ImagePicker.platform
  //       .pickImage(source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image1 = File(image.path);
  //   });
  // }

  // void _showPicker2(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Photo Library'),
  //                     onTap: () {
  //                       _imgFromGallery2();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     _imgFromCamera2();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
