import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/SearchPage.dart';
import 'Cart.dart';
import 'numberlogin.dart';

Color text1color = Color.fromRGBO(50, 62, 72, 1);
Color textcolor = Color.fromRGBO(222, 61, 48, 1);
Color backgroundColor = Color.fromRGBO(255, 199, 0, 1);
String phonenumber;
String loginToken;
String storedName;
String storedNumber;
String fcmToken;
bool logs = false;
BuildContext latestContext;

Map<int, Color> colorMap = {
  50: Color.fromRGBO(254, 197, 0, .1),
  100: Color.fromRGBO(254, 197, 0, .2),
  200: Color.fromRGBO(254, 197, 0, .3),
  300: Color.fromRGBO(254, 197, 0, .4),
  400: Color.fromRGBO(254, 197, 0, .5),
  500: Color.fromRGBO(254, 197, 0, .6),
  600: Color.fromRGBO(254, 197, 0, .7),
  700: Color.fromRGBO(254, 197, 0, .8),
  800: Color.fromRGBO(254, 197, 0, .9),
  900: Color.fromRGBO(254, 197, 0, 1),
};
MaterialColor themePrimaryColor = MaterialColor(0xFFFEC500, colorMap);
Color pagesBackground = Color.fromRGBO(244, 245, 247, 1);
Color themeSecondaryColor = Color.fromRGBO(221, 55, 1, 1);
String selectedLocation = '';
bool locationChange = true;
double cureentLat;
double cureentLng;
String imageURL = 'https://wassldev.einnovention.tech/storage';
String apiURL = 'https://wassldev.einnovention.tech/api';
String domainUrl = 'https://wassldev.einnovention.tech';

logoutFunction({@required context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("abs");
  prefs.remove('name');
  prefs.remove('number');
  logs = false;
  loginToken = null;
  storedName = null;
  storedNumber = null;
  Timer(Duration(seconds: 1), () {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  });
}

getAppbar(context, text) {
  return AppBar(
    elevation: 1.0,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    title: Text("$text"),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SearchPage()));
        },
        icon: Icon(
          Icons.search,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        icon: Icon(
          Icons.shopping_cart_outlined,
        ),
      ),
    ],
  );
}

getDashboardAppbar(context, text) {
  return AppBar(
    elevation: 1.0,
    backgroundColor: Colors.white,
    toolbarHeight: 75,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery to',
          style: TextStyle(
            color: themeSecondaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.near_me_rounded, color: themePrimaryColor),
              ),
              WidgetSpan(
                child: Text(
                  'Location',
                  style: TextStyle(
                    color: text1color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              WidgetSpan(
                child: Icon(Icons.arrow_drop_down, color: themeSecondaryColor),
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          height: 50,
          width: 50,
          image: AssetImage('assets/app_logo.png'),
        ),
      ),
    ],
  );
}

getBottomBar(context) {
  //  return Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(30),
  //             topLeft: Radius.circular(30),
  //           ),
  //         ),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(30.0),
  //             topRight: Radius.circular(30.0),
  //           ),
  //           child: BottomNavigationBar(
  //             selectedItemColor: Colors.red,
  //             unselectedItemColor: Colors.grey,
  //             items: <BottomNavigationBarItem>[
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.dashboard_rounded,
  //                     color: Colors.grey,
  //                   ),
  //                   label: ''),
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.explore_rounded,
  //                     color: Colors.grey,
  //                   ),
  //                   label: ''),
  //               BottomNavigationBarItem(
  //                   icon: InkWell(
  //                     onTap: (){
  //                        Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => Ongoing()),
  //             );
  //                     },
  //                     child: Icon(
  //                       Icons.receipt_rounded,
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                   label: ''),
  //               BottomNavigationBarItem(
  //                   icon: Icon(
  //                     Icons.local_offer_rounded,
  //                     color: Colors.grey,
  //                   ),
  //                   label: ''),
  //               BottomNavigationBarItem(
  //                   icon: InkWell(
  //                     onTap: (){
  //                         Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => Profile()),
  //             );

  //                     },
  //                     child: Icon(
  //                       Icons.person_rounded,
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                   label: ''),
  //             ],
  //           ),
  //         ),
  //       );
  // return

  // Container(
  //   padding: EdgeInsets.only(left: 25, right: 25),
  //   decoration: BoxDecoration(
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.grey.withOpacity(0.5),
  //         spreadRadius: 2,
  //         blurRadius: 2,
  //         offset: Offset(0, 3), // changes position of shadow
  //       ),
  //     ],
  //     color: Colors.white,
  //     borderRadius: BorderRadius.only(
  //       topRight: Radius.circular(25),
  //       topLeft: Radius.circular(25),
  //     ),
  //   ),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Container(
  //         child: InkWell(
  //           onTap: () {
  //             Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(builder: (context) => MainCategories()),
  //             );
  //           },
  //           child: Icon(
  //             Icons.dashboard,
  //             color: Colors.grey[600],
  //             size: 26,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         child: InkWell(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => AllShops()),
  //             );
  //           },
  //           child: Icon(
  //             Icons.store,
  //             color: Colors.grey,
  //             size: 30,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         child: InkWell(
  //           onTap: () {
  //             if (logs == true) {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => ProfilePage()),
  //               );
  //             } else {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => LoginPage()),
  //               );
  //             }
  //           },
  //           child: Icon(
  //             Icons.person,
  //             color: Colors.grey,
  //             size: 30,
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  //   height: 60,
  // );
}

// For Cart

int productPriceValue = 0;
List productExtrasForCart = [];
List finalProductsForCart = [];
int finalPriceForCart = 0;

LatLng currentPostion;

