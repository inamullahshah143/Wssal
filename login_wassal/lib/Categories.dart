import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'const.dart';
import 'categorydetail.dart';

class MainCategories extends StatefulWidget {
  @override
  _MainCategoriesState createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {
  Position currentPosition;
  @override
  void initState() {
    determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: getBottomBar(context),
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          // height: 125.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.near_me,
                        size: 24.0,
                        color: themePrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Text(
                              'Delivery To.',
                              style: TextStyle(color: textcolor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Container(
                              width: 200,
                              child: Text(
                                selectedLocation,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/app_logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: height - 225,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                  "assets/Profile.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello,",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                                Text(
                                  "$storedName",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        FutureBuilder(
                          future: mainCategories(context),
                          builder: ((context, snap) {
                            if (snap.hasData) {
                              return snap.data;
                            } else if (snap.hasError) {
                              return Text("${snap.error}");
                            } else {
                              return Center(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.yellow),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Please enable Your Location Service');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentPosition = position;
        selectedLocation =
            "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        locationChange = true;
      });
    } catch (e) {
      print(e);
    }
    return null;
  }
}

Future<Widget> mainCategories(BuildContext context) async {
  var response = await http.get(Uri.parse("$apiURL/category"));
  if (json.decode(response.body)['status'] == 200) {
    List data = json.decode(response.body)['data'];
    List<Widget> x = [];
    data.forEach((element) {
      x.add(
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromRGBO(244, 245, 247, 1),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetail(categoryBlock: element),
                ),
              );
            },
            child: Container(
              height: 300,
              child: Stack(
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(imageURL + '/' + element['thumbnail']),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0),
                            Color.fromRGBO(0, 0, 0, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(7.5),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            element['name'].toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
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
    });
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (2),
        childAspectRatio: 1.3,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: x,
    );
  } else {
    return Center(child: Text("No Products Available"));
  }
}
