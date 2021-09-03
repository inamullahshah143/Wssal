import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/splashScreenSlider.dart';
import 'Categories.dart';
import 'numberlogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: themePrimaryColor,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool("showSlider") != true) {
        Timer(Duration(seconds: 3), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => SplashScreenSlider()));
        });
      } else {
        var y = prefs.getString('abs');
        var x = prefs.getString('name');
        var z = prefs.getString('number');
        // print("$logs");
        print(" Abs = $y");
        if (y != null) {
          loginToken = y;
          storedName = x;
          storedNumber = z;
          logs = true;
          Timer(Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => MainCategories()));
          });
        } else {
          Timer(Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginPage()));
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/Logo_wssal.png",
                height: height / 6,
                width: width / 3,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
