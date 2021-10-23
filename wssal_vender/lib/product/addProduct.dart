import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:wssal_vender/functions.dart';
import 'package:http/http.dart' as http;

import 'allProduct.dart';

class AddProduct extends StatefulWidget {
  // const AddProduct({ Key? key }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}
//  File _image1;

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  bool freeDelivery = false;
  List<File> multifile = [];
  List _tagitems = [];
  List<String> tagList = [];
  String asd = '';
  var len;
  String title;
  var price;
  var saleprice;
  String description;
  var categoryName;
  var cat;

  var catChildren;

  int categoryid;
  var subCategoryid;
  var variantsid;
  var attributesid;
  List<DropdownMenuItem<dynamic>> aSCategorie = [];
  List<DropdownMenuItem<dynamic>> aSSubCategorie = [];
  List<DropdownMenuItem<dynamic>> aSVariants = [];
  List<DropdownMenuItem<dynamic>> aSAttributes = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController salepriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool status = false;
  int statusvalue;
  void initState() {
    getCategorys(context);
    getVariantsindropdown(context);
    getAttributeindropdown(context);
    super.initState();
  }

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
              "Add Product",
              style: TextStyle(color: Colors.black),
            ),
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
        // bottomNavigationBar: getbottomBar(1, context),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: _formKey,
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
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // controller: seachController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            price = value;
                          },
                          keyboardType: TextInputType.number,
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
                            labelText: 'Regular Price',
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                // color: Color.fromRGBO(195, 153, 141, 1)
                                color: Color.fromRGBO(182, 189, 200, 1)),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: salepriceController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            saleprice = value;
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
                            labelText: 'Sale Price',
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                // color: Color.fromRGBO(195, 153, 141, 1)
                                color: Color.fromRGBO(182, 189, 200, 1)),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
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
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            // icon: Icon(
                            //   Icons.calendar_today_outlined,
                            //   color: Color.fromRGBO(193, 199, 208, 1),
                            // ),
                            labelText: 'Product Title',
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                // color: Color.fromRGBO(195, 153, 141, 1)
                                color: Color.fromRGBO(182, 189, 200, 1)),
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.only(left: 10),
                        height: 100,
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
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                // color: Color.fromRGBO(195, 153, 141, 1)
                                color: Color.fromRGBO(182, 189, 200, 1)),
                          ),
                        )),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(244, 245, 247, 1),
                      ),
                      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Tags(
                          alignment: WrapAlignment.start,
                          spacing: 2,
                          textField: TagsTextField(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(30, 92, 135, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            autofocus: false,
                            helperText: "Product Tags",
                            lowerCase: true,
                            inputDecoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: new BorderSide(
                                    color: Colors.transparent, width: 3),
                              ),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: new BorderSide(
                                    color: Colors.transparent, width: 3),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: new BorderSide(
                                    color: Colors.transparent, width: 3),
                              ),
                              // labelText: "attribute Values",
                              labelStyle: TextStyle(
                                // color: Color.fromRGBO(30, 92, 135, 1),
                                color: Colors.black45,
                                // fontSize: 16,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                            onSubmitted: (String str) {
                              if (_tagitems.length < 20) {
                                tagList.add(str);
                                setState(() {
                                  // required
                                  _tagitems.add(str);
                                });
                              } else {
                                print("Limit Reached");
                              }
                              print(tagList);
                            },
                          ),
                          itemCount: _tagitems.length, // required
                          itemBuilder: (int index) {
                            final item = _tagitems[index];

                            return ItemTags(
                              key: Key(index.toString()),
                              index: index, // required
                              title: item,

                              customData: item,
                              textStyle: TextStyle(
                                fontSize: 12,
                              ),
                              combine: ItemTagsCombine.withTextBefore,

                              removeButton: ItemTagsRemoveButton(
                                icon: Icons.remove,
                                size: 7,
                                onRemoved: () {
                                  setState(() {
                                    _tagitems.removeAt(index);
                                  });
                                  //required
                                  return true;
                                },
                              ), // OR null,
                              onPressed: (item) => print(item),
                              onLongPressed: (item) => print(item),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: DropdownButtonFormField(
                        value: cat,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: new InputDecoration.collapsed(
                          hintText: " Select Category",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              // color: Color.fromRGBO(195, 153, 141, 1)
                              color: Color.fromRGBO(182, 189, 200, 1)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            categoryid = value['id'];
                            catChildren = value['children'];
                            // print(value);
                            print("categoryid = $categoryid");
                            print('cat childern = $catChildren');
                            getsubcategory(value["children"]);
                          });
                        },
                        items: aSCategorie,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
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
                        decoration: new InputDecoration.collapsed(
                          // disabledBorder: InputBorder.none,
                          hintText: " Select Sub_Category",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              // color: Color.fromRGBO(195, 153, 141, 1)
                              color: Color.fromRGBO(182, 189, 200, 1)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            subCategoryid = value;
                            print('subCategoryid = $value');
                            // categoryid = value['id'];
                            // catChildren = value['children'];
                            // // print(value);
                            // print("categoryid = $categoryid");
                            // print('cat childern = $catChildren');
                            // getsubcategory(value["children"]);
                          });
                        },
                        items: aSSubCategorie,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: DropdownButtonFormField(
                        value: cat,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: new InputDecoration.collapsed(
                          // labelText: " Select Variants",
                          // labelStyle: TextStyle(
                          //   fontSize: 12,
                          // ),
                          hintText: "Select Variants",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              // color: Color.fromRGBO(195, 153, 141, 1)
                              color: Color.fromRGBO(182, 189, 200, 1)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            variantsid = value;
                            print('variantsid = $variantsid');
                            //    categoryid = value['id'];
                            //    catChildren = value['children'];
                            // // print(value);
                            //  print(categoryid);
                            //   //  buildDecs(value["children"]);
                            //   print('cat childern = $catChildren');
                          });
                        },
                        items: aSVariants,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                        right: 10,
                      ),
                      child: DropdownButtonFormField(
                        value: cat,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        decoration: new InputDecoration.collapsed(
                          // labelText: " Select Attributes",
                          // labelStyle: TextStyle(
                          //   fontSize: 12,
                          // ),
                          hintText: "Select Attributes",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              // color: Color.fromRGBO(195, 153, 141, 1)
                              color: Color.fromRGBO(182, 189, 200, 1)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            attributesid = value;
                            print('Attributesid = $attributesid');
                            //    categoryid = value['id'];
                            //    catChildren = value['children'];
                            // // print(value);
                            //  print(categoryid);
                            //   //  buildDecs(value["children"]);
                            //   print('cat childern = $catChildren');
                          });
                        },
                        items: aSAttributes,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: ListTile(
                        leading: Checkbox(
                          value: freeDelivery,
                          onChanged: (value) {
                            setState(() {
                              freeDelivery = value;
                            });
                          },
                        ),
                        title: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Free Delivery?',
                            style: TextStyle(
                                color: Color.fromRGBO(180, 186, 198, 1)),
                          ),
                        ])),
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
                                    child:
                                        Text('You have Selected $len Files')),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Select Files',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(182, 189, 200, 1),
                                          fontSize: 16),
                                    ),
                                    Icon(Icons.camera_alt_outlined,
                                        size: 30,
                                        color:
                                            Color.fromRGBO(182, 189, 200, 1)),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        for (var i = 0; i < _tagitems.length; i++) {
                          if (i == 0) {
                            asd = asd + _tagitems[i];
                          } else {
                            asd = asd + ',' + _tagitems[i];
                          }
                        }

                        if (_formKey.currentState.validate()) {
                          if (categoryid == null) {
                            final _snackBar = SnackBar(
                                content: Text('Category Id  is missing'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          } else if (subCategoryid == null) {
                            final _snackBar = SnackBar(
                                content: Text('Sub Categoryid Id  is missing'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          } else if (asd == null) {
                            final _snackBar =
                                SnackBar(content: Text('Tags is missing'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          } else if (attributesid == null) {
                            final _snackBar = SnackBar(
                                content: Text('Attribute  is missing'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          } else if (variantsid == null) {
                            final _snackBar =
                                SnackBar(content: Text('Variant  is missing'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          } else if (multifile.isEmpty) {
                            final _snackBar =
                                SnackBar(content: Text('Image  is missing'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                          } else {
                            addProducts(context);
                            showAlert(
                              context: context,
                              title:
                                  "You Product is Creating Wait for Some while",
                              actions: [
                                AlertAction(
                                    text: "Ok ",
                                    isDestructiveAction: true,
                                    onPressed: () {}),
                              ],
                              cancelable: true,
                            );
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 10),
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
                            'Save',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  getsubcategory(subcat) {
    // List<Widget> x = [];
    setState(() {
      aSSubCategorie = [];
    });
    for (final b in subcat) {
      setState(() {
        aSSubCategorie.add(DropdownMenuItem(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage('$picBaseURL${b['thumbnail']}'))),
              ),
              Text('${b['name']}'),
            ],
          ),
          value: b['id'],
        ));
      });
    }
  }

  getCategorys(context) async {
    setState(() {
      aSCategorie = [];
    });
    var url = 'https://einnovention.co.uk/wassl/public/api/vendor/categories';
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

  getVariantsindropdown(context) async {
    setState(() {
      aSVariants = [];
    });
    var url = 'https://einnovention.co.uk/wassl/public/api/vendor/varients';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('Variants: ${response.body}');
    List data = json.decode(response.body)['data'];
    if (data.length > 0) {
      data.forEach((element) {
        setState(() {
          print('element = $element');
          print('id  = ${element['id']}');
          aSVariants.add(DropdownMenuItem(
            child:
                //  Text('${element['name']}'),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   margin: EdgeInsets.all(5),
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //       color: Colors.black,
                //       image: DecorationImage(
                //           image: NetworkImage(
                //               '$picBaseURL${element['thumbnail']}'))),
                // ),
                Text('${element['title']}'),
                // Text('${element['price']}'),
              ],
            ),
            value: element['id'],
          ));
        });
      });
    }
  }

  getAttributeindropdown(context) async {
    setState(() {
      aSAttributes = [];
    });
    var url = 'https://einnovention.co.uk/wassl/public/api/vendor/attributes';
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $stringValue'});
    print('Variants: ${response.body}');
    List data = json.decode(response.body)['data'];
    if (data.length > 0) {
      data.forEach((element) {
        setState(() {
          print('element = $element');
          print('id  = ${element['id']}');
          aSAttributes.add(DropdownMenuItem(
            child:
                //  Text('${element['name']}'),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   margin: EdgeInsets.all(5),
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //       color: Colors.black,
                //       image: DecorationImage(
                //           image: NetworkImage(
                //               '$picBaseURL${element['thumbnail']}'))),
                // ),
                Text('${element['title']}'),
                // Text('${element['price']}'),
              ],
            ),
            value: element['id'],
          ));
        });
      });
    }
  }

  addProducts(context) async {
    List<MultipartFile> x = [];
    multifile.forEach((element) {
      MultipartFile.fromFile(element.path).then((value) {
        x.add(value);
      });
    });

    Timer(Duration(seconds: 1), () async {
      try {
        var formData = FormData.fromMap({
          "title": "$title",
          "price": "$price",
          "sale_price": "$saleprice",
          "description": "$description",
          "category_id": "$categoryid",
          "subcategory_id": "$subCategoryid",
          "tags": "$asd",
          "attribute_product": "$attributesid",
          "variation_product": "$variantsid",
          "image": x,
          "free_delivery": freeDelivery ? "1" : "0"
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $stringValue';
        // dio.options.headers["Authorization"] = "$accessToken";
        print({
          "title": "$title",
          "price": "$price",
          "sale_price": "$saleprice",
          "description": "$description",
          // "status": "$statusvalue",
          "category_id": "$categoryid",
          "subcategory_id": "$subCategoryid",
          "tags": "$asd",
          "attribute_product": "$attributesid",
          "variation_product": "$variantsid",
          "image": x,
          "free_delivery": freeDelivery ? "1" : "0"
        });
        var response = await dio.post(
            // https://einnovention.co.uk/wassl/public/api/vendor/products
            "https://einnovention.co.uk/wassl/public/api/vendor/products",
            data: formData);
        Clipboard.setData(ClipboardData(text: "$response"));
        print("Become Vender: $response");

        var gg = response.data;
        print('${response.data['message']}');
        if (gg['message'] == 'Record Successfully created!') {
          print('Data Stored Successfully');
          showAlert(
            context: context,
            title: "Product Stored Successfully",
            actions: [
              AlertAction(
                  text: "Ok ",
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AllProduct(),
                      ),
                    );
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
          print("qwe: ${e.message}");
        }
      }
    });
  }
}
