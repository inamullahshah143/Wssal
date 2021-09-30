import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'account/displayprofile.dart';
import 'account/driverProfile.dart';
import 'function.dart';
import 'orderDetails.dart';
import 'orderHistory.dart';

class MyOrder extends StatefulWidget {
  // const MyOrder({ Key? key }) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 247, 1),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "My Order",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Image(
                image: AssetImage('assets/app_logo.png'),
              )
            ],
            bottom: const TabBar(
              labelColor: Color.fromRGBO(255, 199, 0, 1),
              labelStyle: TextStyle(
                  color: Color.fromRGBO(255, 199, 0, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              tabs: [
                Tab(
                  text: "Accepted Order",
                ),
                Tab(
                  text: "Completed Orders",
                ),
              ],
            ),
          ),
          bottomNavigationBar: getbottomBar(0, context),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: buildDriverAcceptedOrders(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data;
                              } else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: buildDriverCompletedOrders(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data;
                              } else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  Future<Widget> buildDriverAcceptedOrders() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/processingorder';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildDriverAcceptedOrders: ${response.body}');
      List data = json.decode(response.body)['data'];
if (data.length > 0) {
        data.forEach((element) {
          x.add(InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetails(element)));
            },
            child: Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.black, width: 0.5)),
              child: ListTile(
                leading: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/driver.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '\#${element['customorder']['order_no']}',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${element['customorder']['payment_method']}',
                      style: TextStyle(
                        // fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          http
                              .get("$apiURL/drivercustomorder/${element['id']}")
                              .then((response) {
                                // if () {
                                  
                                // }
                              });
                        },
                        child: Text('Accept Order',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 199, 0, 1),
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        'LE ${element['customorder']['deliveryfeec']}',
                        style: TextStyle(
                          // fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
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
        return Text("No Orders Available");
      }
    } catch (e) {
      return Text('No Orders Availabe');
    }
  }

  Future<Widget> buildDriverCompletedOrders() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/completedorder';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildDriverCustomOrders: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          x.add(InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetails(element)));
            },
            child: Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.black, width: 0.5)),
              child: ListTile(
                leading: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/driver.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '\#${element['customorder']['order_no']}',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${element['customorder']['payment_method']}',
                      style: TextStyle(
                        // fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          http
                              .get("$apiURL/drivercustomorder/${element['id']}")
                              .then((response) {
                                // if () {
                                  
                                // }
                              });
                        },
                        child: Text('Accept Order',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 199, 0, 1),
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        'LE ${element['customorder']['deliveryfeec']}',
                        style: TextStyle(
                          // fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
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
        return Text("No Orders Available");
      }
    } catch (e) {
      return Text('No Orders Availabe');
    }
  }
}
