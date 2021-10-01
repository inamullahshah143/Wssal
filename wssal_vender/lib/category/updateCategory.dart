
import 'dart:convert';
import 'dart:io';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../functions.dart';
import 'displayCategory.dart';

class UpdateCategory extends StatefulWidget {
  final categoryid;
  final categorypic;
  UpdateCategory(this.categoryid, this.categorypic);
  @override
  _UpdateCategoryState createState() =>
      _UpdateCategoryState(categoryid, categorypic);
}

class _UpdateCategoryState extends State<UpdateCategory> {
  final categoryid;
  final categorypic;
  _UpdateCategoryState(this.categoryid, this.categorypic);
  List<File> multifile = [];
  var categoryName;
  var len;
  int cat;
  String description;
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<DropdownMenuItem<dynamic>> aSCategorie = [];
  void initState() {
    getCategorys(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   title: Text("Update Category"),
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "Update Category",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 25, left: 15, right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                height: 200,
                width: width,
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage('$picBaseURL$categorypic'),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  child: TextFormField(
                    controller: categoryController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      categoryName = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '     Category Name'),
                  )),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       multifile = [];
              //     });
              //     FilePicker.platform
              //         .pickFiles(allowMultiple: true)
              //         .then((value) {
              //       value.files.forEach((element) async {
              //         multifile.add(File(element.path));
              //         setState(() {
              //           len = multifile.length;
              //           print('$len');
              //         });
              //       });
              //     });
              //     // _showPicker2(context);
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(top: 10),
              //     decoration: BoxDecoration(
              //       // color: Color.fromRGBO(244, 245, 247, 1),
              //       color: Colors.yellow,
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     height: 130,
              //     width: 150,
              //     child: len != null
              //         ? Container(
              //             decoration: BoxDecoration(
              //               color: Color.fromRGBO(244, 245, 247, 1),
              //               // color: Colors.yellow,
              //               borderRadius: BorderRadius.circular(15),
              //               // image: Image.file(file)
              //             ),
              //             height: 130,
              //             width: 150,
              //             child: Align(
              //                 alignment: Alignment.center,
              //                 child: Text('You have Selected $len Files')),
              //             // child: Image.file(
              //             //   _image1,
              //             //   fit: BoxFit.cover,
              //             // ),
              //           )
              //         : Container(
              //             padding: EdgeInsets.only(top: 5, bottom: 5),
              //             decoration: BoxDecoration(
              //               color: Color.fromRGBO(244, 245, 247, 1),
              //               borderRadius: BorderRadius.circular(15),
              //             ),
              //             height: 130,
              //             width: 150,
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Select Files',
              //                   style:
              //                       TextStyle(color: Colors.black, fontSize: 16),
              //                 ),
              //                 Icon(
              //                   Icons.dashboard_outlined,
              //                   size: 30,
              //                   color: Colors.black,
              //                 ),
              //                 Icon(
              //                   Icons.arrow_circle_up_rounded,
              //                   size: 30,
              //                   color: Colors.black,
              //                 ),
              //               ],
              //             ),
              //           ),
              //   ),
              // ),
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  child: TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '     Description'),
                  )),
              // Container(
              //   color: Colors.grey[300],
              //   margin: EdgeInsets.all(10),
              //   child: DropdownButtonFormField(
              //     value: cat,
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 12,
              //     ),
              //     decoration: new InputDecoration(
              //       labelText: " Select Category",
              //       labelStyle: TextStyle(
              //         fontSize: 12,
              //       ),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         cat = value;
              //         print('$cat');
              //       });
              //     },
              //     items: aSCategorie,
              //   ),
              // ),
              InkWell(
                onTap: () {
                  print('Ahmad');
                  showAlert(
                    context: context,
                    title: "You Category is Updating Wait for Some while",
                    actions: [
                      AlertAction(
                          text: "Ok ",
                          isDestructiveAction: true,
                          onPressed: () {
                            // updateCategory(context);
                            upcat2(context);
                          }),
                    ],
                    cancelable: true,
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
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
                      'Update Category',
                      style: TextStyle(color: Colors.black45),
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

  getCategorys(context) async {
    setState(() {
      aSCategorie = [];
    });
    try {
      var url = 'https://wassl.einnovention.tech/api/vendor/categories';
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $stringValue'});
      print('Category: ${response.body}');
      List data = json.decode(response.body)['data'];
      if (data.length > 0) {
        data.forEach((element) {
          setState(() {
            aSCategorie.add(DropdownMenuItem(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: NetworkImage(
                                '$picBaseURL${element['thumbnail']}'))),
                  ),
                  Text('${element['name']}'),
                ],
              ),
              value: element['id'],
            ));
          });
        });
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

  // updateCategory(context) async {
  //   List<MultipartFile> x = [];
  //   multifile.forEach((element) {
  //     MultipartFile.fromFile(element.path).then((value) {
  //       x.add(value);
  //     });
  //   });

  //   Timer(Duration(seconds: 1), () async {
  //     var formData = FormData.fromMap({
  //       "name": "$categoryName",
  //       // "parent_id": "0",
  //       "description": "$description",
  //       // "thumbnail": x[0],
  //     });

  //     Dio dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $stringValue';
  //     // dio.options.headers["Authorization"] = "$accessToken";
  //     print({
  //       "name": "$categoryName",
  //       // "parent_id": "$cat",
  //       "description": "$description",
  //       // "thumbnail": x[0],
  //     });
  //     try {
  //       var response = await dio.put(
  //           "https://wassl.einnovention.tech/api/vendor/categories/$categoryid",
  //           data: formData);

  //     print("Become Vender: $response");
  //     var gg = response.data;
  //     print('${response.data['message']}');
  //     if (gg['message'] == 'Category Updated Successfully created!') {
  //       print('Category created bhai');
  //       showAlert(
  //         context: context,
  //         title: "Category Successfully created",
  //         actions: [
  //           AlertAction(
  //               text: "Ok ",
  //               isDestructiveAction: true,
  //               onPressed: () {
  //                 Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (BuildContext context) => DisplayCategory(),
  //                   ),
  //                 );
  //               }),
  //         ],
  //         cancelable: true,
  //       );
  //     }
  //     } on Exception catch (e) {
  //       print(e);
  //         showAlert(
  //         context: context,
  //         title: "$e",
  //         actions: [
  //           AlertAction(
  //               text: "Ok ",
  //               isDestructiveAction: true,
  //               onPressed: () {
  //                 // Navigator.pushReplacement(
  //                 //   context,
  //                 //   MaterialPageRoute(
  //                 //     builder: (BuildContext context) => Home(),
  //                 //   ),
  //                 // );
  //               }),
  //         ],
  //         cancelable: true,
  //       );
  //     }

  //   });
  // }

  upcat2(context) async {
    try {
      var url =
          'https://wassl.einnovention.tech/api/vendor/categories/$categoryid';
      var response = await http.put(
        Uri.parse(url),
        body: {
          "name": "$categoryName",
          "description": "$description",
          'thumbnail': '$categorypic',
        },
        headers: {'Authorization': 'Bearer $stringValue'},
      );
      print({
        "name": "$categoryName",
        "description": "$description",
      });
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('$data');

      if (data['message'] == 'Category Updated Successfully created!') {
        showAlert(
          context: context,
          title: "Category Successfully updated",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DisplayCategory(),
                    ),
                  );
                }),
          ],
          cancelable: true,
        );
      } else {
        showAlert(
          context: context,
          title: "Category not updated",
          actions: [
            AlertAction(
                text: "Ok ", isDestructiveAction: true, onPressed: () {}),
          ],
          cancelable: true,
        );
      }
    } on Exception catch (e) {
      showAlert(
        context: context,
        title: "$e",
        actions: [
          AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}),
        ],
        cancelable: true,
      );
    }
  }
}
