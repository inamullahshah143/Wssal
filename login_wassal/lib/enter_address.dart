import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import 'const.dart';

class EnterAddress extends StatefulWidget {
  const EnterAddress({Key key}) : super(key: key);

  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  String lat;
  String lng;
  PickResult result;
  LatLng lock;
  LatLng position;
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  // padding: EdgeInsets.all(50),
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/location_mark.png'),
                    ),
                  ),
                ),
                Text(
                  'Find restaurants near you',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Please enter your location or allow access to your\nlocation to find restaurants near you.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      primary: themePrimaryColor,
                    ),
                    child: Text(
                      "Use current location",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: PlacesAutocompleteField(
                    hint: 'Enter a new address',
                    apiKey: googleApiKey,
                    controller: locationController,
                    onSelected: (value) async {
                      List<Placemark> placemark = await Geolocator()
                          .placemarkFromAddress(value.toString());
                      double latitude = placemark[0].position.latitude;
                      double longitude = placemark[0].position.longitude;
                      setState(() {
                        position = LatLng(latitude, longitude);
                      });
                    },
                    leading: Icon(Icons.location_on, color: Colors.grey),
                    inputDecoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
