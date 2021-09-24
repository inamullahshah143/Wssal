import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'const.dart';
import 'google_map/app_states.dart';

class CustomDelivery extends StatefulWidget {
  @override
  _CustomDeliveryState createState() => _CustomDeliveryState();
}

class _CustomDeliveryState extends State<CustomDelivery> {
  bool isDriverFound;
  @override
  void initState() {
    isDriverFound = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Delivery'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: appState.initialPosition == null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: appState.locationServiceActive == false,
                    child: Text(
                      "Please enable location services!",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          : SafeArea(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: appState.onCreated,
                    initialCameraPosition: CameraPosition(
                      target: appState.initialPosition,
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: true,
                    markers: appState.markers,
                    onCameraMove: appState.onCameraMove,
                    polylines: appState.polyLines,
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 245, 247, 1),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: PlacesAutocompleteField(
                                hint: 'Pickup Location?',
                                apiKey:
                                    'AIzaSyAMp8UY-G3eUJeinsx6uwK-j0lXFYB_KWo',
                                controller: appState.locationController,
                                onChanged: (value) {
                                  appState.sendRequest(value);
                                },
                                inputDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 245, 247, 1),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: PlacesAutocompleteField(
                                hint: 'Dropoff Location?',
                                apiKey:
                                    'AIzaSyAMp8UY-G3eUJeinsx6uwK-j0lXFYB_KWo',
                                controller: appState.destinationController,
                                onChanged: (value) {
                                  appState.sendRequest(value);
                                },
                                inputDecoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return processLoading(
                                          context, "Find Your Driver");
                                    },
                                  );
                                  List<Placemark> pickLocationPlacemark =
                                      await Geolocator().placemarkFromAddress(
                                          appState.locationController.text);
                                  double pickLocationLatitude =
                                      pickLocationPlacemark[0]
                                          .position
                                          .latitude;
                                  double pickLocationLongitude =
                                      pickLocationPlacemark[0]
                                          .position
                                          .longitude;
                                  List<Placemark> dropoffLocationPlacemark =
                                      await Geolocator().placemarkFromAddress(
                                          appState.destinationController.text);
                                  double dropoffLocationLatitude =
                                      dropoffLocationPlacemark[0]
                                          .position
                                          .latitude;
                                  double dropoffLocationLongitude =
                                      dropoffLocationPlacemark[0]
                                          .position
                                          .longitude;

                                  print(pickLocationLatitude.toString() +
                                      ':' +
                                      pickLocationLongitude.toString());
                                  print(dropoffLocationLatitude.toString() +
                                      ':' +
                                      dropoffLocationLongitude.toString());

                                  var response = await http.post(
                                      Uri.parse("$apiURL/finddriver"),
                                      body: {
                                        "pick_lat":
                                            '${pickLocationLatitude.toString()}',
                                        "pick_lng":
                                            '${pickLocationLongitude.toString()}',
                                      });

                                  print(response.body);
                                  setState(() {
                                    isDriverFound = true;
                                  });

                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                  primary: themePrimaryColor,
                                ),
                                child: Text(
                                  "Find Driver",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isDriverFound == true
                      ? Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pickup Location'),
                                      Text(''),
                                      Text('Dropoff Location'),
                                      Text(''),
                                      Text('Estimated Distance'),
                                      Text('Estimated Time'),
                                      Text('Accepted Price'),
                                      Text('Deriver Details'),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0),
                                            ),
                                            primary: themePrimaryColor,
                                          ),
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // addMarker();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0),
                                            ),
                                            primary: themePrimaryColor,
                                          ),
                                          child: Text(
                                            "Decline",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }

  Widget processLoading(BuildContext context, String message) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 150,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: themeSecondaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Please Wait...',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
