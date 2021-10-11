import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wssal_vender/functions.dart';
import 'package:http/http.dart' as http;

import 'orders.dart';

var productIdd;
// var pic = 'assets/api2.png';
int _currentStep;
StepperType stepperType = StepperType.vertical;

class OrderDetails extends StatefulWidget {
  final idd;
  final prdata;
  OrderDetails(this.idd, this.prdata);
  @override
  _OrderDetailsState createState() => _OrderDetailsState(idd, prdata);
}

class _OrderDetailsState extends State<OrderDetails> {
  final idd;
  final prdata;
  _OrderDetailsState(this.idd, this.prdata);
  @override
  void initState() {
    productIdd = idd;
    print('productIdd = $productIdd');
    print('poradata = $productIdd');
    if (prdata['order']['cancelled'] != null) {
      setState(() {
        print('Ahmad');
        _currentStep = 5;
      });
    } else if (prdata['order']['delivered'] != null) {
      setState(() {
        print('Ahmad');
        _currentStep = 4;
      });
    } else if (prdata['order']['shipping'] != null) {
      setState(() {
        print('Ahmad');
        _currentStep = 3;
      });
    } else if (prdata['order']['packing'] != null) {
      setState(() {
        print('Ahmad');
        _currentStep = 2;
      });
    } else if (prdata['order']['process'] != null) {
      setState(() {
        print('Ahmad');
        _currentStep = 1;
      });
    } else if (prdata['order']['pending'] != null) {
      setState(() {
        print('Ahmad');
        _currentStep = 0;
      });
    } else {
      setState(() {
        print('Ahmad');
        _currentStep = 0;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Orders Details",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          // automaticallyImplyLeading: false,

          // centerTitle: true,
        ),
      ),
      // bottomNavigationBar: getbottomBar(2, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Container(
            margin: EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: buildOrdersDetails(),
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
        ),
      ),
    );
  }

  Future<Widget> buildOrdersDetails() async {
    List<Widget> x = [];
    var url =
        'https://wassldev.einnovention.tech/api/vendor/orderDetail/$productIdd';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('buildProductsResponse: ${response.body}');
    List data = json.decode(response.body)['data'];

    if (data.length > 0) {
      x.add(Column(
        children: [
          
          Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product Details',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          buildOrdersDetail2(data[1]),
        ],
      ));
      x.add(buildOrdersDetail1(data[0]));
      //  x.add(

      //   InkWell(
      //   onTap: (){

      //   },
      //   child: Container(
      //     margin: EdgeInsets.all(10),
      //     padding: EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(9),
      //         border: Border.all(width: 1, color: Colors.grey)),
      //     child: Column(
      //       children: [
      //          Container(
      //            margin: EdgeInsets.all(5),

      //            child: Text(
      //                 // '${element['order_no']}',
      //                 '${data[1]}',
      //                 style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
      //               ),
      //          ),
      //          Divider(
      //            thickness: 1,
      //            color: Colors.grey,
      //          ),

      //       ],
      //     ),
      //   ),
      // ));
      // x.add(buildOrdersDetail1(data[1]));

      return Container(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: x,
        ),
      );
    } else {
      return Text("No Products Available");
    }
  }

  buildOrdersDetail1(dataa) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          // Container(
          //     margin: EdgeInsets.all(5), child: Text("${dataa['order_no']}")),
          //  Container(
          //       margin: EdgeInsets.only(left: 10,right: 10),
          //       child: Divider(
          //         thickness: 0.3,
          //         color: Colors.black,
          //       ),
          //     ),
          Container(
              // margin: EdgeInsets.all(5),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: TextStyle(fontSize: 15),
              ),
              Text(
                '${dataa['grand_total']}',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              thickness: 0.3,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Date',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['created_at'].toString().split('T')[0]}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              thickness: 0.3,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Time',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['created_at'].toString().split('T')[1]}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),

          // buildcustomer(dataa['customer']),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              thickness: 0.3,
              color: Colors.black,
            ),
          ),
          Container(
            height: 500,
            child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    type: stepperType,
                    physics: NeverScrollableScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: new Text('Pending'),
                        content: Text(''),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('process'),
                        content: Text(''),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('packing'),
                        content: Text(''),
                        isActive: _currentStep >= 2,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('shipping'),
                        content: Text(''),
                        isActive: _currentStep >= 3,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('delivered'),
                        content: Text(''),
                        isActive: _currentStep >= 4,
                        state: _currentStep >= 4
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('cancelled'),
                        content: Text(''),
                        isActive: _currentStep >= 5,
                        state: _currentStep >= 5
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  tapped(int step) {
    // setState(() => _currentStep = step);
    setState(() {
      print('object');
      _currentStep = step;
    });
  }

  continued() {
    _currentStep <= 5
        ?
        // setState(() => _currentStep += 1)
        setState(() {
            print("_currentStep = $_currentStep");
            _currentStep += 1;
            if (_currentStep == 0) {
              print("pending");
              buildOrderStatus('pending');
            } else if (_currentStep == 1) {
              print("process");
              buildOrderStatus('process');
            } else if (_currentStep == 2) {
              print("packing");
              buildOrderStatus('packing');
            } else if (_currentStep == 3) {
              print("shipping");
              buildOrderStatus('shipping');
            } else if (_currentStep == 4) {
              print("delivered");
              buildOrderStatus('delivered');
            } else if (_currentStep == 5) {
              print("cancelled");
              buildOrderStatus('cancelled');
            }
          })
        : null;
  }

  cancel() {
    _currentStep > 0
        ?
        // setState(() => _currentStep -= 1)
        setState(() {
            buildOrderStatus('cancelled');
          })
        : null;
  }

  buildOrderStatus(String ele) async {
    var url =
        'https://wassldev.einnovention.tech/api/vendor/updateOrderStatus/$idd';
    var response = await http.post(Uri.parse(url), body: {
      'status': '$ele',
    }, headers: {
      'Authorization': 'Bearer $stringValue'
    });
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');
    if (data['message'] == 'Record Updated Succesfully!') {
      print('$ele');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Orders()),
      );
    }
  }

  buildcustomer(dataa) {
    return Container(
      width: width,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black)),
      child: Column(
        children: [
          // Text('${dataa['phone']}'),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Name',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['name']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Phone',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['phone']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Email',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['email']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'CNIC',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['cnic']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Address',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['address']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          // dataa['image'] = null
          if (dataa['image'] == null) ...[
            Container(
              height: 100,
              width: width,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/api2.png'))),
            ),
          ] else ...[
            Container(
              margin: EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/api2.png',
                image: '$picBaseURL${dataa['image']}',
              ),
            ),
          ],
          // Container(
          //   child: Stepper(
          //       currentStep: 0,
          //       type: stepperType,
          //       physics: ScrollPhysics(),
          //       steps: <Step>[
          //         Step(
          //           title: new Text('Account'),
          //           content: Column(
          //             children: <Widget>[],
          //           ),
          //           isActive: _currentStep >= 0,
          //           state: _currentStep >= 0
          //               ? StepState.complete
          //               : StepState.disabled,
          //         ),
          //         Step(
          //           title: new Text('r'),
          //           content: Column(
          //             children: <Widget>[],
          //           ),
          //           isActive: _currentStep >= 0,
          //           state: _currentStep >= 1
          //               ? StepState.complete
          //               : StepState.disabled,
          //         ),
          //       ]),
          // ),
        ],
      ),
    );
  }

// buildOrdersDetail2(List dataa) {}
  Widget buildOrdersDetail2(List dataa) {
    List<Widget> y = [];
    for (var x in dataa) {
      y.add(Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "\# ${x['order_no']}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  )),
              ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/Logo_wssal.png'),
                            fit: BoxFit.contain)),
                  ),
                  title: Text('${x['quantity']}\X ${x['product_name']}'),
                  trailing: Text('${x['product_price']}')),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price'),
                    Text('${x['product_price']}'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 0.3,
                  color: Colors.black,
                ),
              ),
            ],
          )));
    }
    return Column(
      children: y,
    );
  }
}


 
 