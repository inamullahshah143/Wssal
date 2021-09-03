import 'package:flutter/material.dart';

import 'functions.dart';
import 'login_page.dart';

class RequestRejected extends StatefulWidget {
  // const RequestRejected({ Key? key }) : super(key: key);

  @override
  _RequestRejectedState createState() => _RequestRejectedState();
}

class _RequestRejectedState extends State<RequestRejected> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Status'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Request Rejected'),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 35, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 199, 0, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 50,
              width: width,
              child: Align(alignment: Alignment.center, child: Text('OK')),
            ),
          ),
        ],
      ),
    );
  }
}
