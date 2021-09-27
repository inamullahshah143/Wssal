import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wassal_customer/PayPal/PaypalPayment.dart';
import 'package:wassal_customer/PayPal/paypalFuctions.dart';
import 'package:wassal_customer/wallet/withdrawBallance.dart';
import '../const.dart';

class DriverWoilet extends StatefulWidget {
  @override
  _DriverWoiletState createState() => _DriverWoiletState();
}

class _DriverWoiletState extends State<DriverWoilet> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: pagesBackground,
      appBar: getAppbar(true, context, "Wallet", false, true),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: pagesBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.center,
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
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Depost Details',
                        style: TextStyle(
                          color: text1color,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
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
                  children: [
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            String depositValue = "";
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Enter amount to be deposite',
                                          style: TextStyle(
                                            color: text1color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 25.0,
                                            left: 25.0,
                                            right: 25.0,
                                          ),
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
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: '0.00',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(25),
                                          height: 50,
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            child: Text("Submit"),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                Navigator.pop(context);
                                                amountToDeposit = depositValue;
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PaypalPayment(
                                                      onFinish: (number) async {
                                                        setState(() {});
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
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            primary: themePrimaryColor,
                          ),
                          child: Text(
                            "Deposit",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WithdrawRequest(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            primary: Color.fromRGBO(215, 89, 70, 1),
                            onPrimary: Colors.white,
                          ),
                          child: Text(
                            "WithDraw",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Widget>> buildWoiletRequest() async {
    try {
      List<Widget> x = [];
      var url = 'https://wassldev.einnovention.tech/api/withdrawindex';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $loginToken'});

      String balance = json.decode(response.body)['blance'];
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          Text('NO Data Availabe')
        ];
      } else {
        if (data.length > 0) {
          data.forEach((element) {
            x.add(Container(
                margin: EdgeInsets.only(left: 20, top: 15, right: 20),
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 6),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                )),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'withdraw Details',
                          style: TextStyle(
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
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        Text('$e')
      ];
    }
  }

  Future<Widget> buildDriverDepositRequest() async {
    try {
      List<Widget> x = [];
      var url = 'https://wassldev.einnovention.tech/api/wallet';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $loginToken'});
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
