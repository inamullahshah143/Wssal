import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:wssal_driver/account/verifyNumber.dart';
import 'package:wssal_driver/function.dart';

import 'LogIn.dart';







String name;
String number;

String countryCode = "+92";

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
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
                    'Hello! Create Account',
                    style: TextStyle(
                        color: Color.fromRGBO(128, 136, 142, 1), fontSize: 25),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?  ',
                    style: TextStyle(color: Color.fromRGBO(180, 186, 198, 1)),
                  ),
                  Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(222, 53, 11, 1)),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,
                child: TextFormField(
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
                      labelText: '   Your Name'),
                )),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 15,
              ),
              // height: 100,
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
                          // color: Colors.green,
                          // margin: EdgeInsets.only(
                          //   top: 10,
                          // ),
                          // height: 63,
                          // width: 88,
                          child: CountryCodePicker(
                            onChanged: (code) {
                              countryCode = "$code";
                            },
                            initialSelection: "+92",
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            showCountryOnly: true,
                            hideMainText: true,
                            // alignLeft: true,
                            // backgroundColor: Colors.green[100],
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
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Text(
                        'By creating an account, you agree to our',
                        style:
                            TextStyle(color: Color.fromRGBO(180, 186, 198, 1)),
                      ))
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Term and Conditions',
                        style: TextStyle(color: Color.fromRGBO(222, 53, 11, 1)),
                      ))),
            ),
            InkWell(
              onTap: () {
                print('number :$number');
                print('name : $name');
                print('name : $countryCode');
                print('$countryCode$number');
                signUp(context);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => Varifyphonenumber(phonenumber)),
                // );
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(224, 226, 227, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    )),
                // alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
signUp(context) async {
  var url = 'https://wassldev.einnovention.tech/api/register';
  var response = await http.post(Uri.parse(url), body: {
    'name': '$name',
    'phone': '$countryCode$number',
    'fcm_token':'$fcmToken',
    'role':  'driver'
  });
  print('Response body: ${response.body}');
  var data = json.decode(response.body);
  print('$data');
  if (data['message'] == 'success') {
    print('Account Created');
    Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LogIn()),
                );
  } else {
    showAlert(
      context: context,
      title: "Account Already Exist",
      actions: [
        AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
            //  Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => LoginPage())),
            ),
      ],
      cancelable: true,
    );
  }
}