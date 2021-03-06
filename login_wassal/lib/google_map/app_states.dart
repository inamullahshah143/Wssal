import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../const.dart';
import 'google_maps_requests.dart';

class AppState with ChangeNotifier {
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  String myLocation;
  double initialLat;
  double initialLng;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;
  AppState() {
    _getUserLocation();
    _loadingInitialPosition();
  }

// ! TO GET THE USERS LOCATION
  void _getUserLocation() async {
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LocationData lock = await Location().getLocation();
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(lock.latitude, lock.longitude);
    _initialPosition = LatLng(lock.latitude, lock.longitude);
    String subThoroughfare = placemark[0].subThoroughfare != ''
        ? '${placemark[0].subThoroughfare}, '
        : '';
    String thoroughfare =
        placemark[0].thoroughfare != '' ? '${placemark[0].thoroughfare}, ' : '';
    String subLocality =
        placemark[0].subLocality != null ? '${placemark[0].subLocality}, ' : '';
    String locality =
        placemark[0].locality != null ? '${placemark[0].locality}, ' : '';
    String administrativeArea = placemark[0].administrativeArea != null
        ? '${placemark[0].administrativeArea}, '
        : '';
    String country =
        placemark[0].country != null ? '${placemark[0].country}' : '';
    myLocation =
        '${subThoroughfare.toString()}${thoroughfare.toString()}${subLocality.toString()}${locality.toString()}${administrativeArea.toString()}${country.toString()}';
    locationController.text = myLocation;
    initialLat = _initialPosition.latitude;
    initialLng = _initialPosition.longitude;
    notifyListeners();
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
      polylineId: PolylineId(_lastPosition.toString()),
      width: 5,
      points: _convertToLatLng(_decodePoly(encondedPoly)),
      color: themeSecondaryColor,
    ));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.add(
      Marker(
          markerId: MarkerId(_lastPosition.toString()),
          position: location,
          infoWindow: InfoWindow(title: address, snippet: "Go Here..."),
          icon: BitmapDescriptor.defaultMarker),
    );
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  // ! SEND REQUEST
  void sendRequest(String startingLocation, String endingLocation) async {
    List<Placemark> startingPlacemark =
        await Geolocator().placemarkFromAddress(startingLocation);
    double startingLatitude = startingPlacemark[0].position.latitude;
    double startingLongitude = startingPlacemark[0].position.longitude;
    LatLng startPoint = LatLng(startingLatitude, startingLongitude);

    List<Placemark> endingPlacemark =
        await Geolocator().placemarkFromAddress(endingLocation);
    double endingLatitude = endingPlacemark[0].position.latitude;
    double endingLongitude = endingPlacemark[0].position.longitude;
    LatLng endPoint = LatLng(endingLatitude, endingLongitude);

    _addMarker(startPoint, startingLocation);
    _addMarker(endPoint, endingLocation);
    String route =
        await _googleMapsServices.getRouteCoordinates(startPoint, endPoint);
    createRoute(route);
    notifyListeners();
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

//  LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}
