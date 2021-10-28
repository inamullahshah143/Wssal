import 'package:flutter/material.dart';

class RateItem extends StatefulWidget {
  @override
  _RateItemState createState() => _RateItemState();
}

class _RateItemState extends State<RateItem> {
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Rate Item",
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(image: AssetImage('assets/thumb.png')),
                          ),
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "How do you feel about our food?",
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Container(
                          height: 100,
                          width: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: Image(
                                      image: AssetImage('assets/pizza.png')),
                                ),
                                Container(
                                  child: Text(
                                    "Pizza Beef - Pizza fdhjkk",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200),
                                  child: Image(
                                      height: 10,
                                      width: 10,
                                      image: AssetImage('assets/thumbup.png')),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200),
                                  child: Image(
                                      height: 10,
                                      width: 10,
                                      image:
                                          AssetImage('assets/thumbdown.png')),
                                )
                              ],
                            ),
                          )),
                    ),
                    Divider(),
                    Container(
                        height: 100,
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                child: Image(
                                    image: AssetImage('assets/pizza.png')),
                              ),
                              Container(
                                child: Text(
                                  "Pizza Beef - Pizza fdhjkk",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200),
                                child: Image(
                                    height: 10,
                                    width: 10,
                                    image: AssetImage('assets/thumbup.png')),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade200),
                                child: Image(
                                    height: 10,
                                    width: 10,
                                    image: AssetImage('assets/thumbdown.png')),
                              )
                            ],
                          ),
                        )),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade300),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Previous"),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: InkWell(
                              onTap: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
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
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3),
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
                                          padding: EdgeInsets.only(top: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Your payment success',
                                                style: TextStyle(
                                                    height: 1.5, fontSize: 16),
                                              ),
                                              Text(
                                                'Your new balance has added to your wallet',
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                                height: 1.5, color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromRGBO(255, 199, 0, 100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Submit"),
                                      ],
                                    ),
                                  )),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
