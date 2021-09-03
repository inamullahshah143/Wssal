import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wssal_vender/category/updateCategory.dart';

import '../functions.dart';
import 'addCategory.dart';

List<DropdownMenuItem<dynamic>> aSCategories = [];

class DisplayCategory extends StatefulWidget {
  // const DisplayCategory({ Key? key }) : super(key: key);

  @override
  _DisplayCategoryState createState() => _DisplayCategoryState();
}

var catId;

class _DisplayCategoryState extends State<DisplayCategory> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'All Categories',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(top: 5),
                child: Image(image: AssetImage('assets/Logo_wssal.png')))
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'All Categories',
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
                    future: getCats(),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategory()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(244, 245, 247, 1),
                        color: Colors.yellow[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 50,
                      width: width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add New Category',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> getCats() async {
    List<Widget> aSCategories = [];
    try {
      var url = 'https://wassl.einnovention.tech/api/vendor/categories';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Category: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          aSCategories.add(Column(
            children: [
              ListTile(
                leading: Image(
                  image: NetworkImage('$picBaseURL${element['thumbnail']}'),
                ),
                // title: Text('$picBaseURL${element['thumbnail']}'),
                title: Text("${element['name']}"),
                subtitle: Text("${element['name']}"),
                trailing: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          print('${element['id']}');
                          print('${element['thumbnail']}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateCategory(
                                      element['id'], element['thumbnail'])));
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Icon(Icons.edit))),
                    InkWell(
                        onTap: () {
                          catId = element['id'];
                          print('catId = $catId');
                          showAlert(
                            context: context,
                            title: "Do You Really want to  Deleted Category",
                            actions: [
                              AlertAction(
                                  text: "Yes",
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    deletecategory();
                                  }
                                  //  Navigator.push(
                                  //     context, MaterialPageRoute(builder: (context) => LoginPage())),
                                  ),
                            ],
                            cancelable: true,
                          );
                        },
                        child: Icon(Icons.delete)),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              )
            ],
          ));
        });
        return Container(
          child: Column(
            children: aSCategories,
          ),
        );
      } else {
        return Text("No Category Available");
      }
    } on Exception catch (e) {
      return Column(
        children: [
          Text(
            'Server busy',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          Text("$e")
        ],
      );
    }
  }

  deletecategory() async {
    try {
      var url = 'https://wassl.einnovention.tech/api/vendor/categories/$catId';
      var response = await http.delete(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('data = $data');
      if (data['message'] == 'Category Successfully Deleted!') {
        showAlert(
          context: context,
          title: "Category Deleted Successfully!",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisplayCategory()));
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
