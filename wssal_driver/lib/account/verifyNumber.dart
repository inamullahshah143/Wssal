import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:wssal_driver/account/driverProfile.dart';
import 'package:wssal_driver/function.dart';

import '../home.dart';


String number;

class Varifyphonenumber extends StatefulWidget {
  final phonenumber;
  Varifyphonenumber(this.phonenumber);
  @override
  _VarifyphonenumberState createState() =>
      _VarifyphonenumberState(this.phonenumber);
}

class _VarifyphonenumberState extends State<Varifyphonenumber> {
  final phonenumber;
  _VarifyphonenumberState(this.phonenumber);
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
                    'We have just sent a code to +923041111111',
                    style: TextStyle(
                        color: Color.fromRGBO(149, 159, 175, 1), fontSize: 16),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              height: 130,
              width: width,
              margin: EdgeInsets.only(top: 17, left: 10, right: 10),
              alignment: Alignment.center,

              child: VerificationCode(
                textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
                underlineColor: Colors.amber,
                keyboardType: TextInputType.number,
                length: 4,
                clearAll: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'clear all',
                    style: TextStyle(
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        color: Colors.blue[700]),
                  ),
                ),
                onCompleted: (String value) {
                  setState(() {
                    number = value;
                    print('Code = $number');
                  });
                },
                onEditing: (bool value) {
                  // setState(() {
                  //   _onEditing = value;
                  // });
                },
              ),
            ),
            InkWell(
              onTap: () {
                   print('Code = $number');
                // phoneverify(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Home()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 199, 0, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: Align(alignment: Alignment.center, child: Text('Next')),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => StoreProfile()),
                // );
              },
              child: Container(
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: Align(
                    alignment: Alignment.center, child: Text('Send again')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 22, right: 20),
              height: 20,
              width: width,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'By Signing up, you agree to our.',
                    style: TextStyle(
                      color: Color.fromRGBO(149, 159, 175, 1),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 22, right: 20),
              height: 20,
              width: width,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Term and Conditions',
                    style: TextStyle(
                      color: Color.fromRGBO(222, 53, 11, 1),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// phoneverify(context) async {
//   var url = 'https://wassl.einnovention.tech/api/getcode';
//   var response = await http.post(Uri.parse(url), body: {
//     // 'name': '$name',
//     'code': '$number1$number2$number3$number4',
//   }
//       // headers: {
//       //   'Accept':'application/json'
//       // }
//       );
//   print('Response body: ${response.body}');
//   var data = json.decode(response.body);
//   print('$data');
//   if (data['status'] == 'success') {
//     // accessToken = data['token'];
//     // print("$accessToken");
//     // print('Login Successfully');
//     // SharedPreferences mypref = await SharedPreferences.getInstance();
//     // mypref.setString('accessToken', '$accessToken');
//     //  logs = true;
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (BuildContext context) => EnterAddress()),
//     );
//   } else {
//     showAlert(
//       context: context,
//       title: "Error ",
//       actions: [
//         AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
//             //  Navigator.push(
//             //     context, MaterialPageRoute(builder: (context) => LoginPage())),
//             ),
//       ],
//       cancelable: true,
//     );
//   }
// }

// sendagain(context) async {
//   var url = 'https://wassl.einnovention.tech/api/login';
//   var response = await http.post(Uri.parse(url), body: {
//     // 'name': '$name',
//     'phone': '$phonenumber',
//   }, headers: {
//     'Accept': 'application/json'
//   });
//   print('Response body: ${response.body}');
//   var data = json.decode(response.body);
//   print('$data');
//   if (data['status'] == 'success') {
//     accessToken = data['token'];
//     print("$accessToken");
//     print('Login Successfully');
//     // SharedPreferences mypref = await SharedPreferences.getInstance();
//     // mypref.setString('accessToken', '$accessToken');
//     //  logs = true;
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (BuildContext context) => Varifyphonenumber(phonenumber)),
//     );
//   } else {
//     showAlert(
//       context: context,
//       title: "Account Not Exist",
//       actions: [
//         AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
//             //  Navigator.push(
//             //     context, MaterialPageRoute(builder: (context) => LoginPage())),
//             ),
//       ],
//       cancelable: true,
//     );
//   }
// }
