import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'function.dart';

// import '../env.dart';

class MapBuilder extends StatelessWidget {
  final LatLng position;
  MapBuilder({this.position});
  @override
    Widget build(BuildContext context) {
    latestContext = context;
    return MaterialApp(
      home: MapApp(position: position),
    );
  }
}

class MapApp extends StatefulWidget {
  final LatLng position;
  MapApp({this.position});
  @override
  _MapAppState createState() => _MapAppState(position: position);
}

class _MapAppState extends State<MapApp> {
  final LatLng position;
  _MapAppState({this.position});
  Set<Marker> markers = {};
  @override
  void initState() {
    
    setState(() {
      markers.add(Marker(markerId: MarkerId("driver"), position: position));
      markers.add(Marker(markerId: MarkerId("pickup"), position: LatLng(31.4504, 73.1350)));
      markers.add(Marker(markerId: MarkerId("delivery"), position: LatLng(33.6844, 73.0479)));
    });
    getUserLocations();
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Order Details",
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
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: position, zoom: 15),
        // onTap: (lt){
        //   // setState(() {
        //   //   markers.add(Marker(markerId: markerId))

        //   // });
        // },
        markers: markers,
      ),
    );
  }

  getUserLocations() {
    Location location = Location();
    location.onLocationChanged.listen((event) {
      setState(() {
        markers.add(Marker(
            markerId: MarkerId("driver"),
            position: LatLng(event.latitude, event.longitude)));
      });
    });
  }
}
