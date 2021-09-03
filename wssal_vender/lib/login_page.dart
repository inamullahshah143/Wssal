import 'dart:convert';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal_vender/register.dart';
import 'package:wssal_vender/store_profile.dart';
import 'package:wssal_vender/verifynumber.dart';
import 'functions.dart';
import 'package:http/http.dart' as http;

var tokenUser;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String countryCode = "+92";
String number;

class _LoginPageState extends State<LoginPage> {
  @override
  @override
  Widget build(BuildContext context) {
    latestContext = context;
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
                  'Welcome Back',
                  style: TextStyle(
                      color: Color.fromRGBO(128, 136, 142, 1), fontSize: 22),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Hello there, sign in to continue!   ',
                  style: TextStyle(
                      color: Color.fromRGBO(149, 159, 175, 1), fontSize: 16),
                )),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CreateAccount()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        'Create new account.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
            ),
            width: width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 245, 247, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Phone Number",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CountryCodePicker(
                          onChanged: (code) {
                            countryCode = "$code";
                          },
                          initialSelection: "+92",
                          textStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                          showCountryOnly: true,
                          hideMainText: true,
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(19)),
                          padding: EdgeInsets.all(5),
                          height: 70,
                          width: 190,
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              number = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              labelText: 'Your Number',
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          )),
                      AnimatedIconButton(
                        size: 20,
                        onPressed: () => print('all icons pressed'),
                        icons: [
                          AnimatedIconItem(
                            icon: Icon(
                              Icons.check_circle,
                              color: textColor,
                            ),
                            onPressed: () => print('add pressed'),
                          ),
                          AnimatedIconItem(
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print('$countryCode$number');
              phonenumber = '$countryCode$number';
              print('phonenumber :$phonenumber');
              // showAlert(
              //   context: context,
              //   title: "Please Wait until Verification Popup",
              //   actions: [
              //     AlertAction(
              //         text: "Ok ", isDestructiveAction: true, onPressed: () {}),
              //   ],
              //   cancelable: true,
              // );

              login(context);
            },
            child: Container(
              margin: EdgeInsets.only(top: 35, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 199, 0, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 50,
              width: width,
              child: Align(alignment: Alignment.center, child: Text('Next')),
            ),
          ),
        ],
      ),
    ));
  }
}

login(context) async {
  try {
    var url = 'https://wassldev.einnovention.tech/api/login';
    var response = await http.post(Uri.parse(url), body: {
      'phone': '$countryCode$number',
      'fcm_token':'$ffccmmTTookkeenn'
    }, headers: {
      'Accept': 'application/json'
    });

    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');

    if (data['status'] == 200 && data['request_status'] == null) {
      showAlert(
        context: context,
        title: "Create Vender Request",
        actions: [
          AlertAction(
              text: "Ok",
              isDestructiveAction: true,
              onPressed: () {
                tokenUser = data['token'];

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          StoreProfile(tokenUser)),
                );
              }),
        ],
        cancelable: true,
      );
    } else if (data['status'] == 200 && data['request_status'] == 0) {
      showAlert(
        context: context,
        title: "Your Request As Vender Rejected ",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}),
        ],
        cancelable: true,
      );
    } else if (data['status'] == 200 && data['request_status'] == 1) {
      stringValue = data['token'];
      SharedPreferences mypref = await SharedPreferences.getInstance();
      mypref.setString('abs', '$stringValue');
      print("$stringValue");
      showAlert(
        context: context,
        title: "Logedin successfully",
        actions: [
          AlertAction(
              text: "Ok",
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Varifyphonenumber(phonenumber)),
                );
              }),
        ],
        cancelable: true,
      );
    } else {
      showAlert(
        context: context,
        title: "Account Not Exist",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}),
        ],
        cancelable: true,
      );
    }
  } on Exception catch (e) {
    showAlert(
      context: context,
      title: "$e",
      actions: [
        AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}),
      ],
      cancelable: true,
    );
  }
}

// requestVender(context) async {
//   var url = 'https://wassl.einnovention.tech/api/vendor/requests';
//   var response = await http.get(
//     Uri.parse(url),
//     headers: {'Authorization': 'Bearer $stringValue'},
//   );
//   print('buildProductsResponse: ${response.body}');
//   var data = json.decode(response.body);

//   if (data['data'][0]['status'] == 0) {
//     print('Ahmad');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => Home(),
//       ),
//     );
//   } else if (data['data'][0]['status'] == 1) {
//     print('Ahmad');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => ApproveRequest(),
//       ),
//     );
//   } else if (data['data'][0]['status'] == 2) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => RequestRejected(),
//       ),
//     );
//   } else {
//     CircularProgressIndicator();
//   }
// }
