import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Storedetail.dart';
import 'const.dart';

class AllShops extends StatefulWidget {
  @override
  _AllShopsState createState() => _AllShopsState();
}

class _AllShopsState extends State<AllShops> {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      bottomNavigationBar: getBottomBar(context),
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(context, "Shops"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(children: [
                    FutureBuilder(
                      future: allShops(context),
                      builder: ((context, snap) {
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
                                  Colors.yellow,
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}

Future<Widget> allShops(BuildContext context) async {
  var response = await http.get(Uri.parse("$apiURL/allShops"));
  if (json.decode(response.body)['status'] == 200) {
    List data = json.decode(response.body)['data'];
    List<Widget> x = [];
    data.forEach((element) {
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
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // physics: NeverScrollableScrollPhysics(),
          children: x,
        ),
      ),
    );
  } else {
    return Text("No Shops Available");
  }
}
