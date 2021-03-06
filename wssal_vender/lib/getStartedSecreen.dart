import 'package:flutter/material.dart';

import 'functions.dart';
import 'home.dart';

class GetStartedSecreen extends StatefulWidget {
  @override
  _GetStartedSecreenState createState() => _GetStartedSecreenState();
}

class _GetStartedSecreenState extends State<GetStartedSecreen> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 300,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/Illustration4.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Hello',
                    style: TextStyle(
                        color: Color.fromRGBO(128, 136, 142, 1), fontSize: 25),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text('To start, please enable your location service'),
              ),
            ),
            InkWell(
              onTap: () async {
                //  _locationData = await location.getLocation();
                //  print('location = $location');
                //  print('_locationData = $_locationData');
                //  onlocationChange();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 199, 0, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: width,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Allow',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
