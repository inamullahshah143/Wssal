import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wssal_vender/attributes/displayAttributes.dart';
import 'package:wssal_vender/shops/updateShop.dart';
import 'package:wssal_vender/variants/displayVariants.dart';

import '../functions.dart';
import 'addNewShop.dart';

class ShopDisplay extends StatefulWidget {
  @override
  _ShopDisplayState createState() => _ShopDisplayState();
}

class _ShopDisplayState extends State<ShopDisplay> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "All Shops",
                style: TextStyle(color: Colors.black),
              )),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/Logo_wssal.png'),
                      fit: BoxFit.contain)),
            ),
            // ListTile(
            //   title: Text('NewFile'),
            //   onTap: () {

            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => StoreProfile(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text('NewFile'),
            //   onTap: () {

            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => TestFile(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: Text('Variants'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DisplayVariants(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Attributes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DisplayAttributes(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          print('Ahmad');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddNewShop(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(10)),
          child: Text('Add New Shop'),
        ),
      ),
      // bottomNavigationBar: getbottomBar(0, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder(
              future: getShops(),
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
      ),
    );
  }

  Future<Widget> getShops() async {
    List<Widget> shops = [];
    try {
      var url = 'https://wassl.einnovention.tech/api/vendor/shop';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('response = ${response.body}');

      List data = json.decode(response.body)['data'];
      print(data);
      if (data.length > 0) {
        data.forEach((element) {
          shops.add(
              //  ProductsGridCard(element));
              // Text('${element['title']}'));
              InkWell(
            onTap: () {
              print('Ahmad');
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      width: width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${element['title']}',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shop Status',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          //   if (element['status'] == 0)
                          //  Text(''),
                          //   else if() ,
                          if (element['status'] == 0) ...[
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Pending'),
                              ),
                            )
                          ] else if (element['status'] == 1) ...[
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Approve'),
                              ),
                            )
                          ] else if (element['status'] == 2) ...[
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Reject'),
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contact',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text('${element['contact']}')
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text('${element['address']}')
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      height: height / 5,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image:
                                NetworkImage('$picBaseURL${element['logo']}'),
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            print(element);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateShop(element)));
                          },
                        )),
                  ],
                ),
              ),
            ),
          ));
        });
        return Container(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: shops,
          ),
        );
      } else {
        return Center(child: Text("No shops Available"));
      }
    } catch (e) {
      return Text(e);
    }
  }
}
