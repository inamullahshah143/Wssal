import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pusher/pusher.dart' as push;
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatPage extends StatefulWidget {
  final Map orderDetails;
  ChatPage({this.orderDetails});
  DateTime noww = new DateTime.now();
  @override
  _ChatPageState createState() => _ChatPageState(orderDetails: orderDetails);
}

class _ChatPageState extends State<ChatPage> {
  final Map orderDetails;
  _ChatPageState({this.orderDetails});
  List<Widget> message = [];
  void initState() {
    buildMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Enter message"),
                onFieldSubmitted: (value) {
                  push.PusherOptions options =
                      new push.PusherOptions(encrypted: true, cluster: "ap2");
                  push.Pusher pusher = new push.Pusher('1266741',
                      '75277f8cc7ab6202152a', '5722578c3b137a34832c', options);
                  pusher.trigger(
                      ["${orderDetails['order_no']}Chat"],
                      "${orderDetails['order_no']}Chat",
                      "$value,${DateTime.now()},Driver");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: message),
            )
          ]),
        ),
      ),
    );
  }

  buildMessage() async {
    try {
      await Pusher.init('75277f8cc7ab6202152a', PusherOptions(cluster: 'ap2'));
    } catch (e) {
      print(e);
    }
    Pusher.connect(
      onConnectionStateChange: (value) {
        print("Pusher.connect: ${value.currentState}");
      },
      onError: (e) {
        print(e.message);
      },
    );
    Pusher.subscribe("${orderDetails['order_no']}Chat").then((_channel) {
      _channel.bind("${orderDetails['order_no']}Chat", (data) {
        print("${data.data}");
        setState(() {
          message.add(
            MessageTile(
              name: "Driver",
              data: data,
            ),
          );
        });
      });
    });
  }
}

class MessageTile extends StatefulWidget {
  String name;
  final Event data;
  MessageTile({@required this.data, this.name});
  @override
  _MessageTileState createState() => _MessageTileState(data: data, name: name);
}

class _MessageTileState extends State<MessageTile> {
  String name;
  final Event data;
  _MessageTileState({@required this.data, this.name});
  String time;
  @override
  void initState() {
    setState(() {
      name = "${data.data.split(",")[2]}";
    });
    setState(() {
      time = "${timeago.format(DateTime.parse(data.data.split(",")[1]))}";
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time = "${timeago.format(DateTime.parse(data.data.split(",")[1]))}";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime time = DateTime.now();
// print(timeago.format(time));
    return ListTile(
      trailing: Text(time),
      // Text("${DateFormat('hh:mm:ss').format(DateTime.now())}"),
      title: Text("${data.data.split(",")[0]}"),
      leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(60))),
      subtitle: Text("$name"),
    );
  }
}
