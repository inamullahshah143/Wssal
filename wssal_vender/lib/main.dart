import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'functions.dart';
import 'home.dart';
import 'login_page.dart';


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
  String fcmToken = "";
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
    startTime();
  }

  getToken() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
        ffccmmTTookkeenn = fcmToken;
        print("ffccmmTTookkeenn = $ffccmmTTookkeenn");
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
    return initScreen(context);
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  // route() {

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
  //   );
  // }

  route() {
    if (logs) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
      );
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (BuildContext context) => StoreProfile()),
    // );
  }

//  requestVender() async {
//     var url = 'https://wassl.einnovention.tech/api/vendor/requests';
//     var response = await http.get(
//       Uri.parse(url),
//       headers: {'Authorization': 'Bearer $stringValue'},
//     );
//     print('buildProductsResponse: ${response.body}');
//     var data = json.decode(response.body);

//     if (data['data'][0]['status'] == 0) {
//       print('Ahmad');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => Home(),
//         ),
//       );
//     } else if (data['data'][0]['status'] == 1) {
//       print('Ahmad');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => ApproveRequest(),
//         ),
//       );
//     } else if (data['data'][0]['status'] == 2) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => RequestRejected(),
//         ),
//       );
//     } else {
//       CircularProgressIndicator();
//     }
//   }

  initScreen(BuildContext context) {
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

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {
        runApp(MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        )),
      });
}
