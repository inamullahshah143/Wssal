import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wassal_customer/No%20Internet/noInternetConnection.dart';
import '../const.dart';

class CustomOrderDetail extends StatefulWidget {
  @override
  _CustomOrderDetailState createState() => _CustomOrderDetailState();
}

class _CustomOrderDetailState extends State<CustomOrderDetail> {
  TabController _tabController;
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
        child: DefaultTabController(
          length: 2,
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
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "$storedName",
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.grey.shade700,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  labelColor: themeSecondaryColor,
                  unselectedLabelColor: Colors.grey[500],
                  controller: _tabController,
                  indicatorColor: themeSecondaryColor,
                  tabs: [
                    Tab(
                      text: 'All Orders',
                    ),
                    Tab(
                      text: 'Active Orders',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
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
                                    strokeWidth: 2,
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
                      FutureBuilder(
                        future: customActiveOrderDetail(context),
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
                                    strokeWidth: 2,
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
            ],
          ),
        ),
      ),
    );
  }
}

Future<Widget> customOrderDetail(BuildContext context) async {
  try {
    var response = await http.get(Uri.parse("$apiURL/customorder"),
        headers: {'Authorization': 'Bearer $loginToken'});
    var data = json.decode(response.body)['data'];
    List<Widget> x = [];
    if (json.decode(response.body)['message'] == 'Order Found Sucessfully!') {
      data.forEach((element) async {
        x.add(
          Card(
            child: ListTile(
              onTap: () {
                getOrderDetails(context, element['id']);
              },
              title: Container(
                width: MediaQuery.of(context).size.width / 1.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order No. ${element['order_no']}'),
                    Text(
                      'Pickup Location: ${element['pick_loc']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Dropoff Location: ${element['drop_loc']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Text('${element['deliveryfeec']}'),
            ),
          ),
        );
      });
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: x),
      );
    } else {
      return Center(
        child: Text('No Order Found'),
      );
    }
  } on Exception catch (e) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => NoInternetConnectionScreen(
              className: CustomOrderDetail(),
            )));
  }
}

getOrderDetails(BuildContext context, int id) async {
  var response = await http.get(Uri.parse("$apiURL/customorder/$id"),
      headers: {'Authorization': 'Bearer $loginToken'});
  var data = json.decode(response.body)['data'];
  if (json.decode(response.body)['message'] == 'Order Found Sucessfully!') {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Order No: ${data['order_no']}'),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pickup Location:',
                style: TextStyle(
                  height: 1.5,
                  color: themeSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${data['pick_loc']}'),
              ),
              Text(
                'Dropoff Location:',
                style: TextStyle(
                  height: 1.5,
                  color: themeSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${data['drop_loc']}'),
              ),
              Text(
                'Distance',
                style: TextStyle(
                  height: 1.5,
                  color: themeSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${data['est_distance']}'),
              ),
              Text(
                'Estimated Time:',
                style: TextStyle(
                  height: 1.5,
                  color: themeSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${data['est_time']}'),
              ),
              Text(
                'Estimated Price:',
                style: TextStyle(
                  height: 1.5,
                  color: themeSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${data['deliveryfeec']}'),
              ),
              data['status'] == 2
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Driver Name',
                          style: TextStyle(
                            height: 1.5,
                            color: themeSecondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              '${data['custome_order_driver']['user']['name']}'),
                        ),
                        Text(
                          'Vehicle ID',
                          style: TextStyle(
                            height: 1.5,
                            color: themeSecondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              '${data['custome_order_driver']['user']['driver_vehicle']['plate_number']}'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                FlutterPhoneDirectCaller.callNumber(
                                    '${data['custome_order_driver']['user']['phone']}');
                              },
                              icon: Icon(Icons.phone),
                            ),
                            IconButton(
                              onPressed: () {
                                sms('', [
                                  '${data['custome_order_driver']['user']['phone']}'
                                ]);
                              },
                              icon: Icon(Icons.message_outlined),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Status',
                          style: TextStyle(
                            height: 1.5,
                            color: themeSecondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: data['status'] == 0
                              ? Text('Watting for driver response')
                              : data['status'] == 1
                                  ? Text('Completed')
                                  : Text(''),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Widget> customActiveOrderDetail(BuildContext context) async {
  var response = await http.get(Uri.parse("$apiURL/customorder"),
      headers: {'Authorization': 'Bearer $loginToken'});
  var data = json.decode(response.body)['data'];
  List<Widget> x = [];
  if (json.decode(response.body)['message'] == 'Order Found Sucessfully!') {
    data.forEach((element) async {
      if (element['status'] == 2) {
        x.add(
          Card(
            child: ListTile(
              onTap: () {
                getOrderDetails(context, element['id']);
              },
              title: Container(
                width: MediaQuery.of(context).size.width / 1.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order No. ${element['order_no']}'),
                    Text(
                      'Pickup Location: ${element['pick_loc']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Dropoff Location: ${element['drop_loc']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Text('${element['deliveryfeec']}'),
            ),
          ),
        );
      } else {
        return Center(
          child: Text('No Order Found'),
        );
      }
    });

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(children: x),
    );
  } else {
    return Center(
      child: Text('No Order Found'),
    );
  }
}
