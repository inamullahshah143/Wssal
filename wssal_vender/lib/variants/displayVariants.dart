import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:wssal_vender/variants/updateVariants.dart';

import '../functions.dart';
import 'addVariants.dart';

class DisplayVariants extends StatefulWidget {
  // const DisplayVariants({ Key? key }) : super(key: key);

  @override
  _DisplayVariantsState createState() => _DisplayVariantsState();
}

class _DisplayVariantsState extends State<DisplayVariants> {
  var variId;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "All Variants",
                style: TextStyle(color: Colors.black),
              )),
          actions: [
            Image(
              image: AssetImage('assets/app_logo.png'),
            )
          ],
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black),
          // centerTitle: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddVariants()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  margin:
                      EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                  padding: EdgeInsets.all(5),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'All Variants',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    FutureBuilder(
                      future: getvariants(),
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
                  ]))
            ])
          ],
        ),
      ),
    );
  }

  Future<Widget> getvariants() async {
    List<Widget> variants = [];

    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/vendor/varients';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Variants: ${response.body}');
      if (json.decode(response.body)['status'] == 200) {
        List data = json.decode(response.body)['data'];

        data.forEach((element) {
          variants.add(Container(
            child: Column(
              children: [
                // Text('${element['value']}'),
                Container(
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, bottom: 5, top: 15),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${element['title']}',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            )),
                        // Text('${element['data']}'),
                        valueprice(element['data']),

                        Container(
                          margin: EdgeInsets.only(
                              left: 5, top: 5, bottom: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: ElevatedButton(
                                    child: Text('Edit'),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateVariants(
                                                    element,
                                                  )));
                                    },
                                  )),
                              Container(
                                  child: ElevatedButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  variId = element['id'];

                                  showAlert(
                                    context: context,
                                    title:
                                        "Do You Really want to  Deleted Variants",
                                    actions: [
                                      AlertAction(
                                          text: "Yes",
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            deleteVariants();
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
                    )),
              ],
            ),
          ));
        });
        return Container(
          child: Column(
            children: variants,
          ),
        );
      } else {
        return Text("No Variants Available");
      }
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      return Text(
        'No Variants Available',
        style: TextStyle(color: Colors.black, fontSize: 20),
      );
      // Column(
      //   children: [
      //     Text(
      //       'Server busy',
      //       style: TextStyle(color: Colors.black, fontSize: 20),
      //     ),
      //     Text("$e")
      //   ],
      // );
    }
  }

  Widget valueprice(Map p) {
    List<TableRow> x = [];
    p.forEach((key, value) {
      x.add(TableRow(children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            key,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            value?.toString() ?? "Empty",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ]));
    });
    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(),
        children: x,
      ),
    );
  }

  deleteVariants() async {
    try {
      var url =
          'https://einnovention.co.uk/wassl/public/api/vendor/varients/$variId';
      var response = await http.delete(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('data = $data');
      if (data['message'] == 'Successfully Variation Deleted!') {
        showAlert(
          context: context,
          title: "Variation Deleted Successfully!",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisplayVariants()));
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
                //  Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (context) => LoginPage())),
                ),
          ],
          cancelable: true,
        );
      }
    } on Exception catch (e) {
      showAlert(
        context: context,
        title: "$e",
        actions: [
          AlertAction(
              text: "Ok ",
              isDestructiveAction: true,
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => Home(),
                //   ),
                // );
              }),
        ],
        cancelable: true,
      );
    }
  }
}
