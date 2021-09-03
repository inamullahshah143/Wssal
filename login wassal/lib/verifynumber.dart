import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'Categories.dart';
import 'const.dart';

String number1;
String number2;
String number3;
String number4;

class Varifyphonenumber extends StatefulWidget {
  final phonenumber;
  Varifyphonenumber(this.phonenumber);
  @override
  _VarifyphonenumberState createState() =>
      _VarifyphonenumberState(this.phonenumber);
}

class _VarifyphonenumberState extends State<Varifyphonenumber> {
  final phonenumber;
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  _VarifyphonenumberState(this.phonenumber);
  @override
  Widget build(BuildContext context) {
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
                        color: Color.fromRGBO(128, 136, 142, 1), fontSize: 22),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'We have just sent a code to $phonenumber',
                    style: TextStyle(
                        color: Color.fromRGBO(149, 159, 175, 1), fontSize: 16),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Container(
                width: width,
                alignment: Alignment.center,
                child: VerificationCode(
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
                  underlineColor: Colors.amber,
                  keyboardType: TextInputType.number,
                  length: 4,
                  onCompleted: (String value) {
                    setState(() {
                      number4 = value;
                      print('Code = $number4');
                    });
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
                height: 60,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainCategories()),
                    );
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
                      fontSize: 18.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainCategories()),
                    );
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
                      fontSize: 18.0,
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
