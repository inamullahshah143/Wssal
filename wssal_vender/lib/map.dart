import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wssal_vender/functions.dart';

class Maplocation extends StatefulWidget {
  @override
  _MaplocationState createState() => _MaplocationState();
}

class _MaplocationState extends State<Maplocation> {
  Timer timer;
  var latitude1;
  var longitude1;
  var shoplatitude;
  var shoplongitude;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(milliseconds: 500),
    //     (Timer t) => _getlocation());

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

  // getUserLocations() {
  //   Location location = Location();
  //   location.onLocationChanged.listen((event) {
  //     setState(() {
  //       markers.add(Marker(
  //           markerId: MarkerId("Shop"),
  //           position: LatLng(event.latitude, event.longitude)));
  //     });
  //   });
  // }

  Future<LocationData> getuserLocation() async {
    Location location = Location();
    return location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('MAp'),
      ),
      body: Column(
        children: [
          Container(
            height: height / 4,
            width: width,
            child: FutureBuilder(
              future: getuserLocation(),
              builder: (context, AsyncSnapshot<LocationData> snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: markers,
                    // mapType: MapType.normal,
                    // onMapCreated: (GoogleMapController controller) {

                    // },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            snapshot.data.latitude, snapshot.data.longitude),
                        zoom: 15),
                    onTap: (latlong) {
                      setState(() {
                        print("latitude Taped = ${latlong.latitude}");
                        print("longitude Taped = ${latlong.longitude}");
                        shoplatitude = latlong.latitude;
                        shoplongitude = latlong.longitude;
                        final _snackBar = SnackBar(
                            content: Text('$shoplatitude $shoplongitude'));
                        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        // markers.add(Marker(
                        //     markerId: MarkerId("Shopp"),
                        //     position: LatLng(latitude, longitude)));
                      });
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                } else {
                  return CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  );
                }
              },
            ),
          )
          // Container(
          //   height: height / 4,
          //   width: width,
          //   child: GoogleMap(
          //     initialCameraPosition:
          //         CameraPosition(target: LatLng(latitude1, longitude1), zoom: 15),
          //     // onTap: (latlong) {
          //     //   setState(() {
          //     //     print("latitude Taped = ${latlong.latitude}");
          //     //     print("longitude Taped = ${latlong.longitude}");
          //     //     shoplatitude = latlong.latitude;
          //     //     shoplongitude = latlong.longitude;
          //     //     final _snackBar =
          //     //                 SnackBar(content: Text('$shoplatitude $shoplongitude'));
          //     //                 ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          //     //     // markers.add(Marker(
          //     //     //     markerId: MarkerId("Shopp"),
          //     //     //     position: LatLng(latitude, longitude)));
          //     //   });
          //     // },
          //     markers: markers,
          //   ),
          // ),
        ],
      ),
    );
  }
}
