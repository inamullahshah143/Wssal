import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/create_account.dart';
import 'package:wassal_customer/verifynumber.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool tick = false;
String countryCode = '';
String number;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    tick = false;
    super.initState();
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
                    'Welcome Back',
                    style: TextStyle(
                      color: Color.fromRGBO(128, 136, 142, 1),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Hello there, sign in to continue!   ',
                    style: TextStyle(
                      color: Color.fromRGBO(149, 159, 175, 1),
                      fontSize: 14,
                    ),
                  ),
                ),
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
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateAccount()),
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
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                child: Container(
                  width: width,
                  height: 100.0,
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
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          setState(() {
                            number = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    print('$countryCode$number');
                    phonenumber = "$countryCode$number";
                    print("Phonenumber :$phonenumber");
                    customerlogin(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    primary: themePrimaryColor,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[800],
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

customerlogin(context) async {
  try {
    var url = "https://wassldev.einnovention.tech/api/login";
    var response = await http.post(Uri.parse(url), body: {
      "phone": "$countryCode$number",
      "fcm_token": "$fcmToken",
    }, headers: {
      "Accept": "application/json"
    });
    print("respoanse body: ${response.body}");
    var data = json.decode(response.body);
    print("$data");
    if (data["status"] == 200 &&
        data["message"] == 'Otp sent. User is found!') {
      loginToken = data['token'];
      storedName = data['data']['name'];
      storedNumber = data['data']['phone'];

      SharedPreferences mypref = await SharedPreferences.getInstance();
      mypref.setString('abs', '$loginToken');
      mypref.setString('name', '$storedName');
      mypref.setString('number', '$storedNumber');
      print("$loginToken");
      showAlert(
        context: context,
        title: "Login successfully",
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
