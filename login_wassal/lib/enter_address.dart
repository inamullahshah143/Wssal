import 'package:flutter/material.dart';

import 'enter_address_filled.dart';

class EnterAddress extends StatefulWidget {
  const EnterAddress({Key key}) : super(key: key);

  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              // padding: EdgeInsets.all(50),
              child: const Center(
                child: Image(
                  image: AssetImage('assets/images/location_mark.png'),
                ),
              ),
            ),
            Text(
              'Find restaurants near you',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Please enter your location or allow access to your\nlocation to find restaurants near you.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  fixedSize: Size(MediaQuery.of(context).size.width - 60, 45),
                  primary: const Color.fromRGBO(255, 199, 0, 1),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnterAddressFilled(),
                    ),
                  );
                },
                child: const Text(
                  'Use current location',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromRGBO(244, 245, 247, 1),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.location_on_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      isDense: true,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 40, top: 15),
                      hintText: "Enter a new address",
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(118, 129, 150, 1),
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
