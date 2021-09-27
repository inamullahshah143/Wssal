import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../const.dart';
import 'MapNavigation.dart';

class CustomOrderDetail extends StatefulWidget {
  @override
  _CustomOrderDetailState createState() => _CustomOrderDetailState();
}

class _CustomOrderDetailState extends State<CustomOrderDetail> {
  @override
  Widget build(BuildContext context) {
    customContext = context;
    return Scaffold(
      backgroundColor: pagesBackground,
      appBar: getAppbar(true, context, 'Custom Orders', false, true),
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
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "$storedName",
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              FutureBuilder(
                future: customOrderDetail(context),
                builder: ((context, snap) {
                  if (snap.hasData) {
                    return snap.data;
                  } else if (snap.hasError) {
                    return Text("${snap.error}");
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            backgroundColor: Colors.red,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Widget> customOrderDetail(BuildContext context) async {
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
                    TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Assigned",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${data['driver']['name']}",
                          ),
                        ),
                      ],
                    ),
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
                                      ParentMap(orderDetails: data),
                                ),
                              );
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
