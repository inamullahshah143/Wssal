import 'package:flutter/material.dart';
import 'function.dart';

class OrderHistory extends StatefulWidget {
  final Map orderDetail;
  OrderHistory(this.orderDetail);

  @override
  _OrderHistoryState createState() => _OrderHistoryState(orderDetail);
}

class _OrderHistoryState extends State<OrderHistory> {
  final Map orderDetail;
  _OrderHistoryState(this.orderDetail);
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
            alignment: Alignment.center,
            child: Text(
              "Order History",
              style: TextStyle(height: 1.5, color: Colors.black),
            ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${orderDetail['orderid']}',
                      style: TextStyle(height: 1.5, fontSize: 19),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(19)),
                      child: Text(
                        'Completed',
                        style: TextStyle(height: 1.5, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '29/10/2021',
                      style: TextStyle(height: 1.5, fontSize: 15),
                    ),
                    Text(
                      '10:23AM',
                      style: TextStyle(height: 1.5, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Information',
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method',
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'You will Earn',
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_atm_outlined,
                                color: Colors.red,
                                size: 35,
                              ),
                              Text(
                                'Cash',
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_atm_outlined,
                                color: Colors.green,
                                size: 35,
                              ),
                              Text(
                                '10.00 EGP',
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Details',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
              // RaisedButton(onPressed: (){
              //    print('${orderDetail['products']}');
              // }),
              Container(
                margin: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: buildProducts(orderDetail['products']),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(height: 1.5, fontSize: 15),
                    ),
                    Text(
                        "\$ ${buildProductsTotalPrice(orderDetail['products'])}"),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Time',
                      style: TextStyle(
                          height: 1.5, color: Colors.black, fontSize: 19),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.access_alarm, size: 14),
                          ),
                          TextSpan(
                              text: "  18 Min",
                              style:
                                  TextStyle(height: 1.5, color: Colors.black)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
}
