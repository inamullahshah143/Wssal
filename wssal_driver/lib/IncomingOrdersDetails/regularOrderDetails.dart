import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../function.dart';

class RegularOrderDetails extends StatefulWidget {
  final int orderID;
  RegularOrderDetails(this.orderID);

  @override
  _RegularOrderDetailsState createState() => _RegularOrderDetailsState(orderID);
}

class _RegularOrderDetailsState extends State<RegularOrderDetails> {
  final int orderID;
  _RegularOrderDetailsState(this.orderID);

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
          "Regular Orders Details",
          style: TextStyle(height: 1.5, color: Colors.black),
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
          ],
        ),
      ),
    );
  }

  Future<Widget> buildOrdersDetails() async {
    var url =
        'https://einnovention.co.uk/wassl/public/api/driver/driverOrderDetail/${orderID}';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('buildProductsResponse: ${response.body}');
    var data = json.decode(response.body)['data'];
    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
    //   double.parse(data['ordered_products'][0]['products']['shop']['latitude']),
    //   double.parse(
    //       data['ordered_products'][0]['products']['shop']['longitude']),
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${data['user']['name']}',
            style: TextStyle(height: 1.5, fontSize: 16),
          ),
        ),
        Text('${data['user']['phone']}'),
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
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${data['order_no']}",
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
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${data['grand_total']}",
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
                      "Delivery Fee",
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${data['delivery_charges']}",
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
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      data['payment_method'] == 'cash_on_delivery'
                          ? 'Cash On Delivery'
                          : data['payment_method'] == 'direct_wallet_payment'
                              ? 'Wallet Payment'
                              : '${data['payment_method']}',
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
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "",
                      // '${placemark[0].thoroughfare} ${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].administrativeArea} ${placemark[0].country}',
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
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "${data['user']['address']['address']} ${data['user']['address']['city']} ${data['user']['address']['country']}",
                      // '${data['user']['address']['address'] + ', ' + "data['user']['address']['city']" + ', ' + data['user']['address']['country']}',
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
                      style:
                          TextStyle(height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "",
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
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                ],
              ),
            ],
          ),
        ),
        data['driver_id'] == null
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: 50,
                    width: width,
                    child: ElevatedButton(
                      onPressed: () async {
                        var response = await http.post(
                            Uri.parse(
                                '$apiURL/vendor/driverResponse/${data['id']}'),
                            body: {"status": '1'},
                            headers: {'Authorization': 'Bearer $stringValue'});
                        print(response.body);
                        if (jsonDecode(response.body)['message'] ==
                            "Kindly deliver your current order!") {
                          showAlert(
                              context: context,
                              title: "Kindly deliver your current order!");
                        } else if (jsonDecode(response.body)['message'] ==
                            "Successfully updated! & Order amount has deducted from your wallet") {
                          showAlert(context: context, title: "Order Accepted!");
                        }
                      },
                      child: Text('Accept Order'),
                    ),
                  ),
                ],
              )
            : Container(),
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
