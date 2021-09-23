import 'package:flutter/material.dart';
import 'package:wassal_customer/numberlogin.dart';

import 'Categories.dart';
import 'Profile.dart';
import 'Stores.dart';
import 'const.dart';

class MainDashboard extends StatefulWidget {
  final String yourAddress;
  MainDashboard({@required this.yourAddress});

  @override
  _MainDashboardState createState() =>
      _MainDashboardState(yourAddress: yourAddress);
}

class _MainDashboardState extends State<MainDashboard> {
  final String yourAddress;
  _MainDashboardState({@required this.yourAddress});
  int bottomIndex;
  @override
  void initState() {
    bottomIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      body: bottomIndex == 0
          ? MainCategories(yourAddress:yourAddress)
          : bottomIndex == 1
              ? AllShops()
              : bottomIndex == 2 && logs == true
                  ? ProfilePage()
                  : Container(),
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
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: themeSecondaryColor,
          unselectedItemColor: Colors.grey[500],
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              bottomIndex = index;
            });
            if (bottomIndex == 2) {
              if (logs != true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
