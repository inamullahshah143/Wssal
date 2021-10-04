import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:wssal_vender/functions.dart';
import 'package:http/http.dart' as http;
import 'orderDetails.dart';

final tdata = <String, String>{};
var datee;
var timee;

class Orders extends StatefulWidget {
  // const Orders({ Key? key }) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 247, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Orders",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Image(
                image: AssetImage('assets/app_logo.png'),
              )
            ],
            automaticallyImplyLeading: false,
            // centerTitle: true,
          ),
        ),
        // bottomNavigationBar: getbottomBar(2, context),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                margin:
                    EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                Container(
                     width: width,
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: buildOrders(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data;
                            } else if (snapshot.hasError) {
                              return Center(child: Text("${snapshot.error}"));
                            } else {
                              return Center(child: CircularProgressIndicator()
                                  // child: Text('No Orders'),
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ]))));
  }

  // Future<Widget> buildOrders() async {
  //   List<Widget> x = [];
  //   try {
  //     var url = 'https://wassldev.einnovention.tech/api/vendor/orders';
  //     var response = await http.get(Uri.parse(url),
  //         headers: {'Authorization': 'Bearer $stringValue'});
  //     print('buildProductsResponse: ${response.body}');
  //     List data = json.decode(response.body)['data'];
  //     if (data.length > 0) {
  //       data.forEach((element) {
  //         x.add(InkWell(
  //           onTap: () {
  //             print('id = ${element['id']}');
  //             print('element agla = ${element['order']}');
  //             //  Navigator.push(
  //             //       context,
  //             //       MaterialPageRoute(
  //             //           builder: (BuildContext context) =>
  //             //                OrderDetails(element['id'],element)),
  //             //     );
  //             if (element['order']['cancelled'] == null) {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (BuildContext context) =>
  //                         OrderDetails(element['id'], element)),
  //               );
  //             } else {
  //               showAlert(
  //                 context: context,
  //                 title: "Orders Cancelled",
  //                 actions: [
  //                   AlertAction(
  //                       text: "Ok ",
  //                       isDestructiveAction: true,
  //                       onPressed: () {}),
  //                 ],
  //                 cancelable: true,
  //               );
  //             }
  //           },
  //           child: Container(
  //             margin: EdgeInsets.all(10),
  //             padding: EdgeInsets.all(10),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(9),
  //                 border: Border.all(width: 1, color: Colors.grey)),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.all(5),
  //                   child: Text(
  //                     '${element['product_name']}',
  //                     // 'Quantity',
  //                     style:
  //                         TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 Divider(
  //                   thickness: 1,
  //                   color: Colors.grey,
  //                 ),
  //                 Container(
  //                   padding: EdgeInsets.all(5),
  //                   // decoration: BoxDecoration(
  //                   //     color: Colors.yellow,
  //                   //     border: Border.all(color: Colors.yellow, width: 1),
  //                   //     borderRadius: BorderRadius.circular(19)),
  //                   child: Text(
  //                     '${element['order_no']}',
  //                     style: TextStyle(color: Colors.red),
  //                   ),
  //                 ),

  //                 //  tdata=(element['created_at']),
  //                 //  Text('Date: ${element['created_at'].toString().split('T')[0]}'),
  //                 //  Text('Time: ${element['created_at'].toString().split('T')[1]}')
  //                 Container(
  //                   margin: EdgeInsets.all(5),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         // '${element['created_at'].toString().split('T')[0]}',
  //                         'Date',
  //                         style: TextStyle(fontSize: 15),
  //                       ),
  //                       Text(
  //                         '${element['created_at'].toString().split('T')[0]}',
  //                         style: TextStyle(fontSize: 15),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.all(5),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         // '${element['created_at'].toString().split('T')[0]}',
  //                         'Time',
  //                         style: TextStyle(fontSize: 15),
  //                       ),
  //                       Text(
  //                         '${element['created_at'].toString().split('T')[1]}',
  //                         style: TextStyle(fontSize: 15),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                     margin: EdgeInsets.all(5),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           // '${element['product_name']}',
  //                           'Quantity',
  //                           style: TextStyle(fontSize: 15),
  //                         ),
  //                         Text(
  //                           '\X${element['quantity']}',
  //                           style: TextStyle(fontSize: 15),
  //                         ),
  //                       ],
  //                     )
  //                     // Table(
  //                     //   children: [
  //                     //     TableRow(
  //                     //       children: [
  //                     //        Container(
  //                     //          margin: EdgeInsets.all(5),
  //                     //          child: Align(
  //                     //            alignment: Alignment.centerLeft,
  //                     //            child: Text(
  //                     //                                              '${element['product_name']}',
  //                     //                                              style: TextStyle(fontSize: 15),
  //                     //                                            ),
  //                     //          ),
  //                     //        ),
  //                     //         Container(
  //                     //               margin: EdgeInsets.all(5),
  //                     //           child: Text(
  //                     //       '\X${element['quantity']}',
  //                     //       style: TextStyle(fontSize: 15),
  //                     //     ),
  //                     //         ),
  //                     //       ]
  //                     //     )
  //                     //   ],
  //                     // )
  //                     ),
  //                 Container(
  //                     margin: EdgeInsets.all(5),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           'Price',
  //                           style: TextStyle(fontSize: 15),
  //                         ),
  //                         Text(
  //                           '${element['product_price']}',
  //                           style: TextStyle(fontSize: 15),
  //                         ),
  //                       ],
  //                     )),
  //                 Container(
  //                   margin: EdgeInsets.all(5),
  //                   child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         // Container(
  //                         //   padding: EdgeInsets.only(left: 10, right: 10),
  //                         //   decoration: BoxDecoration(
  //                         //       color: Colors.yellow,
  //                         //       border: Border.all(color: Colors.yellow, width: 1),
  //                         //       borderRadius: BorderRadius.circular(19)),
  //                         //   child: Text(
  //                         //     '${element['order_no']}',
  //                         //     style: TextStyle(color: Colors.red),
  //                         //   ),
  //                         // )

  //                         if (element['order']['delivered'] != null &&
  //                             element['order']['cancelled'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.red,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('Delivered'),
  //                             ),
  //                           )
  //                         ] else if (element['order']['delivered'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('delivered'),
  //                             ),
  //                           )
  //                         ] else if (element['order']['delivered'] == null &&
  //                             element['order']['cancelled'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('Cancelled'),
  //                             ),
  //                           )
  //                         ] else if (element['order']['shipping'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('shipping'),
  //                             ),
  //                           )
  //                         ] else if (element['order']['packing'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('packing'),
  //                             ),
  //                           )
  //                         ] else if (element['order']['process'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('process'),
  //                             ),
  //                           )
  //                         ] else if (element['order']['pending'] != null) ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.green,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('pending'),
  //                             ),
  //                           )
  //                         ] else ...[
  //                           Container(
  //                             padding: EdgeInsets.all(6),
  //                             decoration: BoxDecoration(
  //                               color: Colors.yellow,
  //                               borderRadius: BorderRadius.circular(10),
  //                             ),
  //                             child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text('Waiting'),
  //                             ),
  //                           )
  //                         ]
  //                       ]),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ));
  //       });
  //       return Container(
  //         child: ListView(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           scrollDirection: Axis.vertical,
  //           children: x,
  //         ),
  //       );
  //     } else {
  //       return Text("No Orders ");
  //     }
  //   } catch (e) {
  //     showAlert(
  //       context: context,
  //       title: "No Orders Yet!!!!!",
  //       actions: [
  //         AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}),
  //       ],
  //       cancelable: true,
  //     );
  //   }
  // }
  
  Future<Widget> buildOrders() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/vendor/orders';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildProductsResponse: ${response.body}');
      List data = json.decode(response.body)['data'];
    if (data==null) {
      return Text('No Orders Yet');
      
    }
    else{
        if (data.length > 0) {
        data.forEach((element) {
          x.add(InkWell(
              onTap: () {
                print('id = ${element['id']}');
                print('element agla = ${element['order']}');
                //  Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) =>
                //                OrderDetails(element['id'],element)),
                //     );
                if (element['order']['cancelled'] == null &&
                    element['order']['delivered'] == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            OrderDetails(element['order_id'], element)),
                  );
                } else if (element['order']['cancelled'] == null &&
                    element['order']['delivered'] != null) {
                  showAlert(
                    context: context,
                    title: "Orders Completed",
                    actions: [
                      AlertAction(
                          text: "Ok ",
                          isDestructiveAction: true,
                          onPressed: () {}),
                    ],
                    cancelable: true,
                  );
                } else if (element['order']['cancelled'] != null &&
                    element['order']['delivered'] != null) {
                  showAlert(
                    context: context,
                    title: "Orders Completed",
                    actions: [
                      AlertAction(
                          text: "Ok ",
                          isDestructiveAction: true,
                          onPressed: () {}),
                    ],
                    cancelable: true,
                  );
                } else {
                  showAlert(
                    context: context,
                    title: "Orders Cancelled",
                    actions: [
                      AlertAction(
                          text: "Ok ",
                          isDestructiveAction: true,
                          onPressed: () {}),
                    ],
                    cancelable: true,
                  );
                }
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '\#${element['order_no']}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (element['order']['delivered'] != null &&
                                  element['order']['cancelled'] != null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Delivered'),
                                  ),
                                )
                              ] else if (element['order']['delivered'] ==
                                      null &&
                                  element['order']['cancelled'] != null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Cancelled'),
                                  ),
                                )
                              ] else if (element['order']['delivered'] !=
                                  null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('delivered'),
                                  ),
                                )
                              ] else if (element['order']['delivered'] ==
                                      null &&
                                  element['order']['cancelled'] != null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Cancelled'),
                                  ),
                                )
                              ] else if (element['order']
                                      ['shipping'] !=
                                  null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('shipping'),
                                  ),
                                )
                              ] else if (element['order']
                                      ['packing'] !=
                                  null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('packing'),
                                  ),
                                )
                              ] else if (element['order']['process'] !=
                                  null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('process'),
                                  ),
                                )
                              ] else if (element['order']['pending'] !=
                                  null) ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('pending'),
                                  ),
                                )
                              ] else ...[
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Waiting'),
                                  ),
                                )
                              ]
                            ]),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${element['created_at'].toString().split('T')[1]}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '${element['created_at'].toString().split('T')[0]}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '${element['product_name']}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  )
                ],
              )));
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
        return Text("No Orders ");
      }
    }
    } catch (e) {
      return Text(e);
    }
  }
}
