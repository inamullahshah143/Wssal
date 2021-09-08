import 'dart:async';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wassal_customer/Cart.dart';
import 'const.dart';

class ProductDetails extends StatefulWidget {
  final Map d;
  ProductDetails({this.d});

  @override
  _ProductDetailsState createState() => _ProductDetailsState(d: d);
}

class _ProductDetailsState extends State<ProductDetails> {
  int finalPrice = 100;

  Map d;
  _ProductDetailsState({this.d});

  Timer timer;
  @override
  void initState() {
    productPriceValue = 0;
    productExtrasForCart = [];
    setState(() {
      finalPrice = d['sale_price'];
    });
    productPriceValue = d['sale_price'];
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      // print("FinalPrice: $productPriceValue");
      setState(() {
        finalPrice = productPriceValue;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return  Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      
      child: SafeArea(
              child: SingleChildScrollView(
            child: Container(
              color: Color.fromRGBO(244, 245, 247, 100),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(children: [
                  Container(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      // child: Image(
                      //   fit: BoxFit.fill,
                      //   image: NetworkImage(   imageURL + '/' + data['images'][0]['path']),
                      // ),
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1100),
                        dotSize: 6.0,
                        dotIncreasedColor: Colors.white,
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 5.0,
                        showIndicator: true,
                        indicatorBgPadding: 5.0,
                        images: d['images'].map((value) {
                          return NetworkImage(
                              imageURL + '/' + "${value['path']}");
                        }).toList(),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 25, left: 13),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(50),
                  //     child: InkWell(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: Container(
                  //         height: 30,
                  //         width: 30,
                  //         color: Color.fromRGBO(255, 254, 255, 1),
                  //         child: Icon(
                  //           Icons.arrow_back,
                  //           color: Color.fromRGBO(191, 37, 103, 1),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ]),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          d['title'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$ $finalPrice",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    d['description'],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildVariations(d['variations']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildAttributes(d['attributes']),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                finalProductsForCart.add({
                  "product_id": "${d['id']}",
                  "product_image": imageURL + '/' + "${d['images'][0]['path']}",
                  "product_name": "${d['title']}",
                  "quantity": 1,
                  "product_price": finalPrice,
                  "extras": productExtrasForCart
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 199, 0, 100),
                      borderRadius: BorderRadius.circular(15)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add To Cart (\$ ${finalPrice})",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )),
            ),
          ),
              ]),
            ),
          )),
    );
  }
}

Widget _buildVariations(List vars) {
  List<Widget> variationWidgetList = [];
  vars.forEach((element) {
    List<Widget> variationOptionWidgetList = [];
    Map varOptions = element['data'];
    variationOptionWidgetList.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                "${element['title']}",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    varOptions.forEach((key, value) {
      variationOptionWidgetList
          .add(CustomCheckBox(title: key, price: int.parse(value)));
    });

    variationWidgetList.add(Column(children: variationOptionWidgetList));
  });
  return Column(children: variationWidgetList);
}

Widget _buildAttributes(List attr) {
  List<Widget> attributesWidgetList = [];
  attr.forEach((element) {
    List<Widget> attributesOptionWidgetList = [];
    Map attributesOptions = element['data'];
    attributesOptionWidgetList.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                "${element['title']}",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    attributesOptions.forEach((key, value) {
      attributesOptionWidgetList
          .add(CustomCheckBox(title: key, price: int.parse(value)));
    });

    attributesWidgetList.add(Column(children: attributesOptionWidgetList));
  });
  return Column(children: attributesWidgetList);
}

class CustomCheckBox extends StatefulWidget {
  final int price;
  final String title;
  CustomCheckBox({@required this.title, @required this.price});

  @override
  _CustomCheckBoxState createState() =>
      _CustomCheckBoxState(title: title, price: price);
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  final int price;
  final String title;
  _CustomCheckBoxState({@required this.title, @required this.price});
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                //  shape: CircleBorder(),
                activeColor: Colors.white,
                checkColor: Colors.redAccent,
                value: _value,

                onChanged: (bool value) {
                  Map data = {"title": title, "price": price};
                  if (value) {
                    productExtrasForCart.add(data);
                    productPriceValue = productPriceValue + price;
                  } else {
                    productExtrasForCart
                        .removeWhere((element) => element == data);
                    productPriceValue = productPriceValue - price;
                  }
                  setState(() {
                    _value = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("$title"),
              ),
            ],
          ),
          Text("+ \$ $price"),
        ],
      ),
    );
  }
}
