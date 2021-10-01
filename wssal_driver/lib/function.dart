import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'wallet/dashboard/my_orders.dart';
import 'chat.dart';
import 'wallet/dashboard/incoming_orders.dart';
import 'person/personPage.dart';

String timeinterval;
double width;
double height;
List<Widget> introSliderList = [];
Color textColor = Color.fromRGBO(164, 172, 186, 1);
Color headingColor = Color.fromRGBO(122, 134, 154, 1);
Color themePrimaryColor = Color.fromRGBO(254, 197, 0, 1);
// var accessToken;
var stringValue;
bool logs = false;
String phonenumber;
var userid;
var namee;
var picture;
var picBaseURL = 'https://wassldev.einnovention.tech/storage/';
String imageURL = 'https://wassldev.einnovention.tech/storage';
String apiURL = 'https://wassldev.einnovention.tech/api';
String domainUrl = 'https://wassldev.einnovention.tech';

BuildContext latestContext;
String fcmToken = "";

List users = [
  {"userId": 1, "name": "Ahmad", "pic": "assets/ahmad.jpg"},
  {"userId": 2, "name": "Obaid", "pic": "assets/obaid2.jpg"},
  {"userId": 3, "name": "Kashif", "pic": "assets/kashif.jpg"},
  {"userId": 4, "name": "Hassan", "pic": "assets/hassan.jpg"},
];



List newOrder = [
  {
    "orderid": '#3234',
    "orderImage": "assets/or1.jpg",
    "orderprice": "750",
    "orderquantity": "2",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
    'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 40,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 50,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "Ahmad Shop",
      "ShopAddress": "Brkat market lahore pakistan",
      "ShopImage": "assets/orb1.png",
      "ShopPhone": "03047576506",
    },
    "customer": {
      "customerid": 1,
      "customertitle": "Ali",
      "customerAddress": "Model Town C block lahore pakistan",
      "customerImage": "assets/car1.jpg",
      "customerPhone": "03047576509",
    }
  },
  {
    "orderid": '#3235',
    "orderImage": "assets/or2.jpg",
    "orderprice": "450",
    "orderquantity": "4",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 50,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 45,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "Ahmad Shop",
      "ShopAddress": "Brkat market lahore pakistan",
      "ShopImage": "assets/orb2.jpg",
      "ShopPhone": "03047456506",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Ali khab",
      "customerAddress": "Model Town H block lahore pakistan",
      "customerImage": "assets/car1.png",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3236',
    "orderImage": "assets/or3.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 12,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 17,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb3.png",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3237',
    "orderImage": "assets/or4.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 14,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 1,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb6.png",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3238',
    "orderImage": "assets/or5.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 9,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 4,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb5.png",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3239',
    "orderImage": "assets/or6.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 23,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 9,
      },
      {
        "productid": 3,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 4,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb4.jpg",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
];




List completedOrder = [
  {
    "orderid": '#3234',
    "orderImage": "assets/or1.jpg",
    "orderprice": "750",
    "orderquantity": "2",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
    'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 40,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 50,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "Ahmad Shop",
      "ShopAddress": "Brkat market lahore pakistan",
      "ShopImage": "assets/orb1.png",
      "ShopPhone": "03047576506",
    },
    "customer": {
      "customerid": 1,
      "customertitle": "Ali",
      "customerAddress": "Model Town C block lahore pakistan",
      "customerImage": "assets/car1.jpg",
      "customerPhone": "03047576509",
    }
  },
  {
    "orderid": '#3235',
    "orderImage": "assets/or2.jpg",
    "orderprice": "450",
    "orderquantity": "4",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 50,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 45,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "Ahmad Shop",
      "ShopAddress": "Brkat market lahore pakistan",
      "ShopImage": "assets/orb2.jpg",
      "ShopPhone": "03047456506",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Ali khab",
      "customerAddress": "Model Town H block lahore pakistan",
      "customerImage": "assets/car1.png",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3236',
    "orderImage": "assets/or3.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 12,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 17,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb3.png",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3237',
    "orderImage": "assets/or4.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 14,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 1,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb6.png",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3238',
    "orderImage": "assets/or5.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 9,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 4,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb5.png",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
  {
    "orderid": '#3239',
    "orderImage": "assets/or6.jpg",
    "orderprice": "250",
    "orderquantity": "1",
    "picklatlong": LatLng(31.5010, 74.3216),
    "droplatlong": LatLng(31.4929, 74.3280),
      'products': [
      {
        "productid": 1,
        "producttitle": "double patty burger",
        "productImage": "assets/or1.jpg",
        "productPrice": 23,
      },
      {
        "productid": 2,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 9,
      },
      {
        "productid": 3,
        "producttitle": "triple patty burger",
        "productImage": "assets/or3.jpg",
        "productPrice": 4,
      },
    ],
    "shop": {
      "shopid": 1,
      "Shoptitle": "hassam Shop",
      "ShopAddress": "Link Road lahore pakistan",
      "ShopImage": "assets/orb4.jpg",
      "ShopPhone": "03045678907",
    },
    "customer": {
      "customerid": 2,
      "customertitle": "Sgfh khab",
      "customerAddress": "Model Town S block lahore pakistan",
      "customerImage": "assets/car3.jpg",
      "customerPhone": "03047906509",
    }
  },
];