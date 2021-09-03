import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../functions.dart';
import '../home.dart';
import 'displayCategory.dart';

class AddCategory extends StatefulWidget {
  // const AddCategory({ Key? key }) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<File> multifile = [];
  var categoryName;
  var len;

  var cat;
  int catid;
  var catChildren;
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
      //   title: Text("Add Category"),
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "Add Category",
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
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    //   setState(() {
                    //     addressList.add(value);
                    //   });
                    //   addressController.clear();
                    // },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // icon: Icon(
                        //   Icons.calendar_today_outlined,
                        //   color: Color.fromRGBO(193, 199, 208, 1),
                        // ),
                        hintText: '     Description'),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                child: DropdownButtonFormField(
                  value: cat,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  decoration: new InputDecoration(
                    labelText: " Select Category",
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      catId = value['id'];
                      catChildren = value['children'];
                      // print(value);
                      //  print(catId);
                      buildDecs(value["children"]);
                      print('cat childern = $catChildren');
                    });
                  },
                  items: aSCategorie,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    multifile = [];
                  });
                  FilePicker.platform
                      .pickFiles(allowMultiple: true)
                      .then((value) {
                    value.files.forEach((element) async {
                      multifile.add(File(element.path));
                      setState(() {
                        len = multifile.length;
                        print('$len');
                      });
                    });
                  });
                  // _showPicker2(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(244, 245, 247, 1),
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 130,
                  width: 150,
                  child: len != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 245, 247, 1),
                            // color: Colors.yellow,
                            borderRadius: BorderRadius.circular(15),
                            // image: Image.file(file)
                          ),
                          height: 130,
                          width: 150,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('You have Selected $len Files')),
                          // child: Image.file(
                          //   _image1,
                          //   fit: BoxFit.cover,
                          // ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 245, 247, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 130,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select Files',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              Icon(
                                Icons.dashboard_outlined,
                                size: 30,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.arrow_circle_up_rounded,
                                size: 30,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('Ahmad');
                  showAlert(
                    context: context,
                    title: "Category is creating Wait for Some while",
                    actions: [
                      AlertAction(
                          text: "Ok ",
                          isDestructiveAction: true,
                          onPressed: () {
                            createCategory(context);
                          }),
                    ],
                    cancelable: true,
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 25),
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
      ),
    );
  }

  List<Widget> buildDecs(List descs) {
    List<Widget> x = [];
    for (final b in descs) {
      x.add(Container(
        margin: EdgeInsets.only(left: 5),
        child: Align(alignment: Alignment.centerLeft, child: Text("\n$b")),
      ));
    }
    return x;
  }

  getCategorys(context) async {
    setState(() {
      aSCategorie = [];
    });
    var url = 'https://wassl.einnovention.tech/api/vendor/categories';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
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
            value: element,
          ));
        });
      });
    }
  }

  createCategory(context) async {
    List<MultipartFile> x = [];
    multifile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x.add(value);
      });
    });

    Timer(Duration(seconds: 1), () async {
      try {
        var formData = FormData.fromMap({
          "name": "$categoryName",
          "parent_id": "$catId",
          "description": "$description",
          "thumbnail": x[0],
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $stringValue';
        // dio.options.headers["Authorization"] = "$accessToken";
        print({
          "name": "$categoryName",
          "parent_id": "$catId",
          "description": "$description",
          "thumbnail": x[0],
        });
        var response = await dio.post(
            "https://wassl.einnovention.tech/api/vendor/categories",
            data: formData);
        print("Become Vender: $response");

        var gg = response.data;
        print('${response.data['message']}');
        if (gg['message'] == 'SubCategory Successfully created!') {
          print('Category created bhai');
          showAlert(
            context: context,
            title: "Category Successfully created",
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
        }
      } on Exception catch (e) {
        print('$e');
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
                  //     builder: (BuildContext context) => DisplayCategory(),
                  //   ),
                  // );
                }),
          ],
          cancelable: true,
        );
      }
    });
  }
}
