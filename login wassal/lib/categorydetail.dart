import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'package:sticky_headers/sticky_headers.dart';
import 'Cart.dart';
import 'Storedetail.dart';
import 'productDetails.dart';
import 'subcategory.dart';
import 'const.dart';

class CategoryDetail extends StatefulWidget {
  final Map categoryBlock;
  CategoryDetail({@required this.categoryBlock});
  @override
  _CategoryDetailState createState() =>
      _CategoryDetailState(categoryBlock: categoryBlock);
}

class _CategoryDetailState extends State<CategoryDetail> {
  final Map categoryBlock;
  _CategoryDetailState({@required this.categoryBlock});
  String searckKeyword;
  Widget returnedData;
  double appbarHeight;
  bool searchClickBtn, dragButton = false;
  @override
  void initState() {
    super.initState();
    searckKeyword = "";
    appbarHeight = 75.0;
    returnedData = Container();
    searchClickBtn = true;
    dragButton = false;
    returnedData = null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: getBottomBar(context),
        backgroundColor: pagesBackground,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StickyHeader(
                header: AnimatedContainer(
                  width: width,
                  height: appbarHeight,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: (appbarHeight - 25),
                        child: Container(
                          color: Colors.transparent,
                          height: appbarHeight - (appbarHeight - 25),
                          width: width,
                          child: Center(
                            child: dragButton
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        searchClickBtn = true;
                                        dragButton = false;
                                        appbarHeight = 75.0;
                                      });
                                    },
                                    child: Icon(Icons.eject),
                                  )
                                : Text(''),
                          ),
                        ),
                      ),
                      Positioned(
                        top: (appbarHeight - 250),
                        child: Container(
                          color: Colors.transparent,
                          height: appbarHeight - (appbarHeight - 250),
                          width: width,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: returnedData,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 75.0,
                        child: Container(
                          color: Colors.white,
                          height: appbarHeight - (appbarHeight - 100),
                          width: width,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.5, horizontal: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(244, 245, 247, 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 50,
                                  width: width - 125.0,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        if (returnedData != null) {
                                          appbarHeight = 400.0;
                                        } else {
                                          appbarHeight = 225.0;
                                        }
                                      });
                                      setState(() {
                                        searckKeyword = value;
                                        returnedData = FutureBuilder(
                                          future: searchProduct(context),
                                          builder: ((context, snap) {
                                            if (snap.hasData) {
                                              return snap.data;
                                            } else if (snap.hasError) {
                                              return Text("${snap.error}");
                                            } else {
                                              return Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      backgroundColor:
                                                          Colors.red,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.yellow),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                        );
                                      });
                                      setState(() {
                                        if (returnedData != null) {
                                          appbarHeight = 400.0;
                                        } else {
                                          appbarHeight = 225.0;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Search on Wssal…',
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      prefixIcon: Icon(Icons.search),
                                      contentPadding: EdgeInsets.all(15.0),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.tune,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        child: Container(
                          height: appbarHeight - (appbarHeight - 75),
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: text1color,
                                      ),
                                    ),
                                    searchClickBtn
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (returnedData != null) {
                                                  appbarHeight = 400.0;
                                                } else {
                                                  appbarHeight = 200.0;
                                                }
                                                searchClickBtn = false;
                                                dragButton = true;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.search,
                                              color: text1color,
                                            ),
                                          )
                                        : Text(''),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      child: Text(
                                        'Delivery To.',
                                        style: TextStyle(color: textcolor),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.near_me,
                                            color: themePrimaryColor,
                                          ),
                                          Text(
                                            'Home: Mit Ghamer.',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CartPage()),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: text1color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            child: Carousel(
                              boxFit: BoxFit.cover,
                              autoplay: true,
                              animationCurve: Curves.fastOutSlowIn,
                              animationDuration: Duration(milliseconds: 1000),
                              dotSize: 6.0,
                              dotIncreasedColor: Colors.white,
                              dotBgColor: Colors.transparent,
                              dotPosition: DotPosition.bottomCenter,
                              dotVerticalPadding: 5.0,
                              showIndicator: true,
                              indicatorBgPadding: 5.0,
                              images: [
                                AssetImage('assets/sliderImage.png'),
                                AssetImage('assets/sliderImage.png'),
                                AssetImage('assets/sliderImage.png'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      foodData(),
                      FutureBuilder(
                        future: buildProducts(context),
                        builder: ((context, AsyncSnapshot<Widget> snap) {
                          if (snap.hasData) {
                            return snap.data;
                          } else if (snap.hasError) {
                            return Text("${snap.error}");
                          } else {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.red,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.yellow,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget foodData() {
    List data = categoryBlock['children'];
    if (data.isNotEmpty) {
      List<Widget> x = [];
      data.forEach((element) {
        x.add(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 105,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(244, 245, 247, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Subcategory(subcatBlock: element)),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromRGBO(254, 199, 45, 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    imageURL + '/' + element['thumbnail']),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${element['name']}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.only(top: 15.0, bottom: 5, left: 5, right: 5),
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // physics: NeverScrollableScrollPhysics(),
            children: x,
          ),
        ),
      );
    } else {
      return Text("No Sub-Categories Available");
    }
  }

  Future<Widget> buildProducts(BuildContext context) async {
    var response =
        await http.get(Uri.parse("$apiURL/products/${categoryBlock['id']}"));
    print("buildProducts: ${response.body}");
    if (json.decode(response.body)['status'] == 200) {
      List data = json.decode(response.body)['data'];
      List<Widget> x = [];
      data.forEach((element) {
        x.add(
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetails(d: element)),
                          );
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image(
                                  height: 110,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(imageURL +
                                      '/' +
                                      element['images'][0]['path']),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                      child: Container(
                                        height: 25,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "",
                                                ),
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " ",
                                                ),
                                                TextSpan(
                                                  text: "${element['status']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
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
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 30,
                              width: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    imageURL +
                                        '/' +
                                        element['categories']['thumbnail'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 5),
                            child: Text(
                              "${element['categories']['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${element['title']}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Open",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.green),
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
                              text: "${element['categories']['name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
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
                                      size: 13,
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
                                      Icons.bike_scooter,
                                      size: 11,
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
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (2),
          childAspectRatio: 0.6428093645484,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: x,
      );
    } else {
      return Text("No Products Available");
    }
  }

  Future<Widget> searchProduct(BuildContext context) async {
    var response = await http.post((Uri.parse("$apiURL/searchByKeyword")),
        body: {"title": "$searckKeyword"});
    if (response.statusCode == 200) {
      List products = json.decode(response.body)['products'];
      List shops = json.decode(response.body)['shops'];
      List<Widget> x = [];
      products.forEach((element) {
        x.add(GestureDetector(
          onTap: () {
            http
                .get((Uri.parse("$apiURL/productDetail/${element['id']}")))
                .then((value) {
              if (value.statusCode == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetails(d: json.decode(value.body)['data'])),
                );
              }
            });
          },
          child: Container(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          imageURL + '/' + element['images'][0]['path']),
                    ),
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element['title'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        element['tags'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ])
            ],
          )),
        ));
      });
      shops.forEach((element) {
        x.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoreDetail(storeBlock: element)),
            );
          },
          child: Container(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(imageURL + '/' + element['logo']),
                    ),
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element['title'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        element['description'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ])
            ],
          )),
        ));
      });
      return Column(
        children: x,
      );
    } else {
      return Center(child: Text("No data found.Try another keyword"));
    }
  }
}
