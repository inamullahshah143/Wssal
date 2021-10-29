import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../function.dart';

class Displayprofile extends StatefulWidget {
  // const Displayprofile({ Key? key }) : super(key: key);

  @override
  _DisplayprofileState createState() => _DisplayprofileState();
}

class _DisplayprofileState extends State<Displayprofile> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Profile",
            style: TextStyle(height: 1.5, color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          // automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: getProfile(),
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
    );
  }
}

Future<Widget> getProfile() async {
  try {
    var url = 'https://wassl.einnovention.tech/api/user/driverrequest';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('response = ${response.body}');
    var data = json.decode(response.body)['data'];
    print(data);
    return Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                data['name'],
                style: TextStyle(
                    height: 1.5, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Driver Status',
                    style: TextStyle(
                        height: 1.5, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //   if (element['status'] == 0)
                  //  Text(''),
                  //   else if() ,
                  if (data['status'] == 0) ...[
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Pending'),
                      ),
                    )
                  ] else if (data['status'] == 1) ...[
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Approve'),
                      ),
                    )
                  ] else if (data['status'] == 2) ...[
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Reject'),
                      ),
                    )
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Phone Number',
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10), child: Text(data['phone']))
                  ]),
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'ID Card Number',
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(data['idnumber']))
                  ]),
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'ID Expiry Date',
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(data['idexpiry']))
                  ]),
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Vehicle Name',
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(data['vehiclename']))
                  ]),
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Vehicle Registration Number',
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Text(data['platenumber']))
                  ]),
                  TableRow(children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Vehicle Model',
                        style:
                            TextStyle(height: 1.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10), child: Text(data['modal']))
                  ]),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: height / 5,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  image: DecorationImage(
                      image: NetworkImage('$picBaseURL${data['photo']}'),
                      fit: BoxFit.contain)),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: height / 5,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  image: DecorationImage(
                      image: NetworkImage('$picBaseURL${data['idpicture']}'),
                      fit: BoxFit.contain)),
            )
          ],
        ));
  } catch (e) {
    return Text(e);
  }
}
