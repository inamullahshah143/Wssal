import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:wssal_driver/person/addBankAccount.dart';

import '../function.dart';

class PaymentInformation extends StatefulWidget {
  // const PaymentInformation({ Key? key }) : super(key: key);

  @override
  _PaymentInformationState createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: 100),
              height: 100,
              width: width,
              color: Colors.white,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Payment Information',
                  style: TextStyle(height: 1.5, fontSize: 30),
                ),
              ),
            ),
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
                        style: TextStyle(height: 1.5, fontSize: 12),
                      ),
                    ),
                    Text(
                      '8807.00 LE',
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        style: TextStyle(height: 1.5, fontSize: 12),
                      ),
                    ),
                    Text(
                      'Ends with 7009',
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
              //       style: TextStyle( height: 1.5,
              //         fontSize: 12
              //       ),
              //       ),
              //     ),
              //     Text('Ends with 7009',
              //     style: TextStyle( height: 1.5,
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
                    style: TextStyle(height: 1.5, color: Colors.black),
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
                      style: TextStyle(height: 1.5, color: Colors.red),
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
                      style: TextStyle(height: 1.5, color: Colors.grey),
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
                    style: TextStyle(height: 1.5, color: Colors.black45),
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
                    style: TextStyle(height: 1.5, color: Colors.black45),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Cash Payment Could take up to 24 Hours to be ready',
                  style: TextStyle(
                      height: 1.5, fontSize: 12, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
