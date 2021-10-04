import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:http/http.dart' as http;
import '../functions.dart';
import 'allProduct.dart';

class UpdateProduct extends StatefulWidget {
  // const UpdateProduct({ Key? key }) : super(key: key);
  final productdata;
  UpdateProduct(this.productdata);
  @override
  _UpdateProductState createState() => _UpdateProductState(productdata);
}

class _UpdateProductState extends State<UpdateProduct> {
  final productdata;
  _UpdateProductState(this.productdata);
  final _formKey = GlobalKey<FormState>();
  List<File> multifile = [];
  List _tagitems = [];
  List<String> tagList = [];
  String asd = '';
  var len;
  var title;
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
  bool status = false;
  int statusvalue;
  int pID;
  List<DropdownMenuItem<dynamic>> aSCategorie = [];
  List<DropdownMenuItem<dynamic>> aSSubCategorie = [];
  List<DropdownMenuItem<dynamic>> aSVariants = [];
  List<DropdownMenuItem<dynamic>> aSAttributes = [];
  initState() {
    pID = productdata['id'];
    print('pID = $pID');
    title = productdata['title'];
    price = productdata['price'];
    saleprice = productdata['sale_price'];
    description = productdata['asljdfh'];
    categoryid = productdata['category_id'];
    subCategoryid = productdata['subcategory_id'];
    // print('attributes = ${productdata['attributes'][0]['id']}');
    // print('variations = ${productdata['variations'][0]['id']}');
    // variantsid = productdata['variations'][0]['id'];
    // attributesid = productdata['attributes'][0]['id'];
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
            "Update Product",
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
                // Container(
                //       margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                //       padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text('Active / Deactive'),
                //           FlutterSwitch(
                //             width: 50.0,
                //             height: 25.0,
                //             valueFontSize: 15.0,
                //             toggleSize: 15.0,
                //             value: status,
                //             borderRadius: 30.0,
                //             activeColor: Colors.red,
                //             // inactiveColor: ,
                //             // padding: 8.0,
                //             showOnOff: true,
                //             onToggle: (val) {
                //               setState(() {
                //                 status = val;
                //                 setState(() {
                //                 status = val;
                //                 if (status == true) {
                //                 // var feture;
                //                 // var status;
                //                 statusvalue = 1;
                //                 print('statusvalue = $statusvalue');
                //               } else if (status == false) {
                //                 statusvalue = 0;
                //                 print('statusvalue = $statusvalue');
                //               }
                //               });
                //               });
                //             },
                //           ),
                //         ],
                //       ),
                //     ),

                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          // margin: EdgeInsets.only(top: 25, left: 5, right: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 245, 247, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // margin: EdgeInsets.only(left: 30),
                          height: 50,
                          width: 150,
                          child: TextFormField(
                            // controller: seachController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                            initialValue: '$price',
                            onChanged: (value) {
                              price = value;
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
                              hintText: 'Regular Price',
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  // color: Color.fromRGBO(195, 153, 141, 1)
                                  color: Color.fromRGBO(182, 189, 200, 1)),
                            ),
                          )),
                      Container(
                          // margin: EdgeInsets.only(top: 25, left: 5, right: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 245, 247, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.only(left: 10),
                          height: 50,
                          width: 150,
                          child: TextFormField(
                            initialValue: '$saleprice',
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
                              hintText: 'Sale Price',
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  // color: Color.fromRGBO(195, 153, 141, 1)
                                  color: Color.fromRGBO(182, 189, 200, 1)),
                            ),
                          )),
                    ],
                  ),
                ),
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
                      // controller: titleController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                      initialValue: '$title',
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
                        // labelText: '     Product Title'
                        hintText: 'Product Title',
                        hintStyle: TextStyle(
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
                      // controller: descriptionController,
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
                        // labelText: '     Description'
                        hintText: 'Description',
                        hintStyle: TextStyle(
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
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: new BorderSide(
                                color: Colors.transparent, width: 3),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: new BorderSide(
                                color: Colors.transparent, width: 3),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
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
                      // labelText: " Select Category",
                      // labelStyle: TextStyle(
                      //   fontSize: 12,
                      // ),
                      hintText: 'Select Category',
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
                      // labelText: " Select Sub_Category",
                      // labelStyle: TextStyle(
                      //   fontSize: 12,
                      // ),
                      hintText: 'Select Sub_Category',
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
                      hintText: 'Select Variants',
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
                      hintText: 'Select Attributes',
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Select Files',
                                  style: TextStyle(
                                      color: Color.fromRGBO(182, 189, 200, 1),
                                      fontSize: 16),
                                ),
                                Icon(Icons.camera_alt_outlined,
                                    size: 30,
                                    color: Color.fromRGBO(182, 189, 200, 1)),
                              ],
                            ),
                          ),
                  ),
                ),
                // Text('$productdata'),
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
                      var tagi;
                      print('$_tagitems');
                      tagi = json.encode(_tagitems);
                      print('tagi = $tagi');
                      // _tagitems.forEach((element) {});
                      // var asd;

                      print('title = $title');
                      print('description = $description');
                      print('price = $price');
                      print('saleprice = $saleprice');
                      print('categoryid = $categoryid');
                      print('subCategoryid = $subCategoryid');
                      print('variantsid = $variantsid');
                      print('attributesid = $attributesid');
                      print('asd = $asd');
                      print('statusvalue = $statusvalue');

                      showAlert(
                        context: context,
                        title: "You product  is Updating Wait for Some while",
                        actions: [
                          AlertAction(
                              text: "Ok ",
                              isDestructiveAction: true,
                              onPressed: () {
                                // addProducts(context);
                                addProducts(context);
                              }),
                        ],
                        cancelable: true,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 10),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      color: Color.fromRGBO(255, 199, 0, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 50,
                    width: width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Update Product',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    var url = 'https://wassldev.einnovention.tech/api/vendor/categories';
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
    var url = 'https://wassldev.einnovention.tech/api/vendor/varients';
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
                Text('${element['price']}'),
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
    // https://wassldev.einnovention.tech/api/vendor/attributes
    var url = 'https://wassldev.einnovention.tech/api/vendor/attributes';
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
                Text('${element['price']}'),
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
          '_method': 'PUT',
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
        });

        Dio dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $stringValue';
        // dio.options.headers["Authorization"] = "$accessToken";
        print({
          "title": "$title",
          "price": "$price",
          "sale_price": "$saleprice",
          "description": "$description",
          "status": "$statusvalue",
          "category_id": "$categoryid",
          "subcategory_id": "$subCategoryid",
          "tags": "$asd",
          "attribute_product": "$attributesid",
          "variation_product": "$variantsid",
          "image": x,
        });
        var response = await dio.post(
            // https://wassl.einnovention.tech/api/vendor/products/1
            "https://wassldev.einnovention.tech/api/vendor/products/$pID",
            data: formData);
        print("Update product: $response");

        var gg = response.data;
        print('message $gg');
        print('${response.data['Message']}');
        if (gg['Message'] == 'Record Update successfully!') {
          print('Record Update successfully!');
          showAlert(
            context: context,
            title: "Record Update successfully!",
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
