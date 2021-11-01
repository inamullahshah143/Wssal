import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:wssal_vender/attributes/updateAttribute.dart';

import '../functions.dart';
import 'addAttribute.dart';

class DisplayAttributes extends StatefulWidget {
  @override
  _DisplayAttributesState createState() => _DisplayAttributesState();
}

class _DisplayAttributesState extends State<DisplayAttributes> {
  Map dataa;
  var attriId;
  //     var dataaa;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "All Attributes",
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
              context, MaterialPageRoute(builder: (context) => AddAttribute()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                        'All Attributes',
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
                    future: getAttribute(),
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
          ],
        ),
      ),
    );
  }

  Future<Widget> getAttribute() async {
    List<Widget> attributes = [];
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/vendor/attributes';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('response = ${response.body}');
      if (json.decode(response.body)['status'] == 200) {
        List data = json.decode(response.body)['data'];

        data.forEach((element) {
          attributes.add(Container(
            child: Column(
              children: [
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
                        valueprice(element['data']),
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
                                      print(element);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateAttributes(element)));
                                    },
                                  )),
                              Container(
                                  child: ElevatedButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  attriId = element['id'];
                                  print('AttriId = $attriId');
                                  showAlert(
                                    context: context,
                                    title:
                                        "Do You Really want to delete this Attribute",
                                    actions: [
                                      AlertAction(
                                          text: "Yes",
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            deleteAttribute();
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
            children: attributes,
          ),
        );
      } else {
        return Text("No Attributes Available");
      }
    } catch (e) {
      return Text("$e");
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
            value,
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

  deleteAttribute() async {
    try {
      var url =
          'https://einnovention.co.uk/wassl/public/api/vendor/attributes/$attriId';
      var response = await http.delete(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('data = $data');
      if (data['message'] == 'Successfully Attribute Updated!') {
        showAlert(
          context: context,
          title: "Attribute Deleted Successfully!",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisplayAttributes()));
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
