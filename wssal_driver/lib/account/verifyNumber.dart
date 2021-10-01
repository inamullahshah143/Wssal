import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal_driver/dashboard/landing_screen.dart';
import '../function.dart';
import 'driverProfile.dart';

class Varifyphonenumber extends StatefulWidget {
  final Map data;
  final bool islogin;
  Varifyphonenumber(this.data, this.islogin);
  @override
  _VarifyphonenumberState createState() =>
      _VarifyphonenumberState(this.data, this.islogin);
}

class _VarifyphonenumberState extends State<Varifyphonenumber> {
  final Map data;
  final bool islogin;
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  _VarifyphonenumberState(this.data, this.islogin);

  String verificationCode;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 300,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/Illustration4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Verify phone number',
                    style: TextStyle(
                      color: Color.fromRGBO(128, 136, 142, 1),
                      fontSize: 18,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'We have just sent a code to $phonenumber',
                    style: TextStyle(
                      color: Color.fromRGBO(149, 159, 175, 1),
                      fontSize: 14,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Container(
                width: width,
                alignment: Alignment.center,
                child: VerificationCode(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red[900],
                  ),
                  underlineColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  length: 4,
                  onCompleted: (String value) async {
                    if ("${data['data']['otp']}" == "$value") {
                      if (data['status'] == 200 &&
                          data['request_status'] == null) {
                        if (islogin == true) {
                          showAlert(
                            context: context,
                            title: "Your request as Driver is in progress",
                            actions: [
                              AlertAction(
                                  text: "Ok ",
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ],
                            cancelable: true,
                          );
                        } else {
                          showAlert(
                            context: context,
                            title: "Create Driver Request",
                            actions: [
                              AlertAction(
                                  text: "Ok ",
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DriverProfile(
                                          drivertoken: data['token'],
                                          phoneNo: phonenumber,
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                            cancelable: true,
                          );
                        }
                      } else if (data['status'] == 200 &&
                          data['request_status'] == 0) {
                        showAlert(
                          context: context,
                          title: "Your Request As Driver Rejected ",
                          actions: [
                            AlertAction(
                                text: "Ok ",
                                isDestructiveAction: true,
                                onPressed: () {}),
                          ],
                          cancelable: true,
                        );
                      } else if (data['status'] == 200 &&
                          data['request_status'] == 1) {
                        stringValue = data['token'];

                        SharedPreferences mypref =
                            await SharedPreferences.getInstance();
                        mypref.setString('abs', '$stringValue');

                        showAlert(
                          context: context,
                          title: "Login successful",
                          actions: [
                            AlertAction(
                                text: "Ok",
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LandingScreen(),
                                    ),
                                  );
                                }),
                          ],
                          cancelable: true,
                        );
                      }
                    } else {
                      showAlert(
                          context: context,
                          title: "Error",
                          body: "Incorrect OTP");
                    }
                  },
                  onEditing: (bool value) {
                    // setState(() {
                    //   _onEditing = value;
                    // });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    http.post(
                        Uri.parse(
                            "https://wassldev.einnovention.tech/api/login"),
                        body: {
                          "phone": "${data['data']['phone']}",
                          "fcm_token": "$fcmToken",
                        },
                        headers: {}).then((response) {
                      var data = json.decode(response.body);
                      print("$data");
                      if (data["status"] == 200 &&
                          data["message"] == 'Otp sent. User is found!') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Varifyphonenumber(
                                    data,
                                    true,
                                  )),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    primary: Colors.grey[200],
                  ),
                  child: Text(
                    "Send Again",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
