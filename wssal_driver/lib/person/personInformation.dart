import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../function.dart';
import '../updateDriverProfile.dart';

class PersonInformation extends StatefulWidget {
  // const PersonInformation({ Key? key }) : super(key: key);

  @override
  _PersonInformationState createState() => _PersonInformationState();
}

class _PersonInformationState extends State<PersonInformation> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Personal Information",
            style: TextStyle(color: Colors.black),
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
        child: Container(
          color: Colors.white,
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
      ),
    );
  }

  Future<Widget> buildProfile() async {
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/driver/profile';
      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $stringValue'
      });
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
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Driver Profile',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  )),
              Divider(
                thickness: 0.2,
                color: Colors.grey,
              ),
              CircleAvatar(
                radius: 93.0,
                backgroundImage:
                    NetworkImage("$picBaseURL${data['data']['avatar']}"),
                backgroundColor: Colors.transparent,
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
                width: width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Vehicle Profile',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          )),
                    ),
                    Divider(
                      thickness: 0.2,
                      color: Colors.grey,
                    ),
                    CircleAvatar(
                      radius: 93.0,
                      backgroundImage: NetworkImage(
                          "$picBaseURL${data['data']['driver_vehicle']['id_picture']}"),
                      backgroundColor: Colors.transparent,
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
                            icon: FaIcon(FontAwesomeIcons.bicycle),
                          ),
                          Text(
                            '${data['data']['driver_vehicle']['vehicle_name']}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            icon: FaIcon(FontAwesomeIcons.bookMedical),
                          ),
                          Text(
                            '${data['data']['driver_vehicle']['plate_number']}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            icon: FaIcon(FontAwesomeIcons.calendar),
                          ),
                          Text(
                            '${data['data']['driver_vehicle']['modal']}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            icon: FaIcon(FontAwesomeIcons.idCardAlt),
                          ),
                          Text(
                            '${data['data']['driver_vehicle']['id_number']}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            icon: FaIcon(FontAwesomeIcons.idCardAlt),
                          ),
                          Text(
                            '${data['data']['driver_vehicle']['id_expiry']}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            icon: FaIcon(FontAwesomeIcons.idCardAlt),
                          ),
                          Text(
                            '${data['data']['driver_vehicle']['id_expiry']}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                            UpdateDriverProfile(data['data'])),
                  );
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
