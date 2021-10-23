import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:wssal_vender/product/allProduct.dart';
import 'package:wssal_vender/product/updateProduct.dart';
import '../functions.dart';

String imagePath;
var productId;
var picId;

class ProductDetailsDetails extends StatefulWidget {
  final Map productData;
  ProductDetailsDetails(this.productData);
  @override
  _ProductDetailsDetailsState createState() =>
      _ProductDetailsDetailsState(productData);
}

class _ProductDetailsDetailsState extends State<ProductDetailsDetails> {
  final Map productData;
  _ProductDetailsDetailsState(this.productData);

  @override
  void initState() {
    productId = productData['id'];
    imagePath = "${productData['images'][0]['path']}";
    print("productId = $productId");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              '${productData['title']}',
              maxLines: 1,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(50, 62, 72, 1),
              ),
            ),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: true,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 10, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                height: height / 5,
                width: width,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                child: Image(
                  image: NetworkImage('$picBaseURL$imagePath'),
                ),
              ),
              Container(
                  // color: Colors.black,
                  width: width,
                  height: height / 8,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 20),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: buildImage(productData["images"]),
                  )),
              Container(
                margin: EdgeInsets.all(15),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Price ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      WidgetSpan(
                          child: Text(
                        '${productData['price']}',
                        style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                      WidgetSpan(
                          child: Text(
                        '${productData['price']}',
                        style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 13,
                        ),
                      ))
                    ])),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description : ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${productData['description']}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            print('productData = $productData');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProduct(productData)));
                          },
                        )),
                    Container(
                        child: ElevatedButton(
                      child: Text('Delete'),
                      onPressed: () {
                        // AttriId = element['id'];
                        // print('AttriId = $AttriId');
                        showAlert(
                          context: context,
                          title: "Do You Really want to  Deleted Product",
                          actions: [
                            AlertAction(
                                text: "Yes",
                                isDestructiveAction: true,
                                onPressed: () {
                                  deleteProduct();
                                }),
                          ],
                          cancelable: true,
                        );
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildImage(List descs) {
    List<Widget> x = [];
    for (final b in descs) {
      x.add(Stack(children: [
        InkWell(
          onTap: () {
            print('picId = ${b['id']}');
            picId = b['id'];
            setState(() {
              imagePath = b['path'];
              print('$imagePath');
            });
          },
          child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('$picBaseURL${b['path']}'),
                    fit: BoxFit.contain)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                print('picId = ${b['id']}');
                picId = b['id'];
                showAlert(
                  context: context,
                  title: "Do You Really want to  Deleted Image",
                  actions: [
                    AlertAction(
                        text: "Yes",
                        isDestructiveAction: true,
                        onPressed: () {
                          deleteImage();
                        }),
                  ],
                  cancelable: true,
                );
              },
              child: Icon(
                Icons.cancel_rounded,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ]));
    }
    return x;
  }

  deleteProduct() async {
    var url =
        'https://einnovention.co.uk/wassl/public/api/vendor/products/$productId';
    var response = await http.delete(Uri.parse(url),
        headers: {'Authorization': 'Bearer $stringValue'});
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');
    if (data['message'] == 'Record Deleted Successfully!') {
      showAlert(
        context: context,
        title: "Record Deleted Successfully!",
        actions: [
          AlertAction(
              text: "Ok ",
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AllProduct()));
              }),
        ],
        cancelable: true,
      );
    } else {
      showAlert(
        context: context,
        title: "Record Not Deleted",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
              //  Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => LoginPage())),
              ),
        ],
        cancelable: true,
      );
    }
  }

  deleteImage() async {
    // https://wassl.test/api/deleteProductImage/6
    var url =
        'https://einnovention.co.uk/wassl/public/api/deleteProductImage/$picId';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');
    if (data['message'] == 'File deleted Successfully') {
      showAlert(
        context: context,
        title: "File deleted Successfully",
        actions: [
          AlertAction(
              text: "Ok ",
              isDestructiveAction: true,
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AllProduct()));
                });
              }),
        ],
        cancelable: true,
      );
    } else {
      showAlert(
        context: context,
        title: "Image Not Deleted",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
              //  Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => LoginPage())),
              ),
        ],
        cancelable: true,
      );
    }
  }
}
