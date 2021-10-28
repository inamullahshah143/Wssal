import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wassal_customer/numberlogin.dart';
import 'No Internet/noInternetConnection.dart';
import 'categories_dashboard.dart';
import 'const.dart';
import 'custom_delivery.dart';

class MainCategories extends StatefulWidget {
  @override
  _MainCategoriesState createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getDashboardAppbar(context, "Categories"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              logs == true
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Image.asset(
                              "assets/Profile.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Hello,",
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.grey,
                                  fontSize: 12.0),
                            ),
                            Text(
                              "$storedName",
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.grey.shade700,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              FutureBuilder(
                future: mainCategories(context),
                builder: ((context, snap) {
                  if (snap.hasData) {
                    return snap.data;
                  } else if (snap.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: Text("No Record Found")),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor: Colors.red,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.yellow),
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
    );
  }

  Future<Widget> mainCategories(BuildContext context) async {
    try {
      var response = await http.get(Uri.parse("$apiURL/category"));
      if (json.decode(response.body)['status'] == 200) {
        List data = json.decode(response.body)['data'];
        List<Widget> x = [];
        data.forEach((element) {
          x.add(
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color.fromRGBO(244, 245, 247, 1),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDashboard(
                        categoryBlock: element,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: 300.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              imageURL + '/' + element['thumbnail']),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0),
                              Color.fromRGBO(25, 25, 25, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(7.5),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element['name'].toUpperCase(),
                                  style: TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    text: '',
                                    children: subCategory(element['children']),
                                  ),
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
            ),
          );
        });

        x.add(
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color.fromRGBO(244, 245, 247, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                if (logs == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomDelivery(),
                    ),
                  );
                } else {
                  showAlert(
                      context: context,
                      title: "Login Required",
                      cancelable: true,
                      actions: [
                        AlertAction(
                            text: "ok",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            }),
                      ]);
                }
              },
              child: Container(
                height: 300,
                child: Stack(
                  children: [
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.cannabisbusinesstimes.com/fileuploads/image/2019/06/20/Delivery-Adobe_Stock-Credit-boophuket-Resized.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0),
                              Color.fromRGBO(25, 25, 25, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(7.5),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery',
                                  style: TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'From Point to Point',
                                  style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                  ),
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
            ),
          ),
        );

        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (2),
            childAspectRatio: 1.1,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: x,
        );
      } else {
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (2),
            childAspectRatio: 1.1,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color.fromRGBO(244, 245, 247, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  if (logs == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomDelivery(),
                      ),
                    );
                  } else {
                    showAlert(
                      context: context,
                      title: "Login Required",
                      cancelable: true,
                      actions: [
                        AlertAction(
                          text: "ok",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
                child: Container(
                  height: 300,
                  child: Stack(
                    children: [
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://www.cannabisbusinesstimes.com/fileuploads/image/2019/06/20/Delivery-Adobe_Stock-Credit-boophuket-Resized.jpg'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(255, 255, 255, 0),
                                Color.fromRGBO(25, 25, 25, 1),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(7.5),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery',
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'From Point to Point',
                                    style: TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                    ),
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
              ),
            ),
          ],
        );
      }
    } catch (e) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) =>
              NoInternetConnectionScreen(className: MainCategories())));
    }
  }

  List<InlineSpan> subCategory(List data) {
    List<InlineSpan> x = [];
    for (var i = 0; i < data.length; i++) {
      if (i != data.length - 1) {
        x.add(
          TextSpan(text: '${data[i]['name']}, '),
        );
      } else {
        x.add(
          TextSpan(text: '${data[i]['name']}'),
        );
      }
    }
    return x;
  }
}
