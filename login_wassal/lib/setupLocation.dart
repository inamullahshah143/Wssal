import 'package:flutter/material.dart';

import 'const.dart';

class SetupLocation extends StatefulWidget {
  const SetupLocation({Key key}) : super(key: key);

  @override
  _SetupLocationState createState() => _SetupLocationState();
}

class _SetupLocationState extends State<SetupLocation> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Container(child: Image.asset("assets/Group 1.png")),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Find Resturant Near you",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 25),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                    'Please enter your location or allow access to your location to find resturants near you',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                      "Use Current Location",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  height: 50,
                  width: double.infinity,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter a valid location.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.streetAddress,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 17.5),
                        hintText: 'Enter a new Address',
                        suffix: Icon(Icons.location_on)),
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
