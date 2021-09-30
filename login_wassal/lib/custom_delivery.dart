import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:wassal_customer/google_map/google_maps_requests.dart';
import 'package:wassal_customer/proceed_custom_order.dart';
import 'const.dart';
import 'google_map/app_states.dart';

class CustomDelivery extends StatefulWidget {
  @override
  _CustomDeliveryState createState() => _CustomDeliveryState();
}

class _CustomDeliveryState extends State<CustomDelivery> {
  bool isDriverFound;
  bool driverNotFound;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  String distance = '';
  String time = '';
  String price = '';
  double dLng;
  double dLat;
  double pLng;
  double pLat;
  LatLng position;
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  Set<Marker> _markers = {};
  Set<Polyline> _polyLines = {};
  AppState appStates = AppState();
  @override
  void initState() {
    isDriverFound = false;
    driverNotFound = false;
    position = appStates.initialPosition;
    super.initState();
  }

  @override
  void dispose() {
    _markers.clear();
    _polyLines.clear();
    locationController.text = '';
    destinationController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    setState(() {
      locationController = appState.locationController;
      destinationController = appState.destinationController;
      _markers = appState.markers;
      _polyLines = appState.polyLines;
    });
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
                      target: position,
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: true,
                    markers: _markers,
                    onCameraMove: appState.onCameraMove,
                    polylines: _polyLines,
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
                                apiKey: googleApiKey,
                                controller: locationController,
                                onSelected: (value) async {
                                  List<Placemark> placemark = await Geolocator()
                                      .placemarkFromAddress(value.toString());
                                  double latitude =
                                      placemark[0].position.latitude;
                                  double longitude =
                                      placemark[0].position.longitude;
                                  setState(() {
                                    position = LatLng(latitude, longitude);
                                  });

                                  _markers.clear();
                                  _polyLines.clear();
                                  destinationController.text = '';
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
                                apiKey: googleApiKey,
                                controller: destinationController,
                                onChanged: (value) {
                                  if (locationController.text != '') {
                                    appState.sendRequest(
                                        locationController.text, value);
                                  }
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
                                          context, "Finding Your Driver");
                                    },
                                  );
                                  List<Placemark> pickLocationPlacemark =
                                      await Geolocator().placemarkFromAddress(
                                          appState.locationController.text);
                                  double pickLocationLatitude =
                                      pickLocationPlacemark[0]
                                          .position
                                          .latitude;
                                  pLat = pickLocationPlacemark[0]
                                      .position
                                      .latitude;
                                  double pickLocationLongitude =
                                      pickLocationPlacemark[0]
                                          .position
                                          .longitude;
                                  pLng = pickLocationPlacemark[0]
                                      .position
                                      .longitude;
                                  List<Placemark> dropoffLocationPlacemark =
                                      await Geolocator().placemarkFromAddress(
                                          appState.destinationController.text);
                                  double dropoffLocationLatitude =
                                      dropoffLocationPlacemark[0]
                                          .position
                                          .latitude;
                                  dLat = dropoffLocationPlacemark[0]
                                      .position
                                      .latitude;
                                  double dropoffLocationLongitude =
                                      dropoffLocationPlacemark[0]
                                          .position
                                          .longitude;
                                  dLng = dropoffLocationPlacemark[0]
                                      .position
                                      .longitude;

                                  var response = await http.post(
                                      Uri.parse("$apiURL/finddriver"),
                                      body: {
                                        "pick_lat":
                                            '${pickLocationLatitude.toString()}',
                                        "pick_lng":
                                            '${pickLocationLongitude.toString()}',
                                      },
                                      headers: {
                                        'Authorization': 'Bearer $loginToken',
                                      });
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          "PickLat: $pickLocationLatitude || PickLng: $pickLocationLongitude"));
                                  print(response.body);
                                  _googleMapsServices
                                      .getDistance(
                                          LatLng(pickLocationLatitude,
                                              pickLocationLongitude),
                                          LatLng(dropoffLocationLatitude,
                                              dropoffLocationLongitude))
                                      .then((value) {
                                    setState(() {
                                      distance = value['distance'].toString();
                                      time = value['time'].toString();
                                      var data =
                                          json.decode(response.body)['data'];
                                      if (data['drivers'].isNotEmpty) {
                                        setState(() {
                                          isDriverFound = true;
                                        });
                                      } else {
                                        setState(() {
                                          driverNotFound = true;
                                        });
                                      }
                                      price = (data['perkilometeramount'] *
                                              double.parse(
                                                distance
                                                    .replaceAll(" km", "")
                                                    .replaceAll(",", ""),
                                              ))
                                          .toString();
                                    });
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
                  driverNotFound == true
                      ? Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
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
                            child: Center(
                              child: Text(
                                'Currently there is no drivers avaliable in your area',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  color: themeSecondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
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
                                      Text(
                                        'Pickup Location',
                                        style: TextStyle(
                                          color: themeSecondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          appState.locationController.text,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Text(
                                        'Dropoff Location',
                                        style: TextStyle(
                                          color: themeSecondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          appState.destinationController.text,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Text(
                                        'Estimated Distance',
                                        style: TextStyle(
                                          color: themeSecondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          distance,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Text(
                                        'Estimated Time',
                                        style: TextStyle(
                                          color: themeSecondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          time,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Text(
                                        'Expected Price',
                                        style: TextStyle(
                                          color: themeSecondaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          price,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
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
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (context) {
                                                return ProceedCustomOrder(
                                                  pickupLocation: appState
                                                      .locationController.text,
                                                  dropoffLocation: appState
                                                      .destinationController
                                                      .text,
                                                  estimatedDistance: distance,
                                                  estimatedTime: time,
                                                  expectedPrice: price,
                                                  pickupLatitude: pLat,
                                                  pickupLongitude: pLng,
                                                  dropoffLatitude: dLat,
                                                  dropoffLongitude: dLng,
                                                );
                                              },
                                            );
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
                                            "Proceed",
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
                                            setState(() {
                                              isDriverFound = false;
                                              driverNotFound = false;
                                            });
                                            _markers.clear();
                                            _polyLines.clear();
                                            locationController.text = '';
                                            destinationController.text = '';
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
                                            "Cancel",
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
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
