import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../const.dart';

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
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Order No'),
                  content: Container(
                    child: Column(
                      children: [
                        Text('Pickup Location:'),
                        Text(''),
                        Text('Dropoff Location:'),
                        Text(''),
                        Text('Distance'),
                        Text(''),
                        Text('Estimated Time:'),
                        Text(''),
                        Text('Estimated Price:'),
                        Text(''),
                        Text('Driver Name'),
                        Text(''),
                        Text('Vehicle ID'),
                        Text(''),
                        Row(
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ),
              );
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
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Dropoff Location: ${element['drop_loc']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
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
    return Column(children: x);
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
