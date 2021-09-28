import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wassal_customer/PUSHER/CustomOrderDetails.dart';
import 'package:wassal_customer/numberlogin.dart';
import 'Profile.dart';
import 'Stores.dart';
import 'categorydetail.dart';
import 'const.dart';

class CategoryDashboard extends StatefulWidget {
  final Map categoryBlock;
  CategoryDashboard(
      {@required this.categoryBlock, @required this.initialPosition});
  final LatLng initialPosition;

  @override
  _CategoryDashboardState createState() => _CategoryDashboardState(
      categoryBlock: categoryBlock, initialPosition: initialPosition);
}

class _CategoryDashboardState extends State<CategoryDashboard> {
  _CategoryDashboardState(
      {@required this.categoryBlock, @required this.initialPosition});
  final LatLng initialPosition;
  final Map categoryBlock;
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
          ? CategoryDetail(
              categoryBlock: categoryBlock,
              initialPosition: initialPosition,
            )
          : bottomIndex == 1
              ? AllShops()
              : bottomIndex == 2
                  ? CustomOrderDetail()
                  : bottomIndex == 4
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
            if (bottomIndex == 4) {
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
              icon: Icon(Icons.receipt_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
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
