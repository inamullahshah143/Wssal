import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'account/LogIn.dart';
import 'function.dart';
import 'dart:convert';

import 'wallet/dashboard/landing_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification.title}");
}

class SplashScreen extends StatefulWidget {
  @override
  createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

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
    startTime();
  }

  getToken() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
      print("FCM TOKEN: $token");
    });
  }

  getLogs() async {
    logs = false;
    SharedPreferences mypref = await SharedPreferences.getInstance();
    var y = mypref.getString('abs');
    // print("$logs");
    print(" Abs = $y");
    if (y != null) {
      stringValue = y;
      logs = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    print("stringValue = $stringValue");
    if (logs) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LandingScreen(),
        ),
      );
      // getProfile() ;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
      );
      //   Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (BuildContext context) => DriverProfile()),
      // );
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) => DriverProfile()),
    // );
  }

  getProfile() async {
    try {
      var url = 'https://wassl.einnovention.tech/api/user/driverrequest';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('response = ${response.body}');
      var data = json.decode(response.body);
      print(data);
      if (data['status'] == 200) {
        print('Ahmad');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LandingScreen(),
          ),
        );
      } else {
        print('Nazir');
      }
    } catch (e) {
      return Text(e);
    }
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Image.asset("assets/Logo_wssal.png"),
        ),
      ),
    );
  }
}

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {
        runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: themePrimaryColor,
          ),
          home: SplashScreen(),
        )),
      });
}

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
