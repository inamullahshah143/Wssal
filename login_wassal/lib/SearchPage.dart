import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wassal_customer/productDetails.dart';
import 'Cart.dart';
import 'Storedetail.dart';
import 'const.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searckKeyword = "";
  Widget returnedData = Container();
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 245, 247, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 0.25,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search a keyword",
                isDense: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
              onFieldSubmitted: (value) {
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
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                backgroundColor: Colors.red,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.yellow),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  );
                });
              },
            ),
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: returnedData,
          )),
    );
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
                        style: TextStyle( color: Colors.grey),
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
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return StoreDetail(storeBlock: element);
              },
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
                        style: TextStyle( color: Colors.grey),
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
