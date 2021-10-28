import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wassal_customer/const.dart';
import 'package:wassal_customer/design_pages/order/chat.dart';
import 'package:wassal_customer/design_pages/order/orders_history.dart';

class Ongoing extends StatefulWidget {
  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  static const _camera =
      CameraPosition(target: LatLng(31.5009922, 74.3220759), zoom: 16);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: _camera,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.red),
                        ),
                      ),
                      child: Text(
                        'Ongoing',
                        style: TextStyle(height: 1.5, color: Colors.red),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new PageRouteBuilder(
                            opaque: true,
                            transitionDuration:
                                const Duration(milliseconds: 100),
                            pageBuilder: (BuildContext context, _, __) {
                              return History();
                            },
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return new SlideTransition(
                                child: child,
                                position: new Tween<Offset>(
                                  begin: Offset(1, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                              );
                            }));
                      },
                      child: Container(
                        child: Text('History'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.9,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 0,
                      leading: Icon(Icons.account_circle_rounded, size: 30),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Driver Name',
                            style: TextStyle(
                                height: 1.5, fontSize: 14, color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 60,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(222, 68, 48, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star_rounded,
                                      color: Colors.white, size: 17),
                                  Text('4.8',
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      trailing: CircularPercentIndicator(
                        startAngle: 90,
                        radius: 40.0,
                        lineWidth: 5.0,
                        percent: 0.7,
                        center: Text(
                          "07:55",
                          style: TextStyle(height: 1.5, fontSize: 10),
                        ),
                        progressColor: Colors.yellow,
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    ListTile(
                      title: Text(
                        'Prime Beef - Pizza Beautif',
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            '\$ 8.98 ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.5, color: Colors.red),
                          ),
                          Text(
                            '(2 items) - ',
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Cash',
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Detail order'),
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.red,
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.red,
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.red,
                              ),
                              Container(
                                width: 50,
                                height: 5,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            // padding: EdgeInsets.symmetric(horizontal: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ordered',
                                  style: TextStyle(height: 1.5, fontSize: 12),
                                ),
                                Text(
                                  'Prepairing',
                                  style: TextStyle(height: 1.5, fontSize: 12),
                                ),
                                Text(
                                  'On the way',
                                  style: TextStyle(height: 1.5, fontSize: 12),
                                ),
                                Text(
                                  'Delivered',
                                  style: TextStyle(height: 1.5, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
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
                                  child: ChatWithDriver(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text('Chat with driver'),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.6,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Call the driver'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: getBottomBar(context),
      ),
    );
  }
}
