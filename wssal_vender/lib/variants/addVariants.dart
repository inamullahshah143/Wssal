import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';

import '../functions.dart';
import 'displayVariants.dart';

class AddVariants extends StatefulWidget {
  // const AddVariants({ Key? key }) : super(key: key);

  @override
  _AddVariantsState createState() => _AddVariantsState();
}

class _AddVariantsState extends State<AddVariants> {
//   bool status = false;
//   var feture;
//   var tagi;
//   List _tagitems = [];
//   List<String> tagList = [];
//    var variantsName;
//     var variantsPrice;
//     String asd = '';
//   @override
//     Widget build(BuildContext context) {
//    latestContext = context;
//    TextEditingController variantsnameController = TextEditingController();
//     TextEditingController variantspriceController = TextEditingController();
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Add Variants'),
//       // ),
//       backgroundColor: Color.fromRGBO(244, 245, 247, 1),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0),
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Add Variants",
//                 style: TextStyle(color: Colors.black),
//               )),
//           actions: [
//             Image(
//               image: AssetImage('assets/app_logo.png'),
//             )
//           ],
//           automaticallyImplyLeading: true,
//           iconTheme: IconThemeData(color: Colors.black),
//           // centerTitle: true,
//         ),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           margin: EdgeInsets.only(top: 25, left: 15, right: 15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             children: [
//                  Container(
//                 margin: EdgeInsets.only(top: 25, left: 15, right: 15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'if Customer select multiple Attribute then select the Button',
//                         style: TextStyle(fontSize: 15, color: Colors.black45),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,

//                       child:
//                         FlutterSwitch(
//                           width: 50.0,
//                           height: 25.0,
//                           valueFontSize: 15.0,
//                           toggleSize: 15.0,
//                           value: status,
//                           borderRadius: 30.0,
//                           activeColor: Colors.red,
//                           // inactiveColor: ,
//                           // padding: 8.0,
//                           showOnOff: true,
//                           onToggle: (val) {
//                             setState(() {
//                               status = val;
//                               if (status == true) {
//                               // var feture;
//                               // var status;
//                               feture = 1;
//                               print('feture = $feture');
//                             } else if (status == false) {
//                               feture = 0;
//                               print('feture = $feture');
//                             }
//                             });
//                           },
//                         ),

//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   margin: EdgeInsets.only(top: 25, left: 15, right: 15),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(244, 245, 247, 1),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   height: 50,
//                   width: width,
//                   child: TextFormField(
//                     controller: variantsnameController,
//                     // validator: (value) {
//                     //   if (value.isEmpty) {
//                     //     return "This field is required";
//                     //   } else {
//                     //     return null;
//                     //   }
//                     // },
//                     onChanged: (value) {
//                       variantsName = value;
//                     },
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         hintText: '     Variant Title'),
//                   )),
//               Container(
//                   margin: EdgeInsets.only(top: 25, left: 15, right: 15),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(244, 245, 247, 1),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   height: 50,
//                   width: width,
//                   child: TextFormField(
//                     controller: variantspriceController,
//                     // validator: (value) {
//                     //   if (value.isEmpty) {
//                     //     return "This field is required";
//                     //   } else {
//                     //     return null;
//                     //   }
//                     // },
//                     onChanged: (value) {
//                       variantsPrice= value;
//                     },
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                         hintText: '     Variant Price'),
//                   )),

//               Container(
//                 width: 400,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Color.fromRGBO(244, 245, 247, 1),
//                 ),
//                 margin: EdgeInsets.only(top: 25, left: 15, right: 15),
//                 child: Container(
//                   margin: EdgeInsets.all(5),
//                   child: Tags(
//                     alignment: WrapAlignment.start,
//                     spacing: 2,
//                     textField: TagsTextField(
//                       textStyle: TextStyle(
//                           color: Color.fromRGBO(30, 92, 135, 1),
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold),
//                       autofocus: false,
//                       helperText: "",

//                       lowerCase: true,
//                       inputDecoration: InputDecoration(
//                         focusedBorder: new OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25)),
//                           borderSide: new BorderSide(
//                               color: Colors.transparent, width: 3),
//                         ),
//                         enabledBorder: new OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25)),
//                           borderSide: new BorderSide(
//                               color: Colors.transparent, width: 3),
//                         ),
//                         border: new OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(25)),
//                           borderSide: new BorderSide(
//                               color: Colors.transparent, width: 3),
//                         ),
//                         labelText: "Variant Values",
//                         labelStyle: TextStyle(
//                           // color: Color.fromRGBO(30, 92, 135, 1),
//                           color: Colors.black45,
//                           // fontSize: 16,
//                           // fontWeight: FontWeight.bold
//                         ),
//                       ),
//                       onSubmitted: (String str) {
//                         if (_tagitems.length < 20) {
//                           tagList.add(str);
//                           setState(() {
//                             // required
//                             _tagitems.add(str);
//                           });
//                         } else {
//                           print("Limit Reached");
//                         }
//                         print(tagList);
//                       },
//                     ),
//                     itemCount: _tagitems.length, // required
//                     itemBuilder: (int index) {
//                       final item = _tagitems[index];

//                       return ItemTags(
//                         key: Key(index.toString()),
//                         index: index, // required
//                         title: item,

//                         customData: item,
//                         textStyle: TextStyle(
//                           fontSize: 12,
//                         ),
//                         combine: ItemTagsCombine.withTextBefore,

//                         removeButton: ItemTagsRemoveButton(
//                           icon: Icons.remove,
//                           size: 7,
//                           onRemoved: () {
//                             setState(() {
//                               _tagitems.removeAt(index);
//                             });
//                             //required
//                             return true;
//                           },
//                         ), // OR null,
//                         onPressed: (item) => print(item),
//                         onLongPressed: (item) => print(item),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   // print('$_tagitems');
//                   // tagi= json.encode(_tagitems);
//                   // print('tagi = $tagi');
//                   // _tagitems.forEach((element) {});

//                   for (var i = 0; i < _tagitems.length; i++) {
//                     if (i==0) {
//                       asd = asd + _tagitems[i];
//                     }else{
//                       asd =  asd + ',' + _tagitems[i];
//                     }

//                   }
//                   print('asd = $asd');
//                   print('select attribute = $feture');
//                   print('variantsName = $variantsName');
//                   print('variantsPrice = $variantsPrice');
//                     showAlert(
//                     context: context,
//                     title: "You Variants is Creating Wait for Some while",
//                     actions: [
//                       AlertAction(
//                           text: "Ok ",
//                           isDestructiveAction: true,
//                           onPressed: () {
//                             // updateCategory(context);
//                         addvariantss();
//                           }),
//                     ],
//                     cancelable: true,
//                   );
//                 },
//                 child: Container(
//                   margin:
//                       EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
//                   decoration: BoxDecoration(
//                     // color: Color.fromRGBO(244, 245, 247, 1),
//                     color: Colors.yellow[300],
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   height: 50,
//                   width: width,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Save Variants',
//                       style: TextStyle(color: Colors.black45),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// addvariantss() async {
//     try {
//       var url =
//           'https://wassl.einnovention.tech/api/vendor/varients';
//       var response = await http.post(
//         Uri.parse(url),
//         body: {
//           "title": "$variantsName",
//           "value": "$asd",
//           'selectstatus': '$feture',
//           'price':'$variantsPrice'        },
//         headers: {'Authorization': 'Bearer $stringValue'},
//       );
//       print({
//         "title": "$variantsName",
//         "value": "$asd",
//         'selectstatus': '$feture',
//           'price':'$variantsPrice'
//       });
//       print('Response body: ${response.body}');
//       var data = json.decode(response.body);
//       print('$data');

//       if (data['message'] == 'Successfully Variation store!') {
//         showAlert(
//           context: context,
//           title: "Variants Successfully Created",
//           actions: [
//             AlertAction(
//                 text: "Ok ",
//                 isDestructiveAction: true,
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) => DisplayVariants(),
//                     ),
//                   );
//                 }),
//           ],
//           cancelable: true,
//         );
//       } else {
//         showAlert(
//           context: context,
//           title: "Variants not Created",
//           actions: [
//             AlertAction(
//                 text: "Ok ", isDestructiveAction: true, onPressed: () {}),
//           ],
//           cancelable: true,
//         );
//       }
//     } on Exception catch (e) {
//       showAlert(
//         context: context,
//         title: "$e",
//         actions: [
//           AlertAction(text: "Ok ", isDestructiveAction: true, onPressed: () {}),
//         ],
//         cancelable: true,
//       );
//     }
//   }

// }
  TextEditingController priceController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  List variation = [];
  final _formKey = GlobalKey<FormState>();
  String title;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      //  appBar: AppBar(
      // //   title: Text('Add Variants'),
      // // ),
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "Add Variants",
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red,
      //   onPressed: () {
      //     // addVariations(null, null, null);
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
        padding: EdgeInsets.all(5),
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
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // icon: Icon(
                    //   Icons.calendar_today_outlined,
                    //   color: Color.fromRGBO(193, 199, 208, 1),
                    // ),
                    hintText: "Variant Title",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(195, 153, 141, 1)),
                    // labelText: '     Product Title'
                  ),
                )),
            addVariations(null, null, null),
            showVariations(),
            InkWell(
              onTap: () {
                print("variation = $variation");

                showAlert(
                  context: context,
                  title: "Attribute is adding.......",
                  actions: [
                    AlertAction(
                        text: "Ok ",
                        isDestructiveAction: true,
                        onPressed: () {
                          addattribute();
                        }),
                  ],
                  cancelable: true,
                );
              },
              child: Container(
                margin: EdgeInsets.all(15),
                width: width,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(5)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Variant',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget showVariations() {
    List<Widget> x = [];
    for (var i = 0; i < variation.length; i++) {
      x.add(Container(
        margin: EdgeInsets.all(20),
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Value',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text('${variation[i]['value']}'))
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text('${variation[i]['price']}'))
            ]),
            TableRow(children: [
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      addVariations('${variation[i]['value']}',
                          '${variation[i]['price']}', i);
                    },
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text('Delete'),
                    onPressed: () {
                      setState(() {
                        variation.removeAt(i);
                      });
                    },
                  )),
            ])
          ],
        ),
      ));
    }
    return Column(
      children: x,
    );
  }

  addVariations(String varValue, String varPrice, int listIndex) {
    return Stack(
      children: <Widget>[
        // Positioned(
        //   right: -40.0,
        //   top: -40.0,
        //   child: InkResponse(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: CircleAvatar(
        //       child: Icon(Icons.close),
        //       backgroundColor: Colors.red,
        //     ),
        //   ),
        // ),
        SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                height: 50,
                width: 500,
                child: TextFormField(
                    initialValue: varValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    controller: valueController,
                    onChanged: (value) {
                      varValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Value",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(195, 153, 141, 1)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                    )),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                height: 50,
                width: 500,
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                    controller: priceController,
                    onChanged: (value) {
                      varPrice = value;
                    },
                    initialValue: varPrice,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Price",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(195, 153, 141, 1)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(89, 2, 0, 1), width: 2),
                      ),
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (listIndex != null) {
                      setState(() {
                        variation.removeAt(listIndex);

                        variation.add({
                          "value": "$varValue",
                          "price": "$varPrice",
                        });
                      });
                    }
                    setState(() {
                      variation.add({
                        "value": "$varValue",
                        "price": "$varPrice",
                      });
                    });
                    setState(() {
                      priceController.clear();
                      valueController.clear();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('All Fields Required')));
                  }
                },
                child: Text("Done"),
              )
            ],
          ),
        )),
      ],
    );
  }

  addattribute() async {
    try {
      var url = 'https://einnovention.co.uk/wassl/public/api/vendor/varients';
      var response = await http.post(
        Uri.parse(url),
        body: {
          "title": "$title",
          "data": jsonEncode(variation),
          // 'selectstatus': '$feture',
          // 'price':'$attributePrice'
        },
        headers: {'Authorization': 'Bearer $stringValue'},
      );
      print({
        "title": "$title",
        "data": jsonEncode(variation),
      });
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      print('$data');

      if (data['message'] == 'Successfully Variation store!') {
        showAlert(
          context: context,
          title: "Variation Successfully Created",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DisplayVariants(),
                    ),
                  );
                }),
          ],
          cancelable: true,
        );
      } else {
        showAlert(
          context: context,
          title: "Attribute not Created",
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
