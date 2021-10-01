import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wssal_driver/startnavigation.dart';
import 'function.dart';

class OrderDetails extends StatefulWidget {
  final Map orderDetail;
  OrderDetails(this.orderDetail);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(orderDetail);
}

class _OrderDetailsState extends State<OrderDetails> {
  final Map orderDetail;
  _OrderDetailsState(this.orderDetail);
  BitmapDescriptor busIcon;
  Timer timer;
  var latitude;
  var longitude;
  var datetime;
  @override
  void initState() {
    super.initState();

    // _getlocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Order Details",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
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
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> buildOrdersDetails() async {
    var url =
        'https://wassldev.einnovention.tech/api/driver/driverOrderDetail/${orderDetail['id']}';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('buildProductsResponse: ${response.body}');
    Map data = json.decode(response.body)['data'];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromRGBO(244, 245, 247, 1),
          ),
          child: Table(
            children: [
              TableRow(children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Order No",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("${data['order_no']}")),
              ]),
              TableRow(children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("Grand Total",
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("${data['grand_total']}")),
              ]),
              TableRow(children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("Payment Method",
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("${data['payment_method']}")),
              ]),
              TableRow(children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("Order Status",
                        style: TextStyle(fontWeight: FontWeight.w500))),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text("${getStatus({
                        "pending": data['pending'],
                        "process": data['process'],
                        "packing": data['packing'],
                        "shipping": data['shipping'],
                        "delivered": data['delivered'],
                        "cancelled": data['cancelled'],
                      })}"),
                ),
              ]),
            ],
          ),
        ),
        data['driver_id'] == null
            ? Container(
                margin: EdgeInsets.all(25),
                child: Text("No Driver Assigned"),
              )
            : Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color.fromRGBO(244, 245, 247, 1),
                ),
                child: Table(
                  children: [
                    TableRow(children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Deliver To",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text("${data['user']['address']['address']}")),
                    ]),
                    TableRow(children: [
                      Container(
                        margin: EdgeInsets.all(10),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DriverMapBuilder(orderDetails: data)));
                            },
                            child: Text("Start Order"),
                          )),
                    ]),
                  ],
                ),
              ),
      ],
    );
  }
}

String getStatus(Map statuss) {
  String currentStatus = "pending";
  statuss.forEach((key, value) {
    if (value != null) {
      currentStatus = "$key";
    }
  });
  return currentStatus;
}
