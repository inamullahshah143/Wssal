import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/SearchPage.dart';
import 'Cart.dart';
import 'google_map/app_states.dart';
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
String yourLocation = '';
BuildContext latestContext;
BuildContext customContext;
String googleApiKey = 'AIzaSyCB-GsSjkYZlAUBB07PROe0zkEqcANHiOQ';
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
String imageURL = 'https://einnovention.co.uk/wassl/public/storage';
String apiURL = 'https://einnovention.co.uk/wassl/public/api';
String domainUrl = 'https://einnovention.co.uk/wassl/public';

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

getAppbar(
    bool haveBackBtn, context, text, bool haveSearchBtn, bool haveCartBtn) {
  return AppBar(
    elevation: 1.0,
    automaticallyImplyLeading: haveBackBtn,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    title: Text("$text"),
    actions: [
      haveSearchBtn == true
          ? IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage()));
              },
              icon: Icon(
                Icons.search,
              ),
            )
          : Container(),
      haveCartBtn == true
          ? IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
            )
          : Container()
    ],
  );
}

getDashboardAppbar(context, text) {
  final appState = Provider.of<AppState>(context);
  return AppBar(
    elevation: 1.0,
    automaticallyImplyLeading: false,
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
            height: 1.5,
            color: themeSecondaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.near_me_rounded, color: themePrimaryColor),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.25,
                  child: Text(
                    "${appState.myLocation}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      height: 1.5,
                      color: text1color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
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

getBottomBar(context) {}

// For Cart

int productPriceValue = 0;
List productExtrasForCart = [];
List finalProductsForCart = [];
int finalPriceForCart = 0;

void sms(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}
