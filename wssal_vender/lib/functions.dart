import 'package:flutter/material.dart';
import 'package:wssal_vender/profile.dart';
import 'package:wssal_vender/shops/displayShop.dart';

import 'product/allProduct.dart';
import 'chat.dart';
import 'home.dart';
import 'orders.dart';

double height;
double width;
String phonenumber;
var stringValue;
var ffccmmTTookkeenn;
bool logs = false;
Color textColor = Color.fromRGBO(164, 172, 186, 1);
Color headingColor = Color.fromRGBO(122, 134, 154, 1);

BuildContext latestContext;

var picBaseURL = 'https://wassldev.einnovention.tech/storage/';
var apiBaseURL = 'https://wassldev.einnovention.tech/api';

//  BottomNevigationBar
BottomNavigationBar getbottomBar(page, context) {
  return BottomNavigationBar(
    currentIndex: page,
    // onTap: _onNavigationBarItemClick,
    onTap: (index) {
      if (page == index) {
      } else {
        if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AllProduct()));
        } else if (index == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Orders()));
        } else if (index == 3) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Chat()));
        } else if (index == 4) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        }
      }
    },
    fixedColor: Color.fromRGBO(222, 61, 48, 1),

    unselectedItemColor: Color.fromRGBO(193, 199, 208, 1),
    // selectedItemColor: Color.fromRGBO(111, 82, 148, 1),
    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            "Dashboard",
            style: TextStyle(color: Colors.black),
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.picture_in_picture_alt_outlined),
          title: Text(
            "All Product",
            style: TextStyle(color: Colors.black),
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text(
            "Order",
            style: TextStyle(color: Colors.black),
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text(
            "Chat",
            style: TextStyle(color: Colors.black),
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          )),
      //  BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
      // BottomNavigationBarItem(
      //     icon: Icon(Icons.person),
      //     title: Text(logs != true ? "Login" : "Profile")),
    ],
  );
}

List appetizer = [
  {
    "id": 1,
    "name": "Green Salad",
    "image": "assets/api1.png",
    'price': '4.46',
    'food': 'salad'
  },
  {
    "id": 2,
    "name": "Onion Salad",
    "image": "assets/api2.png",
    'price': '5.46',
    'food': 'salad'
  },
  {
    "id": 3,
    "name": "Green Salad",
    "image": "assets/api1.png",
    'price': '4.46',
    'food': 'salad'
  },
  {
    "id": 4,
    "name": "Onion Salad",
    "image": "assets/api2.png",
    'price': '5.46',
    'food': 'salad'
  },
];
