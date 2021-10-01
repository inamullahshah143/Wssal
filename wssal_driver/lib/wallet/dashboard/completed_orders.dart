import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../function.dart';
import '../../orderDetails.dart';

class CompletedOrders extends StatefulWidget {
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
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
            "Completed Orders",
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
          bottom: const TabBar(
            labelColor: Color.fromRGBO(222, 61, 48, 1),
            unselectedLabelColor: Color.fromRGBO(50, 50, 50, 1),
            indicatorColor: Color.fromRGBO(222, 61, 48, 1),
            tabs: [
              Tab(
                text: "Regular Orders",
              ),
              Tab(
                text: "Custom Orders",
              ),
            ],
          ),
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
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: buildDriverCompletedOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Center(child: Text("${snapshot.error}")),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: buildDriverCompletedOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Center(child: Text("${snapshot.error}")),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
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
          padding: EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: x,
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text("No Orders Available"),
        );
      }
    } catch (e) {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text('No Orders Availabe'),
      );
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
          padding: EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: x,
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text("No Orders Available"),
        );
      }
    } catch (e) {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text('No Orders Availabe'),
      );
    }
  }
}
