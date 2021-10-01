import 'dart:convert';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
// import 'package:pusher/pusher.dart' as ahmad;
import 'package:pusher_websocket_flutter/pusher.dart';
import 'function.dart';

class Chat extends StatefulWidget {
  // const Chat({ Key? key }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<ChatMessage> _messages = [];
  Channel _channel;
  @override
  void initState() {
    _getMsg();
    super.initState();
  }

  _getMsg() async {
    try {
      Pusher.init("9ad69659971df101b114", PusherOptions(cluster: "ap1"));
    } catch (e) {
      print(e);
    }

    Pusher.connect(onConnectionStateChange: (val) {
      print(val.currentState);
    }, onError: (err) {
      print(err.message);
    });

    _channel = await Pusher.subscribe("Geotv");

    _channel.bind("morning", (onEvent) {
      setState(() {
        _messages.add(ChatMessage(
          text: json.decode(onEvent.data)["data"],
          user: ChatUser.fromJson(json.decode(onEvent.data)["user"]),
        ));
      });
    });
  }

  @override
    Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          // iconTheme:
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Chat",
          style: TextStyle(
            color: Colors.black
          ),
          ),
          iconTheme: new IconThemeData(color: Colors.black),
          // child: new Icon(Icons.add),

          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: true,
          // centerTitle: true,
        ),
      ),
    );
  }
}
