import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateShop extends StatefulWidget {
 

  @override
  _RateShopState createState() => _RateShopState();
}

class _RateShopState extends State<RateShop> {
  @override
  Widget build(BuildContext context) {
     bool isChecked = true;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
                          child: Padding(
                           padding: const EdgeInsets.fromLTRB(0, 50, 0, 0) ,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white
                              ),
                              height:  MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                "Rate Shop",
                                                style: TextStyle(
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
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                    "https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png")),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text("Star Bucks")],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 100,
                                        child: RatingBar.builder(
                                          itemSize: 20,
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Color.fromRGBO(222, 53, 11, 1),
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Excellent",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade400,
                                              ),
                                            )
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Divider(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25.0),
                                        child: Container(
                                            height: 50,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                             color: Color.fromRGBO(244, 245, 247,1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Good Service"),
                                                  Checkbox(
                                                      activeColor: Color.fromRGBO(
                                                          222, 53, 11, 1),
                                                      value: isChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked = value;
                                                        });
                                                      })
                                                ],
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                            height: 50,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                           color: Color.fromRGBO(244, 245, 247,1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Good"),
                                                  Checkbox(
                                                      activeColor: Color.fromRGBO(
                                                          222, 53, 11, 1),
                                                      value: isChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked = value;
                                                        });
                                                      })
                                                ],
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                            height: 50,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color.fromRGBO(244, 245, 247,1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Good"),
                                                  Checkbox(
                                                      activeColor: Color.fromRGBO(
                                                          222, 53, 11, 1),
                                                      value: isChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked = value;
                                                        });
                                                      })
                                                ],
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                            height: 50,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                               color: Color.fromRGBO(244, 245, 247,1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Good"),
                                                  Checkbox(
                                                      activeColor: Color.fromRGBO(
                                                          222, 53, 11, 1),
                                                      value: isChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked = value;
                                                        });
                                                      })
                                                ],
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                            height: 50,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                               color: Color.fromRGBO(244, 245, 247,1)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Good"),
                                                  Checkbox(
                                                      activeColor: Color.fromRGBO(
                                                          222, 53, 11, 1),
                                                      value: isChecked,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChecked = value;
                                                        });
                                                      })
                                                ],
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30.0),
                                        child: InkWell(
                                          onTap: (){
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  width: 50,
                                                  height: 50,
                                                  child: Icon(
                                                      Icons.check_rounded,
                                                      color: Colors.white,
                                                      size: 40),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Your payment success',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      'Your new balance has added to your wallet',
                                                      style: TextStyle(
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
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                          },
                                          child: Container(
                                              height: 50,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color:
                                                    Color.fromRGBO(255, 199, 0, 100),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Next"),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
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