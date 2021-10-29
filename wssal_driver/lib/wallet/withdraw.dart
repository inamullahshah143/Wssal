import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../function.dart';
import 'driverwoilet.dart';

class WithdrawRequest extends StatefulWidget {
  // const WithdrawRequest({ Key? key }) : super(key: key);

  @override
  _WithdrawRequestState createState() => _WithdrawRequestState();
}

class _WithdrawRequestState extends State<WithdrawRequest> {
  var balance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "WithDraw Request",
            style: TextStyle(height: 1.5, color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 200,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.only(left: 10),
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
                      balance = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // icon: Icon(
                      //   Icons.calendar_today_outlined,
                      //   color: Color.fromRGBO(193, 199, 208, 1),
                      // ),
                      hintText: 'Enter Ammount',
                      hintStyle: TextStyle(
                          height: 1.5,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(195, 153, 141, 1)
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text('WithDraw'),
                    onPressed: () {
                      buildDeposit();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  buildDeposit() async {
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/wallet';
      var response = await http.post(
        Uri.parse(url),
        body: {
          "balance": "$balance",
          "method": 'paypall',
        },
        headers: {'Authorization': 'Bearer $stringValue'},
      );
      print({
        "balance": "$balance",
        "method": 'paypall',
      });
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('$data');

      if (data['message'] == 'Withdraw Request already submited !') {
        showAlert(
          context: context,
          title: "Withdraw Request already submited !",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DriverWoilet(),
                    ),
                  );
                }),
          ],
          cancelable: true,
        );
      } else if (data['message'] ==
          'Withdraw Amount is grater than Balance amount !') {
        showAlert(
          context: context,
          title: "Not enough funds in your wallet",
          actions: [
            AlertAction(
                text: "Ok ", isDestructiveAction: true, onPressed: () {}),
          ],
          cancelable: true,
        );
      } else {
        showAlert(
          context: context,
          title: "One of your withdraw request is already pending.",
          actions: [
            AlertAction(
                text: "Ok ", isDestructiveAction: true, onPressed: () {}),
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
}
