import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wassal_customer/PUSHER/LatestOrderDetail.dart';
import 'package:wassal_customer/wallet/venderWoilet.dart';
import 'const.dart';
import 'design_pages/profile/addUpdateBilling.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool status = true;
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    latestContext = context;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(context, 'Profile Page'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 80,
                    height: 80,
                    image: AssetImage('assets/Profile.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$storedName',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                  ),
                  Text(
                    '$storedNumber',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w100,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'General',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          title: Text('Account Information'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Change your Account information'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DriverWoilet()),
                            );
                          },
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          title: Text('Wallet'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Add money to wallet'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LatestOrderDetail()),
                            );
                          },
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.list),
                            ],
                          ),
                          title: Text('Order'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Latest Order Details'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {
                            http.get(
                                Uri.parse("$apiURL/user/getBillingAddress"),
                                headers: {
                                  'Authorization': 'Bearer $loginToken'
                                }).then((response) {
                              print("getBillingAddress: ${response.body}");
                              if (response.statusCode == 200) {
                                Location().getLocation().then((location) {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => AddUpdateBilling(
                                        data:
                                            json.decode(response.body)['data'],
                                        location: LatLng(location.latitude,
                                            location.longitude)),
                                  );
                                });
                              }
                            });
                          },
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          title: Text('Delivery Locations'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Change your Delivery Locations'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_long_rounded,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          title: Text('BIlling Information'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Set your billing info'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' @',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          title: Text('Invite your friends'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Get \$5 for each invitation!'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          title: Text('Notifications'),
                          trailing: CupertinoSwitch(
                            activeColor: Colors.red,
                            value: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                          // Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('You will recieve daily updates'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          title: Text('Promotional Notifications'),
                          trailing: CupertinoSwitch(
                            activeColor: Colors.red,
                            value: _status,
                            onChanged: (value1) {
                              setState(() {
                                _status = value1;
                              });
                            },
                          ),
                          subtitle: Text('Get notified when promotions'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'More',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          title: Text('Rate us'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('You will recieve daily updates'),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_copy_rounded,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          title: Text('FAQ'),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          subtitle: Text('Frequently Asked Questions'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  logoutFunction(context: context);
                },
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  primary: themePrimaryColor,
                ),
                child: Text(
                  "Logout",
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
    );
  }
}
