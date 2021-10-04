import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

import '../functions.dart';
import 'displayShop.dart';

class AddNewShop extends StatefulWidget {
  // const AddNewShop({ Key? key }) : super(key: key);

  @override
  _AddNewShopState createState() => _AddNewShopState();
}

class _AddNewShopState extends State<AddNewShop> {
  // List<File> multifile = [];
  File file;
  var logo;
  var len;
  String title;
  var contact;
  var address;
  var shoptype;

  TextEditingController titleController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController shoptypeController = TextEditingController();
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
                "Add New Shops",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // height: 50,
                  width: width,
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      title = value;
                    },
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    //   setState(() {
                    //     addressList.add(value);
                    //   });
                    //   addressController.clear();
                    // },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Shop Title",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(195, 153, 141, 1)),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // height: 50,
                  width: width,
                  child: TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      address = value;
                    },
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    //   setState(() {
                    //     addressList.add(value);
                    //   });
                    //   addressController.clear();
                    // },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Shop Address",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(195, 153, 141, 1)),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // height: 50,
                  width: width,
                  child: TextFormField(
                    controller: contactController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      contact = value;
                    },
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    //   setState(() {
                    //     addressList.add(value);
                    //   });
                    //   addressController.clear();
                    // },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Shop Contact",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(195, 153, 141, 1)),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 247, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // height: 50,
                  width: width,
                  child: TextFormField(
                    controller: shoptypeController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      shoptype = value;
                    },
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    //   setState(() {
                    //     addressList.add(value);
                    //   });
                    //   addressController.clear();
                    // },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Shop Type",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(195, 153, 141, 1)),
                    ),
                  )),
              InkWell(
                onTap: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    file = File(result.files.first.path);
                  } else {
                    print('File not Picked');
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                  decoration: BoxDecoration(
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
                  print('title = $title');

                  // MultipartFile.fromFile(file.path).then((value) {
                  //    print('multifile = $value');
                  // });
                  print('logo = $logo');
                  print('contact = $contact');
                  print('address = $address');
                  print('shoptype = $shoptype');

                  addNewShoop(context);
                  //   showAlert(
                  //   context: context,
                  //   title: "You Product is Creating Wait for Some while",
                  //   actions: [
                  //     AlertAction(
                  //         text: "Ok ",
                  //         isDestructiveAction: true,
                  //         onPressed: () {

                  //         }),
                  //   ],
                  //   cancelable: true,
                  // );
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Save',
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

  addNewShoop(context) async {
    MultipartFile.fromFile(file.path).then((value) {
      setState(() {
        logo = value;
      });
      print('logo = $logo');
    });
    Timer(Duration(seconds: 1), () async {
      try {
        var formData = FormData.fromMap({
          //         print('logo = $logo');
          //         print('contact = $contact');
          //         print('address = $address');
          //         print('shoptype = $shoptype');
          "title": "$title",
          "logo": logo,
          "contact": "$contact",
          "address": "$address",
          "shopetype": "$shoptype",
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $stringValue';

        // print({
        //   "title": "$title",
        //   "contact": "$contact",
        //   "address": "$address",
        //   "shopetype": "$shoptype",
        //   "logo": logo,
        // });
        var response = await dio.post(
            "https://wassl.einnovention.tech/api/vendor/shop",
            data: formData);
        print("Become Vender: $response");

        Map gg = response.data;
        print('gg = $gg');
        print('message = ${gg['Message']}');
        if (gg['Message'] == 'Record Stored!') {
          print('Shop Created Successfully');
          showAlert(
            context: context,
            title: "Shop Created Successfully",
            actions: [
              AlertAction(
                  text: "Ok ",
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ShopDisplay(),
                      ),
                    );
                  }),
            ],
            cancelable: true,
          );
        } else {
          showAlert(
            context: context,
            title: "Shop Not Created",
            actions: [
              AlertAction(
                  text: "Ok ",
                  isDestructiveAction: true,
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => ShopDisplay(),
                    //   ),
                    // );
                  }),
            ],
            cancelable: true,
          );
        }
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          print(e.response.data);
          print(e.response.headers);
          // print(e.response.request)
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          // print(e.request);
          print(e.message);
        }
      }
    });
  }
}
