import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({Key key}) : super(key: key);

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 1.1,
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
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Refer & Earn',
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    width: 50,
                    height: 50,
                    child: Icon(Icons.redeem_rounded,
                        color: Colors.white, size: 30),
                  ),
                  Text(
                    'Refer a Freind',
                    style: TextStyle(
                        height: 1.5, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Share your promo code with a friend and you both get LE15.',
                    style: TextStyle(
                        height: 1.5, fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    color: Colors.redAccent,
                    dashPattern: [10, 5],
                    strokeWidth: 3,
                    strokeCap: StrokeCap.round,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'WSSAL 15',
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 24,
                              color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 199, 0, 100),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: double.infinity,
                    height: 60,
                    child: Center(
                      child: Text('Share'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
