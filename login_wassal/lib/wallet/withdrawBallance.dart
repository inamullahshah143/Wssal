import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wassal_customer/wallet/venderWoilet.dart';
import '../const.dart';

var balance;

class WithdrawRequest extends StatefulWidget {
  @override
  _WithdrawRequestState createState() => _WithdrawRequestState();
}

class _WithdrawRequestState extends State<WithdrawRequest> {
  bool canPress = true;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: getAppbar(true, context, "Withdraw", false, true),
      bottomNavigationBar: getBottomBar(context),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // color: Color.fromRGBO(195, 153, 141, 1)
                          color: Color.fromRGBO(182, 189, 200, 1)),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(215, 89, 70, 1),
                      onPrimary: Colors.white,
                    ),
                    child: Text('WithDraw'),
                    onPressed: () {
                      if (canPress) {
                        setState(() {
                          canPress = false;
                        });
                        buildWithdraw();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  buildWithdraw() async {
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/wallet';
      var response = await http.post(
        Uri.parse(url),
        body: {
          "balance": "$balance",
          "method": 'paypall',
        },
        headers: {'Authorization': 'Bearer $loginToken'},
      );
       setState(() {
                        canPress = true;
                      });
      print({
        "balance": "$balance",
        "method": 'paypall',
      });

      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('$data');

      if (data['message'] == 'Withdraw Request Submit Successfully !') {
        showAlert(
          context: context,
          title: "Withdraw Request Submit Successfully !",
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
      } else if (data['message'] == 'Withdraw Amount is grater than Balance amount !') {
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
