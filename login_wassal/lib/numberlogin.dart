import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/create_account.dart';
import 'package:wassal_customer/verifynumber.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool tick = false;

final TextEditingController controller = TextEditingController();
PhoneNumber country = PhoneNumber(isoCode: 'EG');
String number;

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
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
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ),
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber abc) {
                            setState(() {
                              number = abc.phoneNumber;
                            });
                          },
                          onInputValidated: (bool value) {
                            setState(() {
                              tick = value;
                            });
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          initialValue: country,
                          textFieldController: controller,
                          formatInput: false,
                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Phone No',
                            suffixIcon: tick
                                ? Icon(Icons.check_circle, color: Colors.green)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(number);
                        customerlogin(context);
                      } else {
                        print("ERROR");
                      }
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
                        fontSize: 14.0,
                        color: Colors.grey[800],
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
}

customerlogin(context) async {
  try {
    var url = "https://einnovention.co.uk/wassl/public/api/login";
    var response = await http.post(Uri.parse(url), body: {
      "phone": "${number}",
      "fcm_token": "$fcmToken",
    }, headers: {
      "Accept": "application/json"
    });
    print("respoanse body: ${response.body}");
    var data = json.decode(response.body);
    print("$data");
    if (data["status"] == 200 &&
        data["message"] == 'Otp sent. User is found!') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Varifyphonenumber(data)),
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
