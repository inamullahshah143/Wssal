import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'function.dart';

String _mapStyle;

class StartNavigation extends StatefulWidget {
  @override
  _StartNavigationState createState() => _StartNavigationState();
}

class _StartNavigationState extends State<StartNavigation> {
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor busIcon;
  Set<Marker> _markers = Set<Marker>();
  Timer timer;
  var latitude;
  var longitude;
  var datetime;
  @override
  void initState() {
    super.initState();
    print('object');
    getuserLocation().then((value) {
      print("UUU: ${value.latitude}");
    });
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _getlocation());
    // _getlocation();
    rootBundle.loadString('assets/map.txt').then((string) {
      _mapStyle = string;
    });
    print('Ahmad');
    setMarkerImages();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _getlocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        latitude = value.latitude;
        longitude = value.longitude;
        datetime = DateTime.now();
      });

      print('latitude : $latitude');
      print('longitude : $longitude');
      print("Time: $datetime");
    });
  }

  Future<LocationData> getuserLocation() async {
    Location location = Location();

    return location.getLocation();
  }

  @override
    Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
        appBar: AppBar(actions: [], title: Text("Order")),
        body: FutureBuilder(
          future: getuserLocation(),
          builder: (context, AsyncSnapshot<LocationData> snapshot) {
            if (snapshot.hasData) {
              // return Text(
              //     "${snapshot.data.latitude} \n ${snapshot.data.longitude}");
              return GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers,
                mapType: MapType.normal,
                // onMapCreated: (GoogleMapController controller) {
                //   controller.setMapStyle(_mapStyle);
                //   setMarkerImages();
                //   markerAdd(
                //       LatLng(snapshot.data.latitude, snapshot.data.longitude));
                //   locationUpdates();
                // },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },

                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        snapshot.data.latitude, snapshot.data.longitude)),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              return CircularProgressIndicator(
                backgroundColor: Colors.white,
              );
            }
          },
        ));
  }

  setMarkerImages() async {
    busIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/car2.png');
  }

  locationUpdates() {
    Location location = Location();
    location.onLocationChanged.listen((cLoc) {
      print(cLoc);
      markerAdd(LatLng(cLoc.latitude, cLoc.longitude));
    });
  }

  markerAdd(LatLng pinPosition) {
    print("marker");
    setState(() {
      _markers
          .removeWhere((element) => element.markerId == MarkerId("busPointer"));
      _markers.add(Marker(
          markerId: MarkerId("busPointer"),
          position: pinPosition,
          onTap: () {},
          icon: busIcon));
    });
  }
}
