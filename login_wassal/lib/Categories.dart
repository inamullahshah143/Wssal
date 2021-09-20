import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'const.dart';
import 'categorydetail.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MainCategories extends StatefulWidget {
  @override
  _MainCategoriesState createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {
  Position currentPosition;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: getBottomBar(context),
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(context, "Categories"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  height: height - 225,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: SingleChildScrollView(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello,",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                      ),
                                      Text(
                                        "$storedName",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 18.0),
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
                              return Text("${snap.error}");
                            } else {
                              return Center(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.yellow),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> mainCategories(BuildContext context) async {
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
                    builder: (context) =>
                        CategoryDetail(categoryBlock: element),
                  ),
                );
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
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              imageURL + '/' + element['thumbnail']),
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
                                  element['name'].toUpperCase(),
                                  style: TextStyle(
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
          ),
        );
      });
      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (2),
          childAspectRatio: 1.3,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: x,
      );
    } else {
      return Center(child: Text("No Products Available"));
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
