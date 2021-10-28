import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:wassal_customer/Profile.dart';

import '../../const.dart';

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  String countryCode = "+20";
  String name;
  String phone;

  @override
  void initState() {
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
                              height: 1.5,
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
                        style: TextStyle(height: 1.5, fontSize: 14),
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
                      Padding(
                        padding: EdgeInsets.all(12.5),
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                              height: 1.5, color: Colors.grey, fontSize: 14.0),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your valid phone no.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 14.0,
                        ),
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 17.5),
                          hintText: 'Phone No',
                          prefixIcon: CountryCodePicker(
                            onChanged: (CountryCode code) {
                              setState(() {
                                countryCode = code.dialCode;
                              });
                            },
                            initialSelection: 'EG',
                            favorite: ['+20', 'EG'],
                            hideMainText: false,
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            flagDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      http.post(Uri.parse("$apiURL/user/updateprofile"),
                          headers: {
                            'Authorization': 'Bearer $loginToken'
                          },
                          body: {
                            "name": "$name",
                            "phone": "$countryCode$phone",
                          }).then((response) {
                        print(response.body);
                        if (json.decode(response.body)['Status'] == 200) {
                          storedName = "$name";
                          storedNumber = "$countryCode$phone";
                          Navigator.pop(context);
                          showAlert(
                              context: context,
                              title: "Success",
                              body: "Account Info Updated Successfully",
                              actions: [
                                AlertAction(
                                    text: "ok",
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) => ProfilePage()));
                                    }),
                              ]);
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
                        height: 1.5,
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
