import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/numberlogin.dart';
import 'package:http/http.dart' as http;
import 'package:wassal_customer/verifynumber.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  String name;
  String number;

  final TextEditingController controller = TextEditingController();
  PhoneNumber country = PhoneNumber(isoCode: 'EG');
  bool tick = false;
  @override
  void initState() {
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
                        style:
                            TextStyle(color: Color.fromRGBO(180, 186, 198, 1)),
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
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
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
                ListTile(
                  leading: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  title: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'By creating an account, you agree to our',
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
                    height: 50,
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signUp(context);
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[800],
                        ),
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

  signUp(context) async {
    print({
      'name': '$name',
      'fcm_token': '$fcmToken',
      'phone': '${number}',
    });
    var url = 'https://einnovention.co.uk/wassl/public/api/register';
    var response = await http.post(Uri.parse(url), body: {
      'name': '$name',
      'fcm_token': '$fcmToken',
      'phone': '${number}',
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
                        builder: (BuildContext context) =>
                            Varifyphonenumber(data)));
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
}
