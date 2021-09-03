import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wssal_vender/functions.dart';
import 'package:wssal_vender/product/productGridCard.dart';
import 'package:wssal_vender/product/updateProduct.dart';

import 'addProduct.dart';

class AllProduct extends StatefulWidget {
  // const AllProduct({ Key? key }) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  String searchKeyword = '';
  TextEditingController seachController = TextEditingController();
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
          title: Text(
            "All Product",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
      ),
      bottomNavigationBar: getbottomBar(1, context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // margin: EdgeInsets.only(left: 30),
                  height: 50,
                  width: width,
                  child: TextFormField(
                    controller: seachController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      // setState(() {
                      //   searchKeyword = value.toLowerCase();
                      // });
                    },
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    //   setState(() {
                    //   addressList.add(value);
                    //   });
                    //   addressController.clear();
                    // },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        labelText: '     Search Product'),
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                ),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: buildProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> buildProducts() async {
    List<Widget> x = [];
    try {
      var url = 'https://wassldev.einnovention.tech/api/vendor/products';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('buildProductsResponse: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          x.add(ProductsGridCard(element));
        });
        return Container(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: x,
          ),
        );
      } else {
        return Text("No Products Available");
      }
    } catch (e) {
      return Text('No Products');
    }
  }

  //  Edit Product

}
