import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wassal_customer/const.dart';
import 'account_info.dart';
import 'delivery_locations.dart';
import 'notifications.dart';
import 'payment_methods.dart';
import 'share.dart';

import 'favorite.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    bool status = true;
    bool _status = false;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(
                height: 1.5,
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontSize: 16),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: NotificationList(),
                    ),
                  ),
                );
              },
              child: Image(
                image: AssetImage('asset/notifications.png'),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 2),
                padding: EdgeInsets.all(20),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 80,
                      height: 80,
                      image: AssetImage('asset/Profile.png'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Profile Name',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                    Text(
                      '+2 0100 345 6789',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.grey,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'General',
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: AccountInfo(),
                                  ),
                                ),
                              );
                            },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_rounded,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            title: Text('Account Information'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('Change your Account information'),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: PaymentMethods(),
                                  ),
                                ),
                              );
                            },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.credit_card_rounded,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            title: Text('Payment Methods'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('Add your Credit & Debit Card'),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: FavoriteList(),
                                  ),
                                ),
                              );
                            },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star_rounded),
                              ],
                            ),
                            title: Text('Favorite List'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('Browse your favorite list'),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: DeliveryLocations(),
                                  ),
                                ),
                              );
                            },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            title: Text('Delivery Locations'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('Change your Delivery Locations'),
                          ),
                          Divider(
                            height: 1,
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       isScrollControlled: true,
                          //       builder: (context) => SingleChildScrollView(
                          //         child: Container(
                          //           padding: EdgeInsets.only(
                          //               bottom: MediaQuery.of(context)
                          //                   .viewInsets
                          //                   .bottom),
                          //           child: DeliveryForm(),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   leading: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(
                          //         Icons.receipt_long_rounded,
                          //         color: Colors.grey,
                          //       ),
                          //     ],
                          //   ),
                          //   title: Text('BIlling Information'),
                          //   trailing: Icon(Icons.arrow_forward_ios_rounded),
                          //   subtitle: Text('Set your billing info'),
                          // ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: InviteFriend(),
                                  ),
                                ),
                              );
                            },
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' @',
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            title: Text('Invite your friends'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('Get \$5 for each invitation!'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(top: 50, right: 10, left: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_rounded,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            title: Text('Notifications'),
                            trailing: CupertinoSwitch(
                              activeColor: Colors.red,
                              value: status,
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                            // Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('You will recieve daily updates'),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_rounded,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            title: Text('Promotional Notifications'),
                            trailing: CupertinoSwitch(
                              activeColor: Colors.red,
                              value: _status,
                              onChanged: (value1) {
                                setState(() {
                                  _status = value1;
                                });
                              },
                            ),
                            subtitle: Text('Get notified when promotions'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'More',
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            title: Text('Rate us'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('You will recieve daily updates'),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_copy_rounded,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            title: Text('FAQ'),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            subtitle: Text('Frequently Asked Questions'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 199, 0, 100),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: getBottomBar(context),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(30),
        //       topLeft: Radius.circular(30),
        //     ),
        //   ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(30.0),
        //       topRight: Radius.circular(30.0),
        //     ),
        //     child: BottomNavigationBar(
        //       selectedItemColor: Colors.red,
        //       unselectedItemColor: Colors.grey,
        //       items: <BottomNavigationBarItem>[
        //         BottomNavigationBarItem(
        //             icon: Icon(
        //               Icons.dashboard_rounded,
        //               color: Colors.grey,
        //             ),
        //             label: ''),
        //         BottomNavigationBarItem(
        //             icon: Icon(
        //               Icons.explore_rounded,
        //               color: Colors.grey,
        //             ),
        //             label: ''),
        //         BottomNavigationBarItem(
        //             icon: Icon(
        //               Icons.receipt_rounded,
        //               color: Colors.grey,
        //             ),
        //             label: ''),
        //         BottomNavigationBarItem(
        //             icon: Icon(
        //               Icons.local_offer_rounded,
        //               color: Colors.grey,
        //             ),
        //             label: ''),
        //         BottomNavigationBarItem(
        //             icon: Icon(
        //               Icons.person_rounded,
        //               color: Colors.red,
        //             ),
        //             label: ''),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
