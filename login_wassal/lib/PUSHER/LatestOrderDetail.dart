import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../const.dart';
import 'MapNavigation.dart';

class LatestOrderDetail extends StatefulWidget {
  @override
  _LatestOrderDetailState createState() => _LatestOrderDetailState();
}

class _LatestOrderDetailState extends State<LatestOrderDetail> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    //
    return Scaffold(
      bottomNavigationBar: getBottomBar(context),
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(true, context, 'Current Order', false, true),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                "assets/Profile.png",
                                fit: BoxFit.cover,
                              )),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello,",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              Text(
                                "$storedName",
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 20),
                              ),
                            ])
                      ],
                    ),
                    FutureBuilder(
                      future: latestOrderDetail(context),
                      builder: ((context, snap) {
                        if (snap.hasData) {
                          return snap.data;
                        } else if (snap.hasError) {
                          return Text("${snap.error}");
                        } else {
                          return Center(
                              child: Container(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 10,
                                      backgroundColor: Colors.red,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.yellow))));
                        }
                      }),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}

Future<Widget> latestOrderDetail(BuildContext context) async {
  var response = await http.get(Uri.parse("$apiURL/user/latestOrder"),
      headers: {'Authorization': 'Bearer $loginToken'});
  if (json.decode(response.body)['status'] == 200) {
    Map data = json.decode(response.body)['order'];

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
                            "Assigned",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text("${data['driver']['name']}")),
                    ]),
                    TableRow(
                      children: [
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
                                          ParentMap(orderDetails: data)));
                            },
                            child: Text("Track Order"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  } else {
    return Center(child: Text("Order Not Found"));
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
