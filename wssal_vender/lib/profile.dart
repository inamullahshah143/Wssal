import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:wssal_vender/functions.dart';
import 'package:wssal_vender/storeInformation.dart';
import 'package:wssal_vender/wallet/venderWoilet.dart';

import 'login_page.dart';

class Profile extends StatefulWidget {
  // const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          // actions: [
          //   Image(image: AssetImage('assets/app_logo.png'),)
          // ],
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
      ),
      // bottomNavigationBar: getbottomBar(4, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: width,
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey,
                    thickness: 0.3,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   height: 100,
                  //   width: width,
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //           image: AssetImage('assets/starbuck.png'))),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: Text(
                  //     'Starbuck',
                  //     style: TextStyle(color: Colors.black, fontSize: 19),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10, bottom: 10),
                  //   child: Text(
                  //     '+2 0100 345 6789',
                  //     style: TextStyle(color: Colors.black, fontSize: 13),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'General',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    color: textColor,
                    thickness: 0.5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoreInformation()));
                    },
                    child: Container(
                      // color: Colors.green,
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: textColor,
                        ),
                        title: Text('Store Information'),
                        subtitle: Text(
                          'Change Your Account Information',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: textColor,
                    thickness: 0.5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriverWoilet()));
                    },
                    child: Container(
                      // color: Colors.green,
                      child: ListTile(
                        leading: Icon(
                          Icons.payment,
                          color: textColor,
                        ),
                        title: Text('Payment Method'),
                        subtitle: Text(
                          'Payroll, Bank Account Details',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: textColor,
                    thickness: 0.5,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FavouriteList()));
                    },
                    child: Container(
                      // color: Colors.green,
                      child: ListTile(
                        leading: Icon(
                          Icons.payment,
                          color: textColor,
                        ),
                        title: Text('Support'),
                        subtitle: Text(
                          'Contact Support',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(
                      color: textColor,
                      thickness: 0.5,
                    ),
                    Container(
                      // color: Colors.green,
                      child: ListTile(
                          leading: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.bell,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                          title: Text('Notification'),
                          subtitle: Text(
                            'You Will Receive daily Updates',
                            style: TextStyle(color: textColor),
                          ),
                          trailing: SwitcherButton(
                            size: 40,
                            offColor: textColor,
                            onColor: Colors.red,
                            value: true,
                            onChange: (value) {
                              print(value);
                              //  Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Notifications()));
                            },
                          )),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'More',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(
                      color: textColor,
                      thickness: 0.5,
                    ),
                    Container(
                      // color: Colors.green,
                      child: ListTile(
                        leading: Icon(
                          Icons.star_rate_rounded,
                          color: textColor,
                        ),
                        title: Text('Rate Us'),
                        subtitle: Text(
                          'You Will Receive Daily Updates',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Divider(
                      color: textColor,
                      thickness: 0.5,
                    ),
                    Container(
                      // color: Colors.green,
                      child: ListTile(
                        leading: Icon(
                          Icons.menu_book_rounded,
                          color: textColor,
                        ),
                        title: Text('FAQ'),
                        subtitle: Text(
                          'Frequantly Asked Question',
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                )),
            InkWell(
              onTap: () async {
                showAlert(
                  context: context,
                  title: "You really want to Logout",
                  actions: [
                    AlertAction(
                        text: "Yes",
                        isDestructiveAction: true,
                        onPressed: () async {
                          SharedPreferences mypref =
                              await SharedPreferences.getInstance();
                          mypref.remove('abs');
                          print("$stringValue");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                        }),
                  ],
                  cancelable: true,
                );
              },
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
                height: 50,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15)),
                child:
                    Align(alignment: Alignment.center, child: Text('Logout')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
