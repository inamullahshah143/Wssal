import 'package:flutter/material.dart';
import 'package:wssal_driver/dashboard/completed_orders.dart';
import 'package:wssal_driver/dashboard/active_orders.dart';
import 'package:wssal_driver/dashboard/incoming_orders.dart';
import 'package:wssal_driver/person/personPage.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int bottomIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomIndex == 0
          ? IncomingOrders()
          : bottomIndex == 1
              ? ActiveOrders()
              : bottomIndex == 2
                  ? CompletedOrders()
                  : bottomIndex == 3
                      ? Person()
                      : null,
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          currentIndex: bottomIndex,
          showUnselectedLabels: false,
          selectedItemColor: Color.fromRGBO(222, 61, 48, 1),
          unselectedItemColor: Colors.grey[500],
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              bottomIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Incoming",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Active",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.poll),
              label: "Completed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
