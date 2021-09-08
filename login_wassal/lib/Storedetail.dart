import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'productDetails.dart';
import 'subcategory.dart';
import 'const.dart';

class StoreDetail extends StatefulWidget {
  final Map storeBlock;
  StoreDetail({@required this.storeBlock});
  @override
  _StoreDetailState createState() => _StoreDetailState(storeBlock: storeBlock);
}

class _StoreDetailState extends State<StoreDetail> {
  final Map storeBlock;
  _StoreDetailState({@required this.storeBlock});
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Container(
      height: MediaQuery.of(context).size.height - 120,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    showIndicator: false,
                    indicatorBgPadding: 5.0,
                    images: [
                      NetworkImage(
                          imageURL + '/' + "${storeBlock['cover']}")
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: buildProducts(context),
                builder: ((context, AsyncSnapshot<Widget> snap) {
                  if (snap.hasData) {
                    return snap.data;
                  } else if (snap.hasError) {
                    return Text("${snap.error}");
                  } else {
                    return Center(
                        child: Container(
                            child: CircularProgressIndicator(
                                strokeWidth: 10,
                                backgroundColor: Colors.red,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.yellow))));
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> buildProducts(BuildContext context) async {
    var response = await http
        .get(Uri.parse("$apiURL/shopProducts/${storeBlock['id']}"), headers: {
      'Authorization': 'Bearer $loginToken',
    });
    print("buildProducts: ${response.body}");
    if (json.decode(response.body)['status'] == 200) {
      List data = json.decode(response.body)['products'];
      List<Widget> x = [];
      data.forEach((element) {
        x.add(
          InkWell(
            onTap: () {
              http
                  .get((Uri.parse("$apiURL/productDetail/${element['id']}")))
                  .then((value) {
                if (value.statusCode == 200) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return ProductDetails(d: json.decode(value.body)['data']);
                    },
                  );
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 125,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageURL +
                                  '/' +
                                  '${element['images'][0]['path']}',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.all(5),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(text: " "),
                                    TextSpan(
                                      text: "${element['average_rating']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              height: 25,
                              width: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      imageURL + '/${storeBlock['logo']}'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 5),
                            child: Text(
                              "${storeBlock['title']}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "${element['title']}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: storeBlock['open_close'] == 1
                                  ? 'Open'
                                  : 'Close',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: storeBlock['open_close'] == 1
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.circle,
                                  size: 5,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: "Burger",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "",
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.alarm,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: " ",
                                ),
                                TextSpan(
                                  text: "30-45 min",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "",
                                ),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.delivery_dining,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: " ",
                                ),
                                TextSpan(
                                  text: "\$ 20",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
      return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(8),
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: x,
      );
    } else {
      return Text("No Products Available");
    }
  }
}
