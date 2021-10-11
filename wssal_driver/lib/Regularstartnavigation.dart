
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pusher/pusher.dart' as push;

import 'ChatPage.dart';

// String _mapStyle;

class RegularOrderNavigationBuilder extends StatelessWidget {
  final Map orderDetails;
  RegularOrderNavigationBuilder({@required this.orderDetails});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegularOrderNavigation(orderDetails: orderDetails),
    );
  }
}

class RegularOrderNavigation extends StatefulWidget {
  final Map orderDetails;
  RegularOrderNavigation({@required this.orderDetails});
  @override
  _RegularOrderNavigationState createState() => _RegularOrderNavigationState(orderDetails: orderDetails);
}

class _RegularOrderNavigationState extends State<RegularOrderNavigation> {
  final Map orderDetails;
  _RegularOrderNavigationState({@required this.orderDetails});
  GoogleMapController mapController;
  BitmapDescriptor deliveryIcon;
  BitmapDescriptor shopIcon;
  BitmapDescriptor customerIcon;
  Set<Marker> _markers = Set<Marker>();
  double pinPillPosition = 1000;
  // Set<Circle> _circles = Set<Circle>();

  @override
  void initState() {
    // rootBundle.loadString('assets/style.txt').then((string) {
    //   _mapStyle = string;
    // });
    setMarkerImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${orderDetails['order_no']} Navigation"),
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
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
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
                                  ['products']['shop']['latitude']),
                              double.parse(orderDetails['ordered_products'][0]
                                  ['products']['shop']['longitude'])),
                          onTap: () {},
                          icon: shopIcon));
                      _markers.add(Marker(
                          markerId: MarkerId("customer"),
                          position: LatLng(
                              double.parse(
                                  orderDetails['user']['address']['lat']),
                              double.parse(
                                  orderDetails['user']['address']['lng'])),
                          onTap: () {},
                          icon: customerIcon));
                    });
                    markerAdd(LatLng(
                        snapshot.data.latitude, snapshot.data.longitude));
                    locationUpdates();
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                      zoom: 14),
                ),
                AnimatedPositioned(
                  bottom: pinPillPosition, right: 0, left: 0,
                  duration: Duration(milliseconds: 200),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 20,
                                offset: Offset.zero,
                                color: Colors.grey.withOpacity(0.5))
                          ]),
                      child: Container(
                        margin: EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  pinPillPosition = 1000;
                                });
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ), // end of Row
                    ), // end of Container
                  ), // end of Align
                ),
              ],
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
    location.getLocation().then((value) {
      //   push.Pusher(
      //     '1266741',
      //     '75277f8cc7ab6202152a',
      //     '5722578c3b137a34832c',
      //     push.PusherOptions(cluster: 'ap2'),
      //   ).trigger(
      //       ["${orderDetails['order_no']}"],
      //       "${orderDetails['order_no']}",
      //       json.encode({
      //         "data": "Driver Location",
      //         "lat": value.latitude,
      //         "lng": value.longitude
      //       })).then((value) {});
    });

    return location.getLocation();
  }

  locationUpdates() {
    Location location = Location();

    location.onLocationChanged().listen((cLoc) {
      push.Pusher(
        '1266741',
        '75277f8cc7ab6202152a',
        '5722578c3b137a34832c',
        push.PusherOptions(cluster: 'ap2'),
      ).trigger(
        ["${orderDetails['order_no']}"],
        "${orderDetails['order_no']}",
        // json.encode({
        //   "data": "Driver Location",
        //   "lat": cLoc.latitude,
        //   "lng": cLoc.longitude
        // })).then((value) {});
        markerAdd(
          LatLng(cLoc.latitude, cLoc.longitude),
        ),
      );

      // mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //     target: LatLng(cLoc.latitude, cLoc.longitude), zoom: 16)));
    });
  }

  setMarkerImages() async {
    deliveryIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/delivery.png');

    shopIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/shop.png');

    customerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/customer.png');
  }

  markerAdd(LatLng pinPosition) {
    setState(() {
      _markers
          .removeWhere((element) => element.markerId == MarkerId("busPointer"));
      _markers.add(Marker(
          markerId: MarkerId("busPointer"),
          position: pinPosition,
          onTap: () {
            setState(() {
              pinPillPosition = 0;
            });
          },
          icon: deliveryIcon));
    });
  }
}
