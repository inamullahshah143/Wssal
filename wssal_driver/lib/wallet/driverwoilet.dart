import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wssal_driver/PayPal/PaypalPayment.dart';
import 'package:wssal_driver/PayPal/paypalFuctions.dart';
import 'package:wssal_driver/wallet/withdraw.dart';

import '../function.dart';

class DriverWoilet extends StatefulWidget {
  // const DriverWoilet({ Key? key }) : super(key: key);

  @override
  _DriverWoiletState createState() => _DriverWoiletState();
}

class _DriverWoiletState extends State<DriverWoilet> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Update Profile",
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  Container(
                      height: height / 4,
                      width: width,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(9)),
                      child: Align(
                        alignment: Alignment.center,
                        // child: Text(
                        //   '\$$b',
                        //   style: TextStyle( height: 1.5,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 19),
                        // ),
                        child: FutureBuilder(
                          future: buildWoiletRequest(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data[0];
                            } else if (snapshot.hasError) {
                              return Center(child: Text("${snapshot.error}"));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Deposit Details',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: buildDriverDepositRequest(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data;
                            } else if (snapshot.hasError) {
                              return Center(child: Text("${snapshot.error}"));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: buildWoiletRequest(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data[1];
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              child: Text('Deposit'),
                              onPressed: () {
                                String depositValue = "";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              right: -40.0,
                                              top: -40.0,
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(Icons.close),
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        depositValue = value;
                                                      },
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return "This field is required";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      maxLength: 6,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              "Deposit Amount"),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      child: Text("Submit"),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          Navigator.pop(
                                                              context);
                                                          amountToDeposit =
                                                              depositValue;
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  PaypalPayment(
                                                                onFinish:
                                                                    (number) async {
                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          print("ERROR");
                                                        }
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              child: Text('WithDraw'),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WithdrawRequest()),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> buildWoiletRequest() async {
    try {
      List<Widget> x = [];
      var url = 'https://einnovention.co.uk/wassl/public/api/withdrawindex';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});

      String balance = json.decode(response.body)['blance'];
      print('buildWoiletRequest: ${balance}');
      List data = json.decode(response.body)['data'];
      print('$data');
      // setState(() {
      //   b = balance['blance'];
      // });
      if (data == null) {
        return [
          Text(
            '\$$balance',
            style: TextStyle(
                height: 1.5,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19),
          ),
          Text('NO Data Availabe')
        ];
      } else {
        if (data.length > 0) {
          data.forEach((element) {
            x.add(Container(
                margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'withdraw Details',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                    Table(border: TableBorder.all(), children: [
                      TableRow(children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text('${element['amount']}')),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text('${element['currency']}'.toString())),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text('${element['method']}'.toString())),
                      ])
                    ]),
                    // Text('${element['currency']}'.toString()),
                  ],
                )));
          });
          return [
            Text(
              '\$$balance',
              style: TextStyle(
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: x,
              ),
            )
          ];
        } else {
          return [
            Text(
              '\$$balance',
              style: TextStyle(
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            Text('NO Data Availabe')
          ];
        }
      }
    } catch (e) {
      return [
        Text(
          '\$ 0.0',
          style: TextStyle(
              height: 1.5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 19),
        ),
        Text('$e')
      ];
    }
  }

  Future<Widget> buildDriverDepositRequest() async {
    try {
      List<Widget> x = [];
      var url = 'https://einnovention.co.uk/wassl/public/api/wallet';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildProductsResponse: ${response.body}');
      // var balance = json.decode(response.body);
      List data = json.decode(response.body)['data'];
      print('$data');
      // setState(() {
      //   b = balance['blance'];
      // });
      if (data != null) {
        if (data.length > 0) {
          data.forEach((element) {
            x.add(Container(
                margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Table(border: TableBorder.all(), children: [
                      TableRow(children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text('${element['amount']}')),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text('${element['currency']}'.toString())),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Text('${element['method']}'.toString())),
                      ])
                    ]),
                    // Text('${element['currency']}'.toString()),
                  ],
                )));
          });
          return Container(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: x,
            ),
          );
        } else {
          return Text('NO Data Availabe');
        }
      } else {
        return Text('NO Data Availabe');
      }
    } catch (e) {
      return Text('$e');
    }
  }
}
