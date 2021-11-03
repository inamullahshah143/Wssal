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
import 'package:video_player/video_player.dart';
import 'google_map/app_states.dart';
import 'package:permission_handler/permission_handler.dart';

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
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      supportedLocales: [
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(height: 1.5, fontSize: 14.0),
          bodyText2: TextStyle(height: 1.5, fontSize: 12.0),
          button: TextStyle(height: 1.5, fontSize: 12.0),
        ),
        fontFamily: 'HelveticaNeueLT',
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
  VideoPlayerController _controller;
  Timer timer;
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showAlert(
            context: latestContext,
            title: "${message.notification.title}",
            body: "${message.notification.body}");
      }
    });
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash.mp4')
      ..initialize().then((_) {
        _controller.setPlaybackSpeed(0.5);
        _controller.play();
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          _controller.position.then((value) {
            print("${value.inSeconds}");
            if ("${value.inSeconds}" == "4") {
              getPermission();
            }
          });
        });
      });
  }

  getPermission() {
    Permission.location.status.then((value) {
      if (value.isGranted) {
        getToken();
        getLogs();
      } else {
        Permission.location.request().then((value) {
         
            getPermission();
          
        });
      }
    });
  }

  getLogs() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool("showSlider") != true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SplashScreenSlider()));
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

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => MainDashboard()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => MainDashboard()),
              (Route<dynamic> route) => false);
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
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size?.width ?? 0,
              height: _controller.value.size?.height ?? 0,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _controller.dispose();
  }
}
