import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 5,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Order Details",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "#436789237 (04 August 2021)",
                                style: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "",
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: Color.fromRGBO(222, 53, 11, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Home",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "",
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.credit_card,
                                        size: 20,
                                        color: Color.fromRGBO(222, 53, 11, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Cash",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "",
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.check_circle,
                                        size: 20,
                                        color: Color.fromRGBO(222, 53, 11, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Delivered",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  child: Image.asset("assets/domino.png"),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Domino's",
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                            height: 100,
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 100,
                                    child: Image(
                                        image: AssetImage('assets/pizza.png')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                "Pizza Beef - Pizza fdhjkk",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 48.0),
                                              child: Text(
                                                "\$5.99",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      222, 53, 11, 1),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Divider(),
                        Container(
                            height: 100,
                            width: 400,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 100,
                                    child: Image(
                                        image: AssetImage('assets/pizza.png')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                "Pizza Beef - Pizza fdhjkk",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 48.0),
                                              child: Text(
                                                "\$5.99",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      222, 53, 11, 1),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal (2 items)",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14)),
                                Text("\$9.98",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14))
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14)),
                                Text("\$0.00",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14))
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal (2 items)",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14)),
                                Text("-\$1.00",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14))
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                                Text("\$9.98",
                                    style: TextStyle(
                                        color: Color.fromRGBO(222, 53, 11, 1),
                                        fontSize: 16))
                              ]),
                        )
                      ],
                    ),
                  ))),
        )));
  }
}
