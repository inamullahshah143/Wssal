import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';

import 'addBankAccount.dart';
import 'functions.dart';

class PaymentInformayion extends StatefulWidget {
  // const PaymentInformayion({ Key? key }) : super(key: key);

  @override
  _PaymentInformayionState createState() => _PaymentInformayionState();
}

class _PaymentInformayionState extends State<PaymentInformayion> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('Payment Information'),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 100,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Current Balance',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      '8807.00 LE',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Transfer to my Bank account')),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 245, 247, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              // margin: EdgeInsets.only(left: 30),
              height: 100,
              width: width,
              alignment: Alignment.centerLeft,
              child: ListTile(
                leading: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Account Name | Bank Name',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      'Ends with 7009',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: AnimatedIconButton(
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
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(bottom: 10),
              //       child: Text('Account Name | Bank Name',
              //       style: TextStyle(
              //         fontSize: 12
              //       ),
              //       ),
              //     ),
              //     Text('Ends with 7009',
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold
              //     ),
              //     ),
              //   ],
              // )
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Add',
                    style: TextStyle(color: Colors.black),
                  ),
                  WidgetSpan(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddBankAccount()));
                    },
                    child: Text(
                      ' new bank account details',
                      style: TextStyle(color: Colors.red),
                    ),
                  ))
                ]))),
            Container(
                //  alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Row(
                  children: [
                    AnimatedIconButton(
                      size: 30,
                      onPressed: () => print('all icons pressed'),
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.check_box,
                            color: textColor,
                          ),
                          onPressed: () => print('add pressed'),
                        ),
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.check_box_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'I Agree on Terms and Conditions',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),
            InkWell(
              onTap: () {},
              child: Container(
                margin:
                    EdgeInsets.only(top: 35, left: 15, right: 15, bottom: 25),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(244, 245, 247, 1),
                  color: Colors.yellow[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Request Bank Transfer ',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('OR'),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin:
                    EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 15),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(244, 245, 247, 1),
                  color: Colors.yellow[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Request a CASH ',
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Cash Payment Could take up to 24 Hours to be ready',
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
