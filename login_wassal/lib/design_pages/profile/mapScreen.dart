import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMaps extends StatefulWidget {
  const GMaps({Key key}) : super(key: key);

  @override
  _GMapsState createState() => _GMapsState();
}

class _GMapsState extends State<GMaps> {
  static const _camera =
      CameraPosition(target: LatLng(31.5009922, 74.3220759), zoom: 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _camera,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            margin: EdgeInsets.only(
                right: 20,
                left: 20,
                top: MediaQuery.of(context).size.height / 1.65),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  minLeadingWidth: 10,
                  leading: Icon(
                    Icons.location_on_rounded,
                    color: Colors.red,
                  ),
                  subtitle: Text(
                    'P783+QP Mit Ghamr City, Madinet Mit Ghamr (Include Daqados), Egypt',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20, top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Location Name E.G. My home",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
