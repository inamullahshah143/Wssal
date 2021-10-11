import 'dart:convert';
import 'dart:ui';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../function.dart';

class CustomIncomingOrderDetails extends StatefulWidget {
  final Map orderDetail;
  CustomIncomingOrderDetails(this.orderDetail);

  @override
  _CustomIncomingOrderDetailsState createState() =>
      _CustomIncomingOrderDetailsState(orderDetail);
}

class _CustomIncomingOrderDetailsState
    extends State<CustomIncomingOrderDetails> {
  final Map orderDetail;
  _CustomIncomingOrderDetailsState(this.orderDetail);

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Custom Incoming Order Details",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/app_logo.png'),
            ),
          )
        ],
      ),
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
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${orderDetail['customer_order']['orderuser']['name']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                      '${orderDetail['customer_order']['orderuser']['phone']}'),
                  Container(
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
                                "Order No",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['order_no']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Grand Total",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['deliveryfeec']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                orderDetail['customer_order']
                                            ['payment_method'] ==
                                        'cashondelivery'
                                    ? 'Cash On Delivery'
                                    : orderDetail['customer_order']
                                                ['payment_method'] ==
                                            'walletpayment'
                                        ? 'Wallet Payment'
                                        : '${orderDetail['customer_order']['payment_method']}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Pick Form",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['pick_loc']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Deliver To",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['drop_loc']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Distance",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['est_distance']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Order Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                orderDetail['customer_order']['status'] == 0
                                    ? 'No Driver Assigned'
                                    : '${orderDetail['customer_order']['status']}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  orderDetail['customer_order']['status'] == 0
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: width,
                          child: ElevatedButton(
                            onPressed: () async {
                              var url =
                                  '$apiURL/drivercustomorder/${orderDetail['customer_order']['id']}';
                              http.get(Uri.parse(url), headers: {
                                'Authorization': 'Bearer $stringValue'
                              }).then((response) {
                                if (json.decode(response.body)['message'] ==
                                    "Order Assigned Sucessfully!") {
                                  print(response.body);
                                  showAlert(context: context, title: "Order has been assigned to you");
                                 
                                } else {
                                  print(response.body);
showAlert(context: context, title: "Deliver Your Current Order First.");
                                 
                                }
                              });
                            },
                            child: Text('Accept Order'),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}