import 'package:flutter/material.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
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
                'Account Information',
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: TextStyle(
                        height: 1.5, color: Colors.grey, fontSize: 14),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      initialValue: 'Revan Diab',
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Full Name Here"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Divider(),
                  ),
                  Text(
                    'Email Address',
                    style: TextStyle(
                        height: 1.5, color: Colors.grey, fontSize: 14),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      initialValue: 'name@gmail.com',
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Email Address"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Divider(),
                  ),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                        height: 1.5, color: Colors.grey, fontSize: 14),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      initialValue: '+2 0100 345 6789',
                      readOnly: true,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Phone number"),
                    ),
                  ),
                  Text(
                    '* Phone Number Cannot be changed.',
                    style: TextStyle(
                        height: 1.5, fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    '  Contact Support for more information',
                    style: TextStyle(
                        height: 1.5, fontSize: 11, color: Colors.grey),
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 199, 0, 100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Change Settings'),
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
