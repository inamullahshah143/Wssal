import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wassal_customer/const.dart';
import 'package:http/http.dart' as http;
import 'package:wassal_customer/wallet/venderWoilet.dart';

class ProceedCustomOrder extends StatefulWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final String estimatedDistance;
  final String estimatedTime;
  final String expectedPrice;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final double pickupLatitude;
  final double pickupLongitude;
  ProceedCustomOrder({
    @required this.pickupLocation,
    @required this.dropoffLocation,
    @required this.estimatedDistance,
    @required this.estimatedTime,
    @required this.expectedPrice,
    @required this.dropoffLatitude,
    @required this.dropoffLongitude,
    @required this.pickupLatitude,
    @required this.pickupLongitude,
  });

  @override
  _ProceedCustomOrderState createState() => _ProceedCustomOrderState(
        dropoffLocation: dropoffLocation,
        estimatedDistance: estimatedDistance,
        estimatedTime: estimatedTime,
        expectedPrice: expectedPrice,
        pickupLocation: pickupLocation,
        dropoffLatitude: dropoffLatitude,
        dropoffLongitude: dropoffLongitude,
        pickupLatitude: pickupLatitude,
        pickupLongitude: pickupLongitude,
      );
}

class _ProceedCustomOrderState extends State<ProceedCustomOrder> {
  final String pickupLocation;
  final String dropoffLocation;
  final String estimatedDistance;
  final String estimatedTime;
  final String expectedPrice;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final double pickupLatitude;
  final double pickupLongitude;
  _ProceedCustomOrderState({
    @required this.pickupLocation,
    @required this.dropoffLocation,
    @required this.estimatedDistance,
    @required this.estimatedTime,
    @required this.expectedPrice,
    @required this.dropoffLatitude,
    @required this.dropoffLongitude,
    @required this.pickupLatitude,
    @required this.pickupLongitude,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: BoxDecoration(
        color: pagesBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Custom Delivery',
              style: TextStyle(
                color: text1color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Pickup Location',
                    style: TextStyle(
                      color: themeSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    pickupLocation,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Dropoff Location',
                    style: TextStyle(
                      color: themeSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    dropoffLocation,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Estimated Distance: ',
                      style: TextStyle(
                        color: themeSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: estimatedDistance,
                          style: TextStyle(
                            color: text1color,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Estimated Time: ',
                      style: TextStyle(
                        color: themeSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: estimatedTime,
                          style: TextStyle(
                            color: text1color,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Expected Price: ',
                      style: TextStyle(
                        color: themeSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: expectedPrice,
                          style: TextStyle(
                            color: text1color,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'We are puching your Order',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: themeSecondaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Please Wait...',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                      http.post("$apiURL/customorder", headers: {
                        'Authorization': 'Bearer $loginToken',
                      }, body: {
                        "drop_lng": "$dropoffLongitude",
                        "drop_lat": "$dropoffLatitude",
                        "pick_lng": "$pickupLongitude",
                        "pick_lat": "$pickupLatitude",
                        "deliveryfeec": "$expectedPrice",
                        "payment_method": "cashondelivery"
                      }).then((response) {
                        print("Custom Delivery: ${response.body}");
                        String trackingID =
                            jsonDecode(response.body)['data']['order_no'];
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Your Order has been placed Successfully!',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: themeSecondaryColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Your Order Tracing id is: ${trackingID.toString()}',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      primary: themePrimaryColor,
                    ),
                    child: Text(
                      "Cash on Delivery",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DriverWoilet(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      primary: themePrimaryColor,
                    ),
                    child: Text(
                      "Pay with Wallet",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
