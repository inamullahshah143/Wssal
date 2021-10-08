import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/dashboard.dart';
import 'package:wassal_customer/splashScreenSlider.dart';

import 'google_map/app_states.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification.title}");
}

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {
        runApp(
          MultiProvider(providers: [
            ChangeNotifierProvider.value(
              value: AppState(),
            )
          ], child: MyApp()),
        ),
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
        Timer(Duration(seconds: 8), () {
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
          Timer(Duration(seconds: 8), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => MainDashboard()),
                (Route<dynamic> route) => false);
          });
        } else {
          Timer(Duration(seconds: 5), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => MainDashboard()),
                (Route<dynamic> route) => false);
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
