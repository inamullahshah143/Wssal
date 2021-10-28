import 'package:flutter/material.dart';

import 'mapScreen.dart';

class DeliveryLocations extends StatefulWidget {
  const DeliveryLocations({Key key}) : super(key: key);

  @override
  _DeliveryLocationsState createState() => _DeliveryLocationsState();
}

class _DeliveryLocationsState extends State<DeliveryLocations> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 1.1,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Enter Locations',
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      width: 50,
                      height: 50,
                      child: Icon(Icons.location_on_rounded,
                          color: Colors.white, size: 40),
                    ),
                  ),
                  Text(
                    'Enter Delivery Locations',
                    style: TextStyle(
                        height: 1.5, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Enter your location to make your delivery convenient',
                    style: TextStyle(
                        height: 1.5, fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.red,
                      initialValue: 'Hanoi, Vietna',
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on_rounded,
                            color: Colors.red,
                          ),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Enter Locatio Here"),
                    ),
                  ),
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            focusColor: Colors.grey[400],
                            leading: Icon(Icons.near_me_rounded),
                            title: Text('Invite your friends'),
                            trailing: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            subtitle: Text('Get \$5 for each invitation!'),
                          ),
                          ListTile(
                            leading: Icon(Icons.near_me_rounded),
                            title: Text('Invite your friends'),
                            subtitle: Text('Get \$5 for each invitation!'),
                          ),
                          ListTile(
                            leading: Icon(Icons.near_me_rounded),
                            title: Text('Invite your friends'),
                            subtitle: Text('Get \$5 for each invitation!'),
                          ),
                          ListTile(
                            leading: Icon(Icons.near_me_rounded),
                            title: Text('Invite your friends'),
                            subtitle: Text('Get \$5 for each invitation!'),
                          ),
                          ListTile(
                            leading: Icon(Icons.near_me_rounded),
                            title: Text('Invite your friends'),
                            subtitle: Text('Get \$5 for each invitation!'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Save'),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text('OR'),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GMaps(),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Pick From Map'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
