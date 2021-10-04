import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'functions.dart';

class TestFile extends StatefulWidget {
  @override
  _TestFileState createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> {
  TextEditingController priceController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  List variation = [];
  final _formKey = GlobalKey<FormState>();
  String title;
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Field'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red,
      //   onPressed: () {
      //     // addVariations(null, null, null);
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: SingleChildScrollView(
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
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // icon: Icon(
                    //   Icons.calendar_today_outlined,
                    //   color: Color.fromRGBO(193, 199, 208, 1),
                    // ),
                    labelText: '     Product Title'),
              )),
          addVariations(null, null, null),
          showVariations(),
          ElevatedButton(
            child: Text('Add Variants'),
            onPressed: () {
              print("variation = $variation");

              addattribute();
            },
          )
        ],
      )),
    );
  }

  Widget showVariations() {
    List<Widget> x = [];
    for (var i = 0; i < variation.length; i++) {
      x.add(Container(
        margin: EdgeInsets.all(20),
        child: Table(
          children: [
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  'Value',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text('${variation[i]['value']}'))
            ]),
            TableRow(children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: Text('${variation[i]['price']}'))
            ]),
            TableRow(children: [
              Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      addVariations('${variation[i]['value']}',
                          '${variation[i]['price']}', i);
                    },
                  )),
              Container(
                  margin: EdgeInsets.all(5),
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

  // addVariations(String varValue, String varPrice, int listIndex) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Stack(
  //             overflow: Overflow.visible,
  //             children: <Widget>[
  //               Positioned(
  //                 right: -40.0,
  //                 top: -40.0,
  //                 child: InkResponse(
  //                   onTap: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: CircleAvatar(
  //                     child: Icon(Icons.close),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 ),
  //               ),
  //               SingleChildScrollView(
  //                   child: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.only(top: 10, bottom: 10),
  //                       height: 50,
  //                       width: 500,
  //                       child: TextFormField(
  //                           initialValue: varValue,
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return "This field is required";
  //                             } else {
  //                               return null;
  //                             }
  //                           },
  //                           // readOnly: true,
  //                           onChanged: (value) {
  //                             varValue = value;
  //                           },
  //                           obscureText: false,
  //                           decoration: InputDecoration(
  //                             hintText: "Value",
  //                             hintStyle: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: Color.fromRGBO(195, 153, 141, 1)),
  //                             enabledBorder: const OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                   color: Color.fromRGBO(89, 2, 0, 1),
  //                                   width: 2),
  //                             ),
  //                             focusedBorder: const OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                   color: Color.fromRGBO(89, 2, 0, 1),
  //                                   width: 2),
  //                             ),
  //                           )),
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.only(top: 10, bottom: 10),
  //                       height: 50,
  //                       width: 500,
  //                       child: TextFormField(
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return "This field is required";
  //                             } else {
  //                               return null;
  //                             }
  //                           },
  //                           onChanged: (value) {
  //                             varPrice = value;
  //                           },
  //                           initialValue: varPrice,
  //                           obscureText: false,
  //                           decoration: InputDecoration(
  //                             hintText: "Price",
  //                             hintStyle: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: Color.fromRGBO(195, 153, 141, 1)),
  //                             enabledBorder: const OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                   color: Color.fromRGBO(89, 2, 0, 1),
  //                                   width: 2),
  //                             ),
  //                             focusedBorder: const OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                   color: Color.fromRGBO(89, 2, 0, 1),
  //                                   width: 2),
  //                             ),
  //                           )),
  //                     ),
  //                     RaisedButton(
  //                       onPressed: () {
  //                         if (_formKey.currentState.validate()) {
  //                           if (listIndex != null) {
  //                             setState(() {
  //                               variation.removeAt(listIndex);
  //                             });
  //                           }
  //                           setState(() {
  //                             variation.add({
  //                               "value": "$varValue",
  //                               "price": "$varPrice",
  //                             });
  //                           });
  //                           Navigator.pop(context);
  //                         } else {
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                               SnackBar(content: Text('All Fields Required')));
  //                         }
  //                       },

  //                       child: Text("Done"),
  //                       textColor: Colors.black,
  //                       color: Colors.white,
  //                     )
  //                   ],
  //                 ),
  //               )),
  //             ],
  //           ),
  //         );
  //       });
  // }
  addVariations(String varValue, String varPrice, int listIndex) {
    return Stack(
      children: <Widget>[
        Positioned(
          right: -40.0,
          top: -40.0,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              child: Icon(Icons.close),
              backgroundColor: Colors.red,
            ),
          ),
        ),
        SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
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
                margin: EdgeInsets.only(top: 10, bottom: 10),
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
                        //     variation.insert(listIndex, {
                        //   "value": "$varValue",
                        //   "price": "$varPrice",
                        // });

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
                    // Navigator.pop(context);
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
      var url = 'https://wassl.einnovention.tech/api/vendor/attributes';
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

      if (data['message'] == 'Successfully Attribute store!') {
        showAlert(
          context: context,
          title: "Attribute Successfully Created",
          actions: [
            AlertAction(
                text: "Ok ",
                isDestructiveAction: true,
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => DisplayAttributes(),
                  //   ),
                  // );
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
