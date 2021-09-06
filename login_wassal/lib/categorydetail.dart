import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
// import 'package:sticky_headers/sticky_headers.dart';
// import 'Cart.dart';
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
  bool searchClickBtn;
  bool dragButton;
  double appbarHeight;
  TabController _tabController;
  @override
  void initState() {
    appbarHeight = 75.0;
    dragButton = false;
    searchClickBtn = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: pagesBackground,
      bottomNavigationBar: getBottomBar(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  width: double.infinity,
                  height: appbarHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey[800],
                                ),
                              ),
                              searchClickBtn
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchClickBtn = false;
                                          dragButton = true;
                                          appbarHeight = 175.0;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.grey[800],
                                      ),
                                    )
                                  : Text(''),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Delivery To.',
                                    style: TextStyle(color: textcolor),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.near_me,
                                        color: themePrimaryColor,
                                      ),
                                      Text(
                                        'Home: Mit Ghamer.',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.arrow_drop_down),
                                        color: themeSecondaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                        appbarHeight >= 175
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  244, 245, 247, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  searckKeyword = value;
                                                  returnedData = FutureBuilder(
                                                    future:
                                                        searchProduct(context),
                                                    builder: ((context, snap) {
                                                      if (snap.hasData) {
                                                        return snap.data;
                                                      } else if (snap
                                                          .hasError) {
                                                        return Text(
                                                            "${snap.error}");
                                                      } else {
                                                        return Center(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Container(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .yellow),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                  );
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Search on Wssal…',
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                prefixIcon: Icon(Icons.search),
                                                contentPadding:
                                                    EdgeInsets.only(top: 15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              appbarHeight = 500;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.tune,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  appbarHeight == 500
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 25),
                                          child: Container(
                                            child: DefaultTabController(
                                              length: 3,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  TabBar(
                                                    indicatorColor:
                                                        themeSecondaryColor,
                                                    labelColor:
                                                        themeSecondaryColor,
                                                    controller: _tabController,
                                                    unselectedLabelColor:
                                                        Colors.grey[500],
                                                    tabs: [
                                                      Tab(
                                                        text: 'Category',
                                                      ),
                                                      Tab(
                                                        text: 'Sort By',
                                                      ),
                                                      Tab(
                                                        text: 'Price',
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    //Add this to give height
                                                    height: appbarHeight - 300,
                                                    child: TabBarView(
                                                      controller:
                                                          _tabController,
                                                      children: [
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          child: Row(
                                                            children: [
                                                              searchCategory(),
                                                            ],
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            child: Text(
                                                                "Sort By Body"),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            child: Text(
                                                                "Price Body"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  15.0),
                                                        ),
                                                        primary:
                                                            themePrimaryColor,
                                                      ),
                                                      child: Text(
                                                        "Complete",
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Container(
                                        height: 5,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        searchClickBtn = true;
                                        dragButton = false;
                                        appbarHeight = 75.0;
                                        returnedData = null;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              width: double.infinity,
              height: MediaQuery.of(context).size.height - (appbarHeight - 100),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: returnedData == null
                    ? Column(
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
                                  animationDuration:
                                      Duration(milliseconds: 1000),
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
                          featuredProduct(),
                          topSellingProduct(),
                          topSeller(),
                          nearby(),
                          freeDeilvery(),
                          // FutureBuilder(
                          //   future: buildProducts(context),
                          //   builder: ((context, AsyncSnapshot<Widget> snap) {
                          //     if (snap.hasData) {
                          //       return snap.data;
                          //     } else if (snap.hasError) {
                          //       return Text("${snap.error}");
                          //     } else {
                          //       return Center(
                          //         child: Padding(
                          //           padding: EdgeInsets.all(8.0),
                          //           child: Container(
                          //             child: CircularProgressIndicator(
                          //               strokeWidth: 2,
                          //               backgroundColor: Colors.red,
                          //               valueColor: AlwaysStoppedAnimation<Color>(
                          //                 Colors.yellow,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     }
                          //   }),
                          // ),
                        ],
                      )
                    : Column(
                        children: [
                          returnedData,
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchCategory() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      onTap: () {},
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(254, 199, 45, 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                              'https://purepng.com/public/uploads/large/purepng.com-fast-food-burgerburgerfast-foodhammeatfast-food-burgermc-donaldsburger-king-231519340212qzreu.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Product Name",
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
  }

  Widget foodData() {
    List data = categoryBlock['children'];
    if (data.isNotEmpty) {
      List<Widget> x = [];
      data.forEach((element) {
        x.add(
          Container(
            child: Column(
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
                                      Subcategory(subcatBlock: element),
                                ),
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
          ),
        );
      });
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 3.0,
              offset: Offset(0.0, 0.5),
            ),
          ],
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: x,
              ),
            ),
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Shop Details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1200px-Burger_King_2020.svg.png'),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Burger King',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Promoted',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RichText(
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
                                      text: "Burger",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.grey),
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
                                      text: "Sandwitch",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                            text: "4.8",
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.grey[500],
                                        size: 16.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text('25-35 Min'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delivery_dining,
                                        color: Colors.grey[500],
                                        size: 16.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text('3.5 L.E'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Text("No Sub-Categories Available");
    }
  }

  Widget featuredProduct() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 325,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Text(
              'Featured',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 125,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              'https://us.123rf.com/450wm/fahrwasser/fahrwasser1711/fahrwasser171100133/90943213-festive-celebration-roasted-turkey-for-thanksgiving.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    'https://w7.pngwing.com/pngs/159/757/png-transparent-black-charcoal-grill-with-flame-illustration-barbecue-grill-doner-kebab-hamburger-gyro-grill-food-beef-steak.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Fire Grill',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Grilled Chicken',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RichText(
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
                                  text: "Burger",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
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
                                  text: "Sandwitch",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                                      text: "4.8",
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
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: Colors.grey[500],
                                  size: 16.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('25-35 Min'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  color: Colors.grey[500],
                                  size: 16.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('3.5 L.E'),
                                )
                              ],
                            ),
                          ],
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
    );
  }

  Widget topSellingProduct() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10),
            child: Text(
              'Top Selling',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(),
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(8),
            crossAxisSpacing: 10,
            childAspectRatio: 0.9,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
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
                                'https://media-cdn.tripadvisor.com/media/photo-s/0a/c0/7c/98/best-pizza-in-lahore.jpg',
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
                                        text: "4.8",
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
                                        'https://w7.pngwing.com/pngs/159/757/png-transparent-black-charcoal-grill-with-flame-illustration-barbecue-grill-doner-kebab-hamburger-gyro-grill-food-beef-steak.png'),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 5),
                              child: Text(
                                "Fire Grill",
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
                          "Food",
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
            ],
          ),
        ],
      ),
    );
  }

  Widget topSeller() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180.0,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 8),
            child: Text(
              'Top Seller',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 100.0,
                        width: 75.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://i.pinimg.com/originals/1b/ee/08/1bee08aa56544de70e0c6bffe4a944a4.jpg',
                                width: 75.0,
                                height: 75.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Domino's",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
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
          ),
        ],
      ),
    );
  }

  Widget nearby() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 325,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Text(
              'Nearby',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 250.0,
                    width: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 125,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              'https://us.123rf.com/450wm/fahrwasser/fahrwasser1711/fahrwasser171100133/90943213-festive-celebration-roasted-turkey-for-thanksgiving.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                    'https://w7.pngwing.com/pngs/159/757/png-transparent-black-charcoal-grill-with-flame-illustration-barbecue-grill-doner-kebab-hamburger-gyro-grill-food-beef-steak.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Fire Grill',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Grilled Chicken',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RichText(
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
                                  text: "Burger",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
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
                                  text: "Sandwitch",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                                      text: "4.8",
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
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: Colors.grey[500],
                                  size: 16.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('25-35 Min'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.delivery_dining,
                                  color: Colors.grey[500],
                                  size: 16.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('3.5 L.E'),
                                )
                              ],
                            ),
                          ],
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
    );
  }

  Widget freeDeilvery() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(0.0, 0.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10),
            child: Text(
              'Free Deilvery',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Divider(),
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(8),
            crossAxisSpacing: 10,
            childAspectRatio: 0.9,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
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
                                'https://media-cdn.tripadvisor.com/media/photo-s/0a/c0/7c/98/best-pizza-in-lahore.jpg',
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
                                        text: "4.8",
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
                                        'https://w7.pngwing.com/pngs/159/757/png-transparent-black-charcoal-grill-with-flame-illustration-barbecue-grill-doner-kebab-hamburger-gyro-grill-food-beef-steak.png'),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 5),
                              child: Text(
                                "Fire Grill",
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
                          "Food",
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
            ],
          ),
        ],
      ),
    );
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
