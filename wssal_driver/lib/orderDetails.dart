import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wssal_driver/startnavigation.dart';
import 'Map.dart';
import 'function.dart';

String _mapStyle;
int totalProductsPrices = 0;
var orderIdd;

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
  Set<Marker> _markers = Set<Marker>();
  Timer timer;
  var latitude;
  var longitude;
  var datetime;
  @override
  void initState() {
    super.initState();
    print(orderDetail);
    orderIdd = orderDetail['id'];
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getlocation());
    // _getlocation();
    rootBundle.loadString('assets/map.txt').then((string) {
      _mapStyle = string;
    });
    setMarkerImages();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _getlocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        latitude = value.latitude;
        longitude = value.longitude;
        datetime = DateTime.now();
      });

      print('latitude : $latitude');
      print('longitude : $longitude');
      print("Time: $datetime");
    });
  }

  Future<LocationData> getuserLocation() async {
    Location location = Location();
    return location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Order Details",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                ),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: buildOrdersDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            
             
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
             
              Container(
                height: height / 4.5,
                width: width,
                margin:
                    EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(9)),
                child: FutureBuilder(
                  future: getuserLocation(),
                  builder: (context, AsyncSnapshot<LocationData> snapshot) {
                    if (snapshot.hasData) {
                      return GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: _markers,
                        mapType: MapType.normal,
                        onMapCreated: (GoogleMapController controller) {
                          controller.setMapStyle(_mapStyle);
                          setMarkerImages();
                          markerAdd(LatLng(
                              snapshot.data.latitude, snapshot.data.longitude));
                          locationUpdates();
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(snapshot.data.latitude,
                                snapshot.data.longitude)),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error);
                    } else {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      );
                    }
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  //            latitude = value.latitude;
                  // longitude = value.longitude;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapBuilder(
                                position: LatLng(latitude, longitude),
                              )));
                  //  MapBuilder(position: LatLng(location.latitude, location.longitude),)));
                  //      Navigator.push(
                  // context, MaterialPageRoute(builder: (context) =>StartNavigation()));
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Accept & Start Navigation'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildProducts(List product) {
    List<Widget> x = [];

    for (final e in product) {
      x.add(
        // Text("\n${e['dec']}"));
        Column(
          children: [
            ListTile(
              leading: Image(
                image: AssetImage('${e['productImage']}'),
              ),
              title: Text('${e['producttitle']}'),
              trailing: Text('\$ ${e['productPrice']}'),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
      );
    }
    return x;
  }

  int buildProductsTotalPrice(List pp) {
    var x = 0;
    for (final e in pp) {
      x = x + e['productPrice'];
    }
    return x;
  }

  setMarkerImages() async {
    busIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          devicePixelRatio: 2.5,
        ),
        'assets/user.png');
  }

  locationUpdates() {
    Location location = Location();
    location.onLocationChanged.listen((cLoc) {
      print(cLoc);
      markerAdd(LatLng(cLoc.latitude, cLoc.longitude));
    });
  }

  markerAdd(LatLng pinPosition) {
    print("marker");
    setState(() {
      _markers
          .removeWhere((element) => element.markerId == MarkerId("busPointer"));
      _markers.add(
        Marker(
            markerId: MarkerId("busPointer"),
            position: pinPosition,
            onTap: () {},
            icon: busIcon),
      );
    });
  }

  Future<Widget> buildOrdersDetails() async {
    List<Widget> x = [];
    var url =
        'https://wassldev.einnovention.tech/api/vendor/orderDetail/$orderIdd';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('buildProductsResponse: ${response.body}');
    List data = json.decode(response.body)['data'];

    if (data.length > 0) {
      x.add(buildOrdersDetail1(data[0]));

      x.add(
          //   Container(
          //   margin: EdgeInsets.only(left: 10,bottom: 10),
          //   child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         'Order Details',
          //         style: TextStyle(
          //             fontSize: 19, fontWeight: FontWeight.bold),
          //       )),
          // ),
          buildOrdersDetail2(data[1])
      
        );
      //  x.add(

      //   InkWell(
      //   onTap: (){

      //   },
      //   child: Container(
      //     margin: EdgeInsets.all(10),
      //     padding: EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(9),
      //         border: Border.all(width: 1, color: Colors.grey)),
      //     child: Column(
      //       children: [
      //          Container(
      //            margin: EdgeInsets.all(5),

      //            child: Text(
      //                 // '${element['order_no']}',
      //                 '${data[1]}',
      //                 style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
      //               ),
      //          ),
      //          Divider(
      //            thickness: 1,
      //            color: Colors.grey,
      //          ),

      //       ],
      //     ),
      //   ),
      // ));
      // x.add(buildOrdersDetail1(data[1]));

      return Container(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: x,
        ),
      );
    } else {
      return Text("No Products Available");
    }
  }

  buildOrdersDetail1(dataa) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "\#${dataa['order_no']}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 19),
                    )),
                if (dataa['driver_id'] == null) ...[
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 199, 0, 1),
                        borderRadius: BorderRadius.circular(9)),
                    child: Text('Waiting Driver'),
                  )
                ] else ...[
                  Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    color: Colors.red,
                    child: Text('Order Not Exist'),
                  )
                ]
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${dataa['created_at'].toString().split('T')[0]}',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['created_at'].toString().split('T')[1]}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Color.fromRGBO(182, 189, 200, 1),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(5),

            //  decoration: BoxDecoration(
            //    borderRadius: BorderRadius.circular(9),
            //    color: Color.fromRGBO(244, 245, 247, 1)
            //  ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10,bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Payment Information',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Color.fromRGBO(244, 245, 247, 1)),
                  child: Column(
                    children: [
                      Container(
                         margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Payment Method'),
                                Text('You Will Earn'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           RichText(text: TextSpan(
                             children: [
                               WidgetSpan(child: Icon(Icons.card_membership,
                               size: 20,
                               color: Colors.red,
                               )),
                               WidgetSpan(child: Container(
                                 margin: EdgeInsets.only(left:8),
                                 alignment: Alignment.centerLeft,
                                 child: Text('${dataa['payment_method']}',
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 15
                                 ),
                                 ),
                               ))
                             ]
                           ),),
                           RichText(text: TextSpan(
                             children: [
                               WidgetSpan(child: Icon(Icons.card_membership,
                               size: 20,
                               color: Colors.red,
                               )),
                               WidgetSpan(child: Container(
                                 margin: EdgeInsets.only(left:8),
                                 alignment: Alignment.centerLeft,
                                 child: Text('10 GE',
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 15
                                 ),
                                 ),
                               ))
                             ]
                           ),),

                          ]
                        ),
                      ),
                       
                    ],
                  ),
                )
              ],
            ),
          ),
           Divider(
            thickness: 0.5,
            color: Color.fromRGBO(182, 189, 200, 1),
          ),
      
          // Container(
          //     margin: EdgeInsets.all(5),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           'Price',
          //           style: TextStyle(fontSize: 15),
          //         ),
          //         Text(
          //           '${dataa['grand_total']}',
          //           style: TextStyle(fontSize: 15),
          //         ),
          //       ],
          //     )),
          // buildcustomer(dataa['customer']),
        ],
      ),
    );
  }

  Widget buildOrdersDetail2(List dataa) {
    List<Widget> y = [];
    for (var x in dataa) {
      y.add(
        // ListTile(
        //   leading: Container(
        //      decoration: BoxDecoration(
        //           color: Colors.white,
        //           image: DecorationImage(
        //               image: AssetImage('assets/Logo_wssal.png'),
        //               fit: BoxFit.contain)),
        //   ),
        //   title: Text('\X ${x['quantity']}${x['product_name']}'),
        // )
        // Column(
        //   children: [
        //     Text('\X ${x['quantity']}${x['product_name']}'),
        //     Text('\X ${x['product_price']}'),
        //   ],
        // )
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/driver.jpg'))
            ),
          ),
          title: Text('\X ${x['quantity']}${x['product_name']}'),
          subtitle: Text('\X ${x['product_price']}'),
        )
      );
    }
    return Column(
      children: y,
    );
  }

  buildcustomer(dataa) {
    return Container(
      width: width,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black)),
      child: Column(
        children: [
          // Text('${dataa['phone']}'),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Name',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['name']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Phone',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['phone']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Email',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['email']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'CNIC',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['cnic']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${element['created_at'].toString().split('T')[0]}',
                  'Address',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '${dataa['address']}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          // dataa['image'] = null
          if (dataa['image'] == null) ...[
            Container(
              height: 100,
              width: width,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/api2.png'))),
            ),
          ] else ...[
            Container(
              margin: EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/api2.png',
                image: '$picBaseURL${dataa['image']}',
              ),
            ),
          ],
          // Container(
          //   child: Stepper(
          //       currentStep: 0,
          //       type: stepperType,
          //       physics: ScrollPhysics(),
          //       steps: <Step>[
          //         Step(
          //           title: new Text('Account'),
          //           content: Column(
          //             children: <Widget>[],
          //           ),
          //           isActive: _currentStep >= 0,
          //           state: _currentStep >= 0
          //               ? StepState.complete
          //               : StepState.disabled,
          //         ),
          //         Step(
          //           title: new Text('r'),
          //           content: Column(
          //             children: <Widget>[],
          //           ),
          //           isActive: _currentStep >= 0,
          //           state: _currentStep >= 1
          //               ? StepState.complete
          //               : StepState.disabled,
          //         ),
          //       ]),
          // ),
        ],
      ),
    );
  }
}
