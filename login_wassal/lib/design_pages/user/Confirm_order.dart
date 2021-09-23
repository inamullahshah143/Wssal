import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:wassal_customer/design_pages/user/Add_New_payment_method.dart';

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  int _itemCount = 0;
  int _itemCount2 = 0;
  bool isChecked = false;
  double _itemPrice = 4.99;
  double _itemPrice2 = 9.99;

  void _incrementCounter2() {
    setState(() {
      _itemCount2++;
    });
  }

  void _decrementCounter2() {
    if (_itemCount2 >= 1) {
      setState(() {
        _itemCount2--;
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _itemCount++;
    });
  }

  void _decrementCounter() {
    if (_itemCount >= 1) {
      setState(() {
        _itemCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 70,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 75.0),
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            deliverTo(),
            itemsCount(),
            payment(),
            button(),
          ],
        ),
      )),
    );
  }

  Widget payment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topCenter,
        height: 530,
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 10, right: 10),
                      child: TabBar(
                        labelColor: Colors.red,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.red,
                        tabs: [
                          Tab(text: 'Pay in Advance'),
                          Tab(text: 'Cash on Delivery'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 470,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: TabBarView(
                      children: <Widget>[
                        Container(child: advancePay()),
                        Container(height: 430, child: cashOnDelivery())
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget cashOnDelivery() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          height: 350,
          child: Column(
            children: [Image.asset("assets/image.png")],
          ),
        ),
      ),
    );
  }

  Widget advancePay() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 45,
                          width: 45,
                          child:
                              Image.asset("assets/visa.png", fit: BoxFit.cover),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 239, 230, 1),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Ahmed Khalid ",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      "Ends with 7009 ",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: RoundCheckBox(
                        size: 30,
                        onTap: (selected) {},
                        uncheckedColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(200, 204, 213, 1),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Image.asset(
                              "assets/master.png",
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 239, 230, 1),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Ahmed Khalid ",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      Text(
                        "Ends with 1433 ",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: RoundCheckBox(
                          size: 30,
                          onTap: (selected) {},
                          uncheckedColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddNewPayment(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Add New Card",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Use Wallet Balance?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Icon(
                            FontAwesomeIcons.wallet,
                            color: Color.fromRGBO(223, 59, 50, 1),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text("45.00 LE",
                                style: TextStyle(fontSize: 17))),
                        Padding(
                          padding: const EdgeInsets.only(left: 120.0),
                          child: RoundCheckBox(
                            size: 30,
                            onTap: (selected) {},
                            uncheckedColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17.0),
                child: Text(
                  "Use Coupon?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Icon(
                              FontAwesomeIcons.percentage,
                              color: Color.fromRGBO(223, 59, 50, 1),
                            ),
                            hintText: 'Coupon here...'),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 245, 247, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 80,
                      child: Text("Apply"),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 200, 48, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemsCount() {
    double item2 = _itemPrice2 * _itemCount2;
    double item1 = _itemPrice * _itemCount;
    double total = item1 + item2;
    if (total > 0) {
      total = total - 1;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 650,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 15),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 50,
                      width: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                              "https://www.clipartmax.com/png/middle/166-1668441_aus-svg-automatisch-erzeugte-png-grafiken-in-verschiedenen-dominos-pizza-logo-png.png"))),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      "Domino's",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                          "https://image.flaticon.com/icons/png/512/1404/1404945.png"),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prime Beef - Pizza Beautiful",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 245, 247, 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        _decrementCounter();
                                      },
                                      elevation: 1.0,
                                      fillColor:
                                          Color.fromRGBO(193, 199, 208, 1),
                                      child: Icon(
                                        Icons.remove,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Text(
                                    "$_itemCount",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        _incrementCounter();
                                      },
                                      elevation: 1.0,
                                      fillColor: Color.fromRGBO(223, 51, 19, 1),
                                      child: Icon(
                                        Icons.add,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "\$ ${double.parse((item1).toStringAsFixed(2))}",
                                style: TextStyle(
                                  color: Color.fromRGBO(223, 51, 19, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Container(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                          "https://image.flaticon.com/icons/png/512/1404/1404945.png"),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prime Beef - Pizza Beautiful",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(244, 245, 247, 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          _decrementCounter2();
                                        },
                                        elevation: 1.0,
                                        fillColor:
                                            Color.fromRGBO(193, 199, 208, 1),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                    Text(
                                      "$_itemCount2",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          _incrementCounter2();
                                        },
                                        elevation: 1.0,
                                        fillColor:
                                            Color.fromRGBO(223, 51, 19, 1),
                                        child: Icon(
                                          Icons.add,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "\$ ${double.parse((item2).toStringAsFixed(2))}",
                                style: TextStyle(
                                  color: Color.fromRGBO(223, 51, 19, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Divider(
                indent: 15,
                endIndent: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Subtotal "),
                  Text(
                      "\$ ${double.parse((item2 + item1).toStringAsFixed(2))}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Divider(
                indent: 15,
                endIndent: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delivery  "),
                  Text("\$ 0.00"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Divider(
                indent: 15,
                endIndent: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Voucher  "),
                  Text("-\$ 1.00"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Divider(
                indent: 15,
                endIndent: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total "),
                  Text(
                    "\$ ${double.parse((total).toStringAsFixed(2))}",
                    style: TextStyle(
                      color: Color.fromRGBO(223, 51, 19, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget deliverTo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 20),
                      child: Text(
                        "Delivery to",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Divider(
                    height: 5,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/location.PNG",
                              fit: BoxFit.fitHeight,
                            )),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mubeen Ul Haq",
                                style: TextStyle(fontSize: 17),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "(92) 323 0486821",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text("46 Mansour Street, Mit Ghamer. "),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "1.5 Km",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget button() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 60,
            //     width: 300,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           "assets/apple.png",
            //           color: Colors.white,
            //         ),
            //         Text(
            //           "Apple Pay",
            //           style: TextStyle(color: Colors.white, fontSize: 17,fontWeight:FontWeight.bold),
            //         )
            //       ],
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.black,
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      // contentPadding: EdgeInsets.all(0),
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -45,
                            left: MediaQuery.of(context).size.width / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              width: 50,
                              height: 50,
                              child: Icon(Icons.check_rounded,
                                  color: Colors.white, size: 40),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Order Success!',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  'Your Order is Placed',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "Place Order",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 200, 48, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
