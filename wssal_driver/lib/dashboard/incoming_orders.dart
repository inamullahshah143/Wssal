import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wssal_driver/IncomingOrdersDetails/CustomOrderDetails.dart';
import 'package:wssal_driver/IncomingOrdersDetails/regularOrderDetails.dart';
import '../function.dart';

class IncomingOrders extends StatefulWidget {
  @override
  _IncomingOrdersState createState() => _IncomingOrdersState();
}

class _IncomingOrdersState extends State<IncomingOrders> {
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
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Incoming Orders",
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
                offset: Offset(0, 0),
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
                      future: buildDriverRegularOrders(),
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
                      future: buildDriverCustomOrders(),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> buildDriverRegularOrders() async {
    List<Widget> x = [];
    try {
      var url =
          'https://einnovention.co.uk/wassl/public/api/driver/driverOrders';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildDriverRegularOrders: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (json.decode(response.body)['status'] == 200) {
        print('data: ${data}');
        data.forEach(
          (element) {
            x.add(
              Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RegularOrderDetails(element['id']),
                      ),
                    );
                  },
                  leading: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/delivery.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          '\#${element['order_no']}',
                          style: TextStyle(
                              height: 1.5, fontSize: 15, color: Colors.black),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Text(
                                "${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(element['created_at']))}",
                                style: TextStyle(
                                  height: 1.5,
                                  color: Color.fromRGBO(182, 189, 200, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${element['payment_method']}',
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Text(
                    '${element['delivery_charges']}',
                    style: TextStyle(
                      height: 1.5,
                      color: Color.fromRGBO(222, 61, 48, 1),
                    ),
                  ),
                ),
              ),
            );
          },
        );
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
          child: Text("No Incoming Orders Available"),
        );
      }
    } catch (e) {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(e),
      );
    }
  }

  Future<Widget> buildDriverCustomOrders() async {
    List<Widget> x = [];
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/drivercustomorder';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Incoming Orders: ${response.body}');
      var data = json.decode(response.body)['data'];
      if (json.decode(response.body)['message'] == 'Order Found Sucessfully!') {
        data.forEach(
          (element) async {
            x.add(
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomIncomingOrderDetails(element),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: ListTile(
                    leading: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: AssetImage('assets/delivery.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\#${element['customer_order']['order_no']}',
                        style: TextStyle(
                            height: 1.5, fontSize: 15, color: Colors.black),
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${element['customer_order']['payment_method']}',
                          style: TextStyle(
                            height: 1.5,
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
                          child: Text(
                            'LE ${element['customer_order']['deliveryfeec']}',
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
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
        child: Text(e),
      );
    }
  }
}
