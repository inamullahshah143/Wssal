import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'const.dart';
import 'dashboard.dart';

class Varifyphonenumber extends StatefulWidget {
  final Map data;
  Varifyphonenumber(this.data);
  @override
  _VarifyphonenumberState createState() => _VarifyphonenumberState(this.data);
}

class _VarifyphonenumberState extends State<Varifyphonenumber> {
  final Map data;
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  _VarifyphonenumberState(this.data);

  String verificationCode;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    // double height = MediaQuery.of(context).size.height;
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
                      height: 1.5,
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
                      height: 1.5,
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
                      height: 1.5, fontSize: 20.0, color: Colors.red[900]),
                  underlineColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  length: 4,
                  onCompleted: (String value) async {
                    print("Value: $value = Data: ${data['data']['otp']}");
                    if ("${data['data']['otp']}" == "$value") {
                      loginToken = data['token'];
                      storedName = data['data']['name'];
                      storedNumber = data['data']['phone'];
                      logs = true;

                      SharedPreferences mypref =
                          await SharedPreferences.getInstance();
                      mypref.setString('abs', '$loginToken');
                      mypref.setString('name', '$storedName');
                      mypref.setString('number', '$storedNumber');
                      print("$loginToken");
                      showAlert(
                        context: context,
                        title: "Login successful",
                        actions: [
                          AlertAction(
                              text: "Ok",
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MainDashboard()),
                                  (Route<dynamic> route) => false,
                                );
                              }),
                        ],
                        cancelable: true,
                      );
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
                    http.post(Uri.parse("$apiURL/login"), body: {
                      "phone": "${data['data']['phone']}",
                      "fcm_token": "$fcmToken",
                    }, headers: {}).then((response) {
                      var data = json.decode(response.body);
                      print("$data");
                      if (data["status"] == 200 &&
                          data["message"] == 'Otp sent. User is found!') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Varifyphonenumber(data)),
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
                      height: 1.5,
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
