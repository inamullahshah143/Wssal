import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wssal_vender/functions.dart';
import 'package:wssal_vender/product/productDetailsPage.dart';
import 'package:wssal_vender/product/updateProduct.dart';

import 'allProduct.dart';

class ProductsGridCard extends StatefulWidget {
  final Map productData;
  ProductsGridCard(this.productData);

  @override
  _ProductsGridCardState createState() => _ProductsGridCardState(productData);
}

class _ProductsGridCardState extends State<ProductsGridCard> {
  final Map productData;
  _ProductsGridCardState(this.productData);

  bool featuredstatus;
  bool publishedstatus;
  var feture;
  var statuss;
  var productId;
  var picId;
  @override
  // void initState() {
  //   productId = productData['id'];
  //   if (productData['featured'] == 1) {
  //     featuredstatus = true;
  //   } else if (productData['featured'] == 0) {
  //     featuredstatus = false;
  //   }
  //   if (productData['status'] == 1) {
  //     publishedstatus = true;
  //   } else if (productData['status'] == 0) {
  //     publishedstatus = false;
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Container(
      // height: 50,
      width: width,
      child: Column(
        children: [
          ListTile(
              minVerticalPadding: 4.0,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.network(productData['images'].isNotEmpty
                    ? '$picBaseURL${productData['images'][0]['path']}'
                    : ""),
              ),
              // leading:       Container(
              //         width: 60,
              //         height: 60,
              //         padding: const EdgeInsets.symmetric(vertical: 4.0),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.white),
              //             borderRadius: BorderRadius.circular(10),
              //             image: DecorationImage(
              //                 fit: BoxFit.contain,
              //                 image: NetworkImage(
              //                     '$picBaseURL${productData['images'][0]['path']}'))),
              //       ),
              title: Text(
                '${productData['title']}',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(50, 62, 72, 1),
                ),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(child: Text('${productData['price']}')),
                  WidgetSpan(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 13,
                      ),
                      child: Text('${productData['sale_price']}',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red)),
                    ),
                  ),
                ])),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsDetails(productData)));
                },
                child: Icon(Icons.edit),
              )),
          // Image(image: NetworkImage('$picBaseURL${productData['images'][0]['path']}'),)
          // leading: Text('${productData['images'][0]['id']}')
          // Image(image: NetworkImage(''),),

          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Divider(
              thickness: 0.1,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildImage(List descs) {
    List<Widget> x = [];
    if (descs.isNotEmpty) {
      for (final b in descs) {
        x.add(Stack(children: [
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('$picBaseURL${b['path']}'),
                    fit: BoxFit.contain)),
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
                  Icons.cancel,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ]));
      }
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
                Navigator.push(context,
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

  featuredstate() async {
    var url = 'https://wassl.einnovention.tech/api/feature/$productId';
    var response = await http.post(Uri.parse(url), body: {
      'featured': '$feture',
    });
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');
    if (data['message'] == 'published') {
      showAlert(
        context: context,
        title: "Product Added as Featured",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
              //  Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => LoginPage())),
              ),
        ],
        cancelable: true,
      );
    } else {
      showAlert(
        context: context,
        title: "Product Added as Featured",
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

  publishstate() async {
    var url = 'https://wassl.einnovention.tech/api/status/$productId';
    var response = await http.post(Uri.parse(url), body: {
      'status': '$statuss',
    });
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');
    if (data['message'] == 'published') {
      showAlert(
        context: context,
        title: "Product Published",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}
              //  Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => LoginPage())),
              ),
        ],
        cancelable: true,
      );
    } else {
      showAlert(
        context: context,
        title: "Product Unpublishe",
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
    var url =
        'https://einnovention.co.uk/wassl/public/api/vendor/deleteimg/$picId';
    var response = await http.delete(Uri.parse(url),
        headers: {'Authorization': 'Bearer $stringValue'});
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print('$data');
    if (data['message'] == 'Image Deleted Successfully !') {
      showAlert(
        context: context,
        title: "Image Deleted Successfully!",
        actions: [
          AlertAction(
              text: "Ok ",
              isDestructiveAction: true,
              onPressed: () {
                setState(() {});
                //   setState(() {
                //  Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => AllProduct()));
                //   });
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

  editProducts() async {
    var url =
        'https://einnovention.co.uk/wassl/public/api/vendor/edit/$productId';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    // print('buildProductsResponse: ${response.body}');
    var data = json.decode(response.body);
    if (data.length > 0) {
      print('data = ${data['data']}');
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateProduct(data['data'])));
      });
    } else {
      Text("No Products Available");
    }
  }
}
