import 'package:flutter/material.dart';

double height;
double width;
String phonenumber;
var stringValue;
var ffccmmTTookkeenn;
bool logs = false;
Color textColor = Color.fromRGBO(164, 172, 186, 1);
Color headingColor = Color.fromRGBO(122, 134, 154, 1);
Color themePrimaryColor = Color.fromRGBO(254, 197, 0, 1);
BuildContext latestContext;

var picBaseURL = 'https://einnovention.co.uk/wassl/public/storage/';
var apiBaseURL = 'https://einnovention.co.uk/wassl/public/api';

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
