import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pusher_websocket_flutter/pusher.dart';

import 'ChatPage.dart';

class ParentMap extends StatefulWidget {
  final Map orderDetails;
  ParentMap({@required this.orderDetails});
  @override
  _ParentMapState createState() => _ParentMapState(orderDetails: orderDetails);
}

class _ParentMapState extends State<ParentMap> {
  final Map orderDetails;
  _ParentMapState({@required this.orderDetails});
  GoogleMapController mapController;
  BitmapDescriptor deliveryIcon;
  BitmapDescriptor shopIcon;
  BitmapDescriptor customerIcon;
  Set<Marker> _markers = Set<Marker>();
  // Set<Circle> _circles = Set<Circle>();

  @override
  void initState() {
    setMarkerImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${orderDetails['order_no']} Tracking"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ChatPage(orderDetails: orderDetails)),
                );
              },
              icon: Icon(Icons.chat_bubble))
        ],
      ),
      body: FutureBuilder(
        future: getLocation(),
        builder: (context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;

                setMarkerImages();
                setState(() {
                  _markers.add(Marker(
                      markerId: MarkerId("shop"),
                      position: LatLng(
                          double.parse(orderDetails['ordered_products'][0]
                              ['product']['shop']['latitude']),
                          double.parse(orderDetails['ordered_products'][0]
                              ['product']['shop']['longitude'])),
                      onTap: () {},
                      icon: shopIcon));
                  _markers.add(Marker(
                      markerId: MarkerId("customer"),
                      position: LatLng(
                          double.parse(orderDetails['user']['address']['lat']),
                          double.parse(orderDetails['user']['address']['lng'])),
                      onTap: () {},
                      icon: customerIcon));
                });
                markerAdd(
                    LatLng(snapshot.data.latitude, snapshot.data.longitude));
                locationUpdates();
              },
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(snapshot.data.latitude, snapshot.data.longitude),
                  zoom: 14),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<LocationData> getLocation() async {
    Location location = Location();
    return location.getLocation();
  }

  setMarkerImages() async {
    deliveryIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/delivery.png');

    shopIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/shop.png');

    customerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/customer.png');
  }

  locationUpdates() async {
    try {
      await Pusher.init('75277f8cc7ab6202152a', PusherOptions(cluster: 'ap2'));
    } catch (e) {
      print(e);
    }

    Pusher.connect(
      onConnectionStateChange: (value) {
        print("Pusher.connect: ${value.currentState}");
      },
      onError: (e) {
        print(e.message);
      },
    );

    Pusher.subscribe("${orderDetails['order_no']}").then((_channel) {
      _channel.bind('${orderDetails['order_no']}', (event) {
        LatLng cLoc = LatLng(
            double.parse(json.decode(event.data)['lat'].toString()),
            double.parse(json.decode(event.data)['lng'].toString()));
        markerAdd(cLoc);
        mapController.getZoomLevel().then((zoom) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(cLoc.latitude, cLoc.longitude), zoom: zoom)));
        });
      });
    });
    Location location = Location();
    location.onLocationChanged().listen((cLoc) {
      print(cLoc);
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
          icon: deliveryIcon));
    });
  }
}
