import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'account/displayprofile.dart';
import 'account/driverProfile.dart';
import 'function.dart';
import 'orderDetails.dart';
import 'orderHistory.dart';

class Home extends StatefulWidget {
  // const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 247, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Image(
                image: AssetImage('assets/app_logo.png'),
              )
            ],
            // automaticallyImplyLeading: false,
            // centerTitle: true,
          ),
        ),
        bottomNavigationBar: getbottomBar(0, context),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       DrawerHeader(
        //         child: Text(''),
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             image: DecorationImage(
        //                 image: AssetImage('assets/Logo_wssal.png'),
        //                 fit: BoxFit.contain)),
        //       ),
              // ListTile(
              //   title: Text('Profile'),
              //   onTap: () {

              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) => DriverProfile(),
              //       ),
              //     );
              //   },
              // ),
              // ListTile(
              //   title: Text('Driver Profile'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) => Displayprofile(),
              //       ),
              //     );
              //   },
              // ),
              // ListTile(
              //  title: Text('Variants'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) => DisplayVariants(),
              //       ),
              //     );
              //   },
              // ),
              //   ListTile(
              //  title: Text('Attributes'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) => DisplayAttributes(),
              //       ),
              //     );
              //   },
              // ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/driver.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        title: Text('Hello'),
                        subtitle: Text(
                          'Ahmad',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                            height: 30,
                            width: 70,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text('Online')),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green)),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: buildDriverOrder(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data;
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text("${snapshot.error}"));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   child: TabBar(
                      //     labelColor: Colors.red,
                      //     unselectedLabelColor: textColor,
                      //     tabs: [
                      //       Tab(text: 'New Order'),
                      //       Tab(text: 'Completed Orders'),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //     height: 400,
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         border: Border(
                      //             top: BorderSide(
                      //                 color: Colors.grey, width: 0.5))),
                      //     child: TabBarView(children: <Widget>[
                      //       Container(child: newOrders(context)),
                      //       Container(
                      //         height: 400,
                      //         child: completedOrderr(context)
                      //         )
                      //     ]))
                    ]),
              ),
            )));
  }

  Future<Widget> buildDriverOrder() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/driver/driverOrders';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('build Driver Response: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          x.add(
              // Container(
              //   child: ),
              InkWell(
                onTap: (){
                    Navigator.push(
              context, MaterialPageRoute(builder: (context) =>OrderDetails(element)));
                },
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5
                    )
                  ),
                  child: ListTile(
                      title: Column(
              
                        children: [
                          Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '\#${element['order_no']}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                          ),
                                        ),
                                      )),
                          RichText(
                            text: TextSpan(children: [
                              
                              WidgetSpan(
                                child: Text(
                                  "${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(element['created_at']))}",
                                // '${DateTime.parse(element['created_at'].toString())}',
                                  style: TextStyle(
                                        // fontSize: 15,
                                        color: Color.fromRGBO(182, 189, 200, 1),
                                  )
                                ),
                              ),
                              // WidgetSpan(
                              //     child: Container(
                              //   margin: EdgeInsets.only(left: 5),
                              //   child: Text(
                              //     '${element['created_at'].toString().split('T')[0]}',
                              //    style: TextStyle(
                              //           // fontSize: 15,
                              //           color: Color.fromRGBO(182, 189, 200, 1),
                              //         )),
                              
                              // )),
                            ]),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage('assets/driver.jpg'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                                      '${element['payment_method']}',
                                      style: TextStyle(
                                        // fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                              //       Text(
                              //   '${element['grand_total']}',
                              //   style: TextStyle(fontSize: 15),
                              // ),
                        ],
                      ),
                      trailing: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'View Details',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 199, 0, 1)
                              )
                            )
                          ])),
                      // Column(children: [
                      //   RichText(
                      //     text: TextSpan(children: [
                      //       WidgetSpan(child: Container(
                      //         alignment: Alignment.centerLeft,
                      //         height: 50,
                      //         width: 50,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           image: DecorationImage(
                      //             image: AssetImage('assets/driver.jpg'),
                      //             fit: BoxFit.contain,
                      //           ),
                      //         ),
                      //       ),),
                      //       WidgetSpan(
                      //           child: Container(
                      //               margin: EdgeInsets.only(right: 5),
                      //               child: Text(
                      //                 '${element['payment_method']}',
                      //                 style: TextStyle(
                      //                   // fontSize: 15,
                      //                   color: Colors.black,
                      //                 ),
                      //               ))),
                      //       WidgetSpan(
                      //         child: Text(
                      //           '${element['grand_total']}',
                      //           style: TextStyle(fontSize: 15),
                      //         ),
                      //       ),
                      //     ]),
                      //   ),
                      // ])
                      ),
                ),
              ));
        });
        return Container(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: x,
          ),
        );
      } else {
        return Text("No Orders Available");
      }
    } catch (e) {
      return Text('No Orders Availabe');
    }
  }

  // Widget newOrders(context) {
  //   List<Widget> x = [];
  //   newOrder.forEach((element) {
  //     print(element);
  //     x.add(InkWell(
  //       onTap: () {
  //         print(element);
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => OrderDetails(element)),
  //         );
  //       },
  //       child: Column(
  //         children: [
  //           ListTile(
  //             leading: Container(
  //               height: height / 5,
  //               width: width / 5,
  //               margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
  //               decoration: BoxDecoration(
  //                   // color: Colors.yellow,
  //                   image: DecorationImage(
  //                     image: AssetImage('${element['orderImage']}'),
  //                     fit: BoxFit.contain,
  //                   ),
  //                   borderRadius: BorderRadius.circular(18)),
  //             ),
  //             title: Align(
  //                 alignment: Alignment.center,
  //                 child: Text("Price : \$${element['orderprice']}")),
  //             subtitle: Align(
  //                 alignment: Alignment.center,
  //                 child: Text("Quantity : ${element['orderquantity']}")),
  //           ),
  //           Divider(
  //             thickness: 1,
  //             color: Colors.grey,
  //           )
  //         ],
  //       ),
  //     ));
  //   });
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: Column(
  //       children: x,
  //     ),
  //   );
  // }

  // Widget completedOrderr(context) {
  //   List<Widget> x = [];
  //   completedOrder.forEach((element) {
  //     print(element);
  //     x.add(InkWell(
  //       onTap: () {
  //         print(element);
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => OrderHistory(element)),
  //         );
  //       },
  //       child: Column(
  //         children: [
  //           ListTile(
  //             leading: Container(
  //               height: height / 5,
  //               width: width / 5,
  //               margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
  //               decoration: BoxDecoration(
  //                   // color: Colors.yellow,
  //                   image: DecorationImage(
  //                     image: AssetImage('${element['orderImage']}'),
  //                     fit: BoxFit.contain,
  //                   ),
  //                   borderRadius: BorderRadius.circular(18)),
  //             ),
  //             title: Align(
  //                 alignment: Alignment.center,
  //                 child: Text("Price : \$${element['orderprice']}")),
  //             subtitle: Align(
  //                 alignment: Alignment.center,
  //                 child: Text("Quantity : ${element['orderquantity']}")),
  //           ),
  //           Divider(
  //             thickness: 1,
  //             color: Colors.grey,
  //           )
  //         ],
  //       ),
  //     ));
  //   });
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: Column(
  //       children: x,
  //     ),
  //   );}

}
