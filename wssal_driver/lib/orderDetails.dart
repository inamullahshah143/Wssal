import 'dart:async';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'function.dart';

class OrderDetails extends StatefulWidget {
  final Map orderDetail;
  OrderDetails(this.orderDetail);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(orderDetail);
}

class _OrderDetailsState extends State<OrderDetails> {
  final Map orderDetail;
  _OrderDetailsState(this.orderDetail);
  BitmapDescriptor busIcon;
  Timer timer;
  var latitude;
  var longitude;
  var datetime;
  @override
  void initState() {
    super.initState();

    // _getlocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Orders Details",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/app_logo.png'),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          imageURL +
                              '/' +
                              orderDetail['customer_order']['orderuser']
                                  ['avatar'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${orderDetail['customer_order']['orderuser']['name']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                      '${orderDetail['customer_order']['orderuser']['phone']}'),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color.fromRGBO(244, 245, 247, 1),
                    ),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Order No",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['order_no']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Grand Total",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['deliveryfeec']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                orderDetail['customer_order']
                                            ['payment_method'] ==
                                        'cashondelivery'
                                    ? 'Cash On Delivery'
                                    : orderDetail['customer_order']
                                                ['payment_method'] ==
                                            'walletpayment'
                                        ? 'Wallet Payment'
                                        : '${orderDetail['customer_order']['payment_method']}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Pick Form",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['pick_loc']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Deliver To",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['drop_loc']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Distance",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "${orderDetail['customer_order']['est_distance']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Order Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                orderDetail['customer_order']['status'] == 0
                                    ? 'No Driver Assigned'
                                    : 'Driver Already Assigned',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  orderDetail['customer_order']['status'] == 0
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: width,
                          child: ElevatedButton(
                            onPressed: () {
                              http
                                  .get(
                                      "$apiURL/drivercustomorder/${orderDetail['id']}")
                                  .then((response) {});
                            },
                            child: Text('Accept Order'),
                          ),
                        )
                      : Container(),
                  // orderDetail['customer_order']['driver_id'] == null
                  //     ? Container(
                  //         margin: EdgeInsets.all(25),
                  //         child: Text("No Driver Assigned"),
                  //       )
                  //     : Container(
                  //         padding: EdgeInsets.all(10),
                  //         margin: EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(8),
                  //           ),
                  //           color: Color.fromRGBO(244, 245, 247, 1),
                  //         ),
                  //         child: Table(
                  //           children: [
                  //             TableRow(
                  //               children: [
                  //                 Container(
                  //                   margin: EdgeInsets.all(10),
                  //                   child: Text(
                  //                     "Deliver To",
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w500),
                  //                   ),
                  //                 ),
                  //                 Container(
                  //                   margin: EdgeInsets.all(10),
                  //                   child: Text(
                  //                       "${orderDetail['customer_order']['user']['address']['address']}"),
                  //                 ),
                  //               ],
                  //             ),
                  //             TableRow(
                  //               children: [
                  //                 Container(
                  //                   margin: EdgeInsets.all(10),
                  //                 ),
                  //                 Container(
                  //                   margin: EdgeInsets.all(10),
                  //                   child: ElevatedButton(
                  //                     onPressed: () {
                  //                       Navigator.push(
                  //                         context,
                  //                         MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               DriverMapBuilder(
                  //                             orderDetails: orderDetail,
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                     child: Text(
                  //                       "Start Order",
                  //                       style: TextStyle(color: Colors.red),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                ],
              ),
              // Column(
              //   children: [
              //     FutureBuilder(
              //       future: buildOrdersDetails(),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasData) {
              //           return snapshot.data;
              //         } else if (snapshot.hasError) {
              //           return Center(child: Text("${snapshot.error}"));
              //         } else {
              //           return Center(child: CircularProgressIndicator());
              //         }
              //       },
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

//   Future<Widget> buildOrdersDetails() async {
//     var url =
//         'https://wassldev.einnovention.tech/api/driver/driverOrderDetail/${orderDetail['id']}';
//     var response = await http
//         .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
//     print('buildProductsResponse: ${response.body}');
//     Map data = json.decode(response.body)['data'];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(100),
//             ),
//             image: DecorationImage(
//               image: NetworkImage(
//                 imageURL +
//                     '/' +
//                     orderDetail['customer_order']['orderuser']['avatar'],
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//             color: Color.fromRGBO(244, 245, 247, 1),
//           ),
//           child: Table(
//             children: [
//               TableRow(children: [
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: Text(
//                     "Order No",
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: Text("${data['order_no']}"),
//                 ),
//               ]),
//               TableRow(children: [
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: Text(
//                     "Grand Total",
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: Text(
//                     "${data['grand_total']}",
//                   ),
//                 ),
//               ]),
//               TableRow(children: [
//                 Container(
//                     margin: EdgeInsets.all(10),
//                     child: Text("Payment Method",
//                         style: TextStyle(fontWeight: FontWeight.w500))),
//                 Container(
//                     margin: EdgeInsets.all(10),
//                     child: Text("${data['payment_method']}")),
//               ]),
//               TableRow(children: [
//                 Container(
//                     margin: EdgeInsets.all(10),
//                     child: Text("Order Status",
//                         style: TextStyle(fontWeight: FontWeight.w500))),
//                 Container(
//                   margin: EdgeInsets.all(10),
//                   child: Text("${getStatus({
//                         "pending": data['pending'],
//                         "process": data['process'],
//                         "packing": data['packing'],
//                         "shipping": data['shipping'],
//                         "delivered": data['delivered'],
//                         "cancelled": data['cancelled'],
//                       })}"),
//                 ),
//               ]),
//             ],
//           ),
//         ),
//         data['driver_id'] == null
//             ? Container(
//                 margin: EdgeInsets.all(25),
//                 child: Text("No Driver Assigned"),
//               )
//             : Container(
//                 padding: EdgeInsets.all(10),
//                 margin: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   color: Color.fromRGBO(244, 245, 247, 1),
//                 ),
//                 child: Table(
//                   children: [
//                     TableRow(children: [
//                       Container(
//                           margin: EdgeInsets.all(10),
//                           child: Text(
//                             "Deliver To",
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           )),
//                       Container(
//                           margin: EdgeInsets.all(10),
//                           child: Text("${data['user']['address']['address']}")),
//                     ]),
//                     TableRow(children: [
//                       Container(
//                         margin: EdgeInsets.all(10),
//                       ),
//                       Container(
//                           margin: EdgeInsets.all(10),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DriverMapBuilder(
//                                           orderDetails: data)));
//                             },
//                             child: Text("Start Order"),
//                           )),
//                     ]),
//                   ],
//                 ),
//               ),
//       ],
//     );
//   }
// }
}
