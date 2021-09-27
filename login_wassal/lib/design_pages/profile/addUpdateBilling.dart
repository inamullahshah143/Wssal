import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;

import '../../const.dart';

class AddUpdateBilling extends StatefulWidget {
  final Map data;
  final LatLng location;
  AddUpdateBilling({@required this.data, @required this.location});
  @override
  _AddUpdateBillingState createState() =>
      _AddUpdateBillingState(data: data, location: location);
}

class _AddUpdateBillingState extends State<AddUpdateBilling> {
  final Map data;
  final LatLng location;
  _AddUpdateBillingState({@required this.data, @required this.location});

  String name;
  String company;
  String address;
  String city;
  String country;
  String postalCode;
  String phone;
  String lat;
  String lng;
  PickResult result;
  LatLng lock;

  @override
  void initState() {
    name = data['name'];
    company = data['company'];
    address = data['address'];
    city = data['city'];
    country = data['country'];
    if (data['postal_code'] != null) {
      postalCode = data['postal_code'].toString();
    }
    phone = data['phone'];
    lat = data['lat'];
    lng = data['lng'];
    lock = location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.1,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Account Information',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        initialValue: name,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'Company',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            company = value;
                          });
                        },
                        cursorColor: Colors.black,
                        initialValue: company,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'Address',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                        cursorColor: Colors.black,
                        initialValue: address,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'City',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            city = value;
                          });
                        },
                        cursorColor: Colors.black,
                        initialValue: city,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'Country',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            country = value;
                          });
                        },
                        cursorColor: Colors.black,
                        initialValue: country,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'Postal Code',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            postalCode = value;
                          });
                        },
                        cursorColor: Colors.black,
                        initialValue: postalCode,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        cursorColor: Colors.black,
                        initialValue: phone,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: ""),
                      ),
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Text(
                      'Location (Coordinates)',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    lat != null && lng != null
                        ? Container(
                            margin: EdgeInsets.all(25),
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                          "Latitude:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        )),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        "$lat",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        "Latitude:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        "$lng",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: 350,
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PlacePicker(
                        apiKey: googleApiKey,
                        initialPosition: lock,
                        useCurrentLocation: false,
                        selectInitialPosition: false,
                        usePlaceDetailSearch: true,
                        forceSearchOnZoomChanged: true,
                        automaticallyImplyAppBarLeading: false,
                        onPlacePicked: (result) {
                          setState(() {
                            lock = LatLng(result.geometry.location.lat,
                                result.geometry.location.lng);
                            lat = result.geometry.location.lat.toString();
                            lng = result.geometry.location.lng.toString();
                          });
                        },
                        pinBuilder: (context, state) {
                          if (state == PinState.Idle) {
                            return Icon(Icons.location_on, color: Colors.red);
                          } else {
                            return Icon(Icons.location_on_outlined,
                                color: Colors.red);
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          http.post(Uri.parse("$apiURL/user/addBillingAddress"),
                              headers: {
                                'Authorization': 'Bearer $loginToken'
                              },
                              body: {
                                "name": "$name",
                                "company": "$company",
                                "address": "$address",
                                "city": "$city",
                                "country": "$country",
                                "postal_code": "$postalCode",
                                "phone": "$phone",
                                "lat": "$lat",
                                "lng": "$lng"
                              }).then((response) {
                            print(response.body);
                            if (json.decode(response.body)['Status'] == 200) {
                              Navigator.pop(context);
                              showAlert(
                                  context: context,
                                  title: "Susscess",
                                  body: "Address added successfully");
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          primary: themePrimaryColor,
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
