import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/splashScreenSlider.dart';
import 'Categories.dart';
import 'numberlogin.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification.title}");
}

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {
        runApp(MyApp()),
      });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
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
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    getLogs();
    getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showAlert(
            context: latestContext,
            title: "${message.notification.title}",
            body: "${message.notification.body}");
      }
    });
    super.initState();
  }

  getLogs() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool("showSlider") != true) {
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => SplashScreenSlider()));
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

  getToken() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
      print("FCM TOKEN: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
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
