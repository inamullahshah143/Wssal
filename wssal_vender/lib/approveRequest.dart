import 'package:flutter/material.dart';

import 'functions.dart';

class ApproveRequest extends StatefulWidget {
  // const ApproveRequest({ Key? key }) : super(key: key);

  @override
  _ApproveRequestState createState() => _ApproveRequestState();
}

class _ApproveRequestState extends State<ApproveRequest> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Status'),
      ),
      body: Center(
        child: Text('Request Approve'),
      ),
    );
  }
}
