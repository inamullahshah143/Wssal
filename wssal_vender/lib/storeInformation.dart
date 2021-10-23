import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wssal_vender/profile.dart';
import 'package:wssal_vender/updateProfile.dart';
import 'functions.dart';

class StoreInformation extends StatefulWidget {
  // const StoreInformation({ Key? key }) : super(key: key);

  @override
  _StoreInformationState createState() => _StoreInformationState();
}

String name;
String email;
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _StoreInformationState extends State<StoreInformation> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Orders",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: buildProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data;
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return Center(child: CircularProgressIndicator()
                            // child: Text('No Orders'),
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
    );
  }

  updateProfile() async {
    var url = 'https://wassl.einnovention.tech/api/vendor/updatevendorinfo';
    var response = await http.post(Uri.parse(url),
        body: {'name': '$name', "email": "$email"},
        headers: {'Authorization': 'Bearer $stringValue'});
    print('updateProfile: ${response.body}');
    var data = json.decode(response.body);
    if (data['message'] == 'Record Updated Successfully !') {
      showAlert(
        context: context,
        title: "Record Updated Successfully !",
        actions: [
          AlertAction(
              text: "Ok ",
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Profile()),
                );
              }),
        ],
        cancelable: true,
      );
    } else {
      AlertAction(
          text: "Ok ",
          isDestructiveAction: true,
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (BuildContext context) => Profile()),
            // );
          });
    }
  }

  Future<Widget> buildProfile() async {
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/vendor/profile';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildProductsResponse: ${response.body}');
      var data = json.decode(response.body);
      print('$data');
      if (data['status'] == 200) {
        return Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: FaIcon(FontAwesomeIcons.male),
                    ),
                    Text(
                      '${data['data']['name']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: FaIcon(FontAwesomeIcons.phone),
                    ),
                    Text(
                      '${data['data']['phone']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: FaIcon(FontAwesomeIcons.google),
                    ),
                    Text(
                      '${data['data']['email']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: FaIcon(FontAwesomeIcons.paypal),
                    ),
                    Text(
                      '${data['data']['paypal_email']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: FaIcon(FontAwesomeIcons.idCard),
                    ),
                    Text(
                      '${data['data']['cnic']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        print("Pressed");
                      },
                      icon: FaIcon(FontAwesomeIcons.mapMarked),
                    ),
                    Text(
                      '${data['data']['address']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 25,
                  left: 25,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,

                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${data['data']['phone']}',
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 25,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '* Phone Number Cannot be changed',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 25,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  Contact Support for more information',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('data = ${data['data']}');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UpdateVenderProfile(data['data'])),
                  );
                  // showAlert(
                  //   context: context,
                  //   title: "Record is Updating please wait",
                  //   actions: [
                  //     AlertAction(
                  //         text: "Ok ",
                  //         isDestructiveAction: true,
                  //         onPressed: () {

                  //         }),
                  //   ],
                  //   cancelable: true,
                  // );
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: 35, left: 15, right: 15, bottom: 10),
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(244, 245, 247, 1),
                    color: Colors.yellow[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Change Information',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Text('NO Data Availabe');
      }
    } catch (e) {
      return Text(e);
    }
  }
}
