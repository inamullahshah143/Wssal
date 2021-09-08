import 'package:flutter/material.dart';

class ChatWithDriver extends StatefulWidget {
  const ChatWithDriver({Key key}) : super(key: key);

  @override
  _ChatWithDriverState createState() => _ChatWithDriverState();
}

class _ChatWithDriverState extends State<ChatWithDriver> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.1,
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 30,
                    ),
                    Text(
                      'Driver Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 1.5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('12:38 PM'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(10),
                            // alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Quisque interdum quam tellus.'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                                'Quisque interdum quam tellus.Quisque interdum quam tellus Quisque interdum quam tellusQuisque interdum quam tellus.'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(10),
                            // alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Quisque interdum.'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(10),
                            // alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                                'Quisque interdum quam tellus, quis pulvinar leo ultrices facilisis. Nunc eu pellentesque justo, nec hendrerit libero. Morbi sit amet laoreet arcu.'),
                          ),
                        ],
                      ),
                      Text('12:38 PM'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Quisque interdum quam tellus.Quisque'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.grey,
                height: MediaQuery.of(context).size.height/10,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Type a message...",
                        ),
                      ),
                    ),
                    Icon(
                      Icons.dashboard_rounded,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 