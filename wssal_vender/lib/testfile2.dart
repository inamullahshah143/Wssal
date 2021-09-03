import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wssal_vender/functions.dart';

import 'map.dart';

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  var latitude1;
  var longitude1;

  @override
  void initState() {
    super.initState();
    _getlocation();

    // getUserLocations();
  }

  _getlocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        latitude1 = value.latitude;
        longitude1 = value.longitude;

        print('latitude mine : $latitude1');
        print('longitude mine: $longitude1');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //        Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (BuildContext context) =>
            //   Maplocation(position: LatLng(latitude, longitude))),
            // );
          },
          child: Text('map'),
        ),
      ),
    );
  }
}
