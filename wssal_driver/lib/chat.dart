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
      bottomNavigationBar: getbottomBar(1, context),
      // body: Container(
      //   margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      //   child: DashChat(
      //     user: ChatUser(
      //       name: "wssal_vender",
      //       uid: "1",
      //       avatar: "assets/driver.jpg",
      //     ),
      //     messages: _messages,
      //     showAvatarForEveryMessage: true,
      //     showUserAvatar: true,
      //     avatarBuilder: (user) {
      //       return CircleAvatar(
      //         backgroundImage: AssetImage(user.avatar),
      //       );
      //     },
      //     scrollToBottom: true,
      //     onSend: (msg) {
      //       print("msg is sending ....");
      //       ahmad.Pusher pusher = new ahmad.Pusher(
      //           "1151290",
      //           "9ad69659971df101b114",
      //           "553b9e2a751230487a99",
      //           ahmad.PusherOptions(cluster: "ap1"));
      //       Map data = {"data": msg.text, "user": msg.user};

      //       pusher
      //           .trigger(['Geotv'], 'morning', json.encode(data)).then((value) {
      //         print("Status : ${value.status}");
      //         print('msg : ${value.message}');
      //       });
      //     },
      //   ),
      // ),
    );
  }
}
