import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/numberlogin.dart';
import 'package:http/http.dart' as http;

String countryCode = "+92";
String name;
String number;
bool isEnabled = false;
bool isChecked = false;
bool tick = false;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    super.initState();
    isEnabled = false;
    tick = false;
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                          color: Color.fromRGBO(128, 136, 142, 1),
                          fontSize: 25),
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
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(222, 53, 11, 1)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.5, horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // margin: EdgeInsets.only(left: 30),
                  height: 50,
                  width: width,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your full name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                        if (number != '' && name != '' && isChecked != false) {
                          isEnabled = true;
                        } else {
                          isEnabled = false;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.5),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your valid phone no.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          setState(() {
                            number = value;
                            if (value.length == 10) {
                              tick = true;
                            } else {
                              tick = false;
                            }
                            if (value.length == 10 &&
                                name != '' &&
                                isChecked != false) {
                              isEnabled = true;
                            } else {
                              isEnabled = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 17.5),
                          hintText: 'Phone No',
                          suffixIcon: tick ? Icon(Icons.done) : null,
                          prefixIcon: CountryCodePicker(
                            onChanged: (CountryCode code) {
                              setState(() {
                                countryCode = code.dialCode;
                              });
                            },
                            initialSelection: 'EG',
                            favorite: ['+20', 'EG'],
                            hideMainText: false,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            flagDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
<<<<<<< Updated upstream
              ListTile(
                leading: Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                      if (number != '' && name != '' && isChecked != false) {
                        isEnabled = true;
                      } else {
                        isEnabled = false;
                      }
                    });
                  },
                ),
                title: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'By creating an account, you agree to our',
=======
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                    if (number != '' && name != '' && isChecked != false) {
                      isEnabled = true;
                    } else {
                      isEnabled = false;
                    }
                  });
                },
              ),
                  Text(
                    'By creating an account, you agree to our',
>>>>>>> Stashed changes
                    style: TextStyle(color: Color.fromRGBO(180, 186, 198, 1)),
                  ),
                  TextSpan(
                    text: ' Term and Conditions',
                    style: TextStyle(color: Color.fromRGBO(222, 53, 11, 1)),
                  ),
                ])),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  width: width,
                  child: isEnabled
                      ? ElevatedButton(
                          onPressed: () {
                            signUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            primary: themePrimaryColor,
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            primary: Colors.grey[500],
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

signUp(context) async {
  var url = 'https://wassldev.einnovention.tech/api/register';
  var response = await http.post(Uri.parse(url), body: {
    'name': '$name',
    'fcm_token': '$fcmToken',
    'phone': '$countryCode$number',
  });
  print('Response body: ${response.body}');
  var data = json.decode(response.body);
  print('$data');
  if (data['message'] == 'User registered successfully.') {
    print('Account Created');
    showAlert(
      context: context,
      title: "Account Created Successfully",
      actions: [
        AlertAction(
            text: "Ok ",
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
              );
            }),
      ],
      cancelable: true,
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
