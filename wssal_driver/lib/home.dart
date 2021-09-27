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

class Home extends StatefulWidget {
  // const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // Location().getLocation().then((value) {
    //   http.post(Uri.parse("$apiURL/user/addBillingAddress"), headers: {
    //     'Authorization': 'Bearer $stringValue'
    //   }, body: {
    //     "lat": "${value.latitude}",
    //     "lng": "${value.longitude}",
    //     "name": "name",
    //     "company": "company",
    //     "address": "address",
    //     "city": "city",
    //     "country": "country",
    //     "postal_code": "1234",
    //     "phone": "4321",
    //   }).then((response) {
    //     print("Location Send: Bearer ${response.body}");

    //     print("Location Send: Bearer $stringValue");
    //   });
    // });
    // Timer.periodic(Duration(minutes: 3), (timer) {
    //   Location().getLocation().then((value) {
    //     http.post(Uri.parse("$apiURL/user/addBillingAddress"), headers: {
    //       'Authorization': 'Bearer $stringValue'
    //     }, body: {
    //       "lat": "${value.latitude}",
    //       "lng": "${value.longitude}",
    //       "name": "name",
    //       "company": "company",
    //       "address": "address",
    //       "city": "city",
    //       "country": "country",
    //       "postal_code": "1234",
    //       "phone": "4321",
    //     }).then((response) {
    //       print("Location Send: Bearer ${response.body}");
    //       print("Location Send: Bearer $stringValue");
    //     });
    //   });
    // });
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
              "Home",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Image(
                image: AssetImage('assets/app_logo.png'),
              )
            ],
            bottom: const TabBar(
            labelColor: Color.fromRGBO(255, 199, 0, 1),
            labelStyle: TextStyle(color: Color.fromRGBO(255, 199, 0, 1), fontSize: 16, fontWeight: FontWeight.w600),
              tabs: [
                Tab(text: "Regular Orders", ),
                Tab(text: "Custom Orders", ),
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
                            future: buildDriverRegularOrders(),
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
                            future: buildDriverCustomOrders(),
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

  Future<Widget> buildDriverRegularOrders() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/driver/driverOrders';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildDriverRegularOrders: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          x.add(
              // Container(
              //   child: ),
              InkWell(
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
                title: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '\#${element['order_no']}',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        )),
                    RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: Text(
                              "${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(element['created_at']))}",
                              // '${DateTime.parse(element['created_at'].toString())}',
                              style: TextStyle(
                                // fontSize: 15,
                                color: Color.fromRGBO(182, 189, 200, 1),
                              )),
                        ),
                      ]),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                    Text(
                      '${element['payment_method']}',
                      style: TextStyle(
                        // fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'View Details',
                      style: TextStyle(color: Color.fromRGBO(255, 199, 0, 1)))
                ])),
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

   Future<Widget> buildDriverCustomOrders() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/drivercustomorder';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildDriverCustomOrders: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          x.add(
              InkWell(
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
                title: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '\#${element['order_no']}',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        )),
                    RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          child: Text(
                              "${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(element['created_at']))}",
                              // '${DateTime.parse(element['created_at'].toString())}',
                              style: TextStyle(
                                // fontSize: 15,
                                color: Color.fromRGBO(182, 189, 200, 1),
                              )),
                        ),
                      ]),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                    Text(
                      '${element['payment_method']}',
                      style: TextStyle(
                        // fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'View Details',
                      style: TextStyle(color: Color.fromRGBO(255, 199, 0, 1)))
                ])),
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
