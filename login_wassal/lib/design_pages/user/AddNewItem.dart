import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // height: MediaQuery.of(context).size.height / 1.1,
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 150,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              "asset/pizza.png",
                              fit: BoxFit.fill,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Pizza Beef - Pizza Beautiful",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(244, 245, 247, 1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                // _decrementCounter();
                                              },
                                              elevation: 1.0,
                                              fillColor: Color.fromRGBO(
                                                  193, 199, 208, 1),
                                              child: Icon(
                                                Icons.remove,
                                                size: 15.0,
                                                color: Colors.white,
                                              ),
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                          Text(
                                            // "$_itemCount",
                                            "1",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                // _incrementCounter();
                                              },
                                              elevation: 1.0,
                                              fillColor: Color.fromRGBO(
                                                  223, 51, 19, 1),
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
                                        "4.99\$",
                                        style: TextStyle(
                                          color: Color.fromRGBO(223, 51, 19, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 230,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text(
                              "Topping",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Add Cheese",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "\$0.99",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Add Cheese",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "\$0.99",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color.fromRGBO(255, 199, 0, 100)),
                  child: Text(
                    "Add to Order ( \$7.99)",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
