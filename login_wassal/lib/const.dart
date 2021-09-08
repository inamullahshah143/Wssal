import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/SearchPage.dart';
import 'package:wassal_customer/design_pages/order/Ongoing%20Order.dart';
import 'package:wassal_customer/design_pages/profile/profile.dart';

import 'Cart.dart';
import 'Categories.dart';
import 'Profile.dart';
import 'Stores.dart';
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
    backgroundColor: themePrimaryColor,
    title: Text("$text"),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => SearchPage()));
          },
          icon: Icon(Icons.search)),
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          icon: Icon(Icons.shopping_cart)),
    ],
  );
}

getBottomBar(context) {
   return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.explore_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: InkWell(
                      onTap: (){
                         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ongoing()),
              );
                      },
                      child: Icon(
                        Icons.receipt_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_offer_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: InkWell(
                      onTap: (){
                          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );

                      },
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    label: ''),
              ],
            ),
          ),
        );
  // return Container(
  //   padding: EdgeInsets.only(left: 25, right: 25),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Container(
  //         child: InkWell(
            // onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainCategories()),
              // );
  //           },
  //           child: Icon(
  //             Icons.dashboard,
  //             color: Colors.grey,
  //             size: 30,
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
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => ProfilePage()),
  //             );
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
  //   decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(20),
  //         topLeft: Radius.circular(20),
  //       )),
  // );
}

// For Cart

int productPriceValue = 0;
List productExtrasForCart = [];

List finalProductsForCart = [];
int finalPriceForCart = 0;
