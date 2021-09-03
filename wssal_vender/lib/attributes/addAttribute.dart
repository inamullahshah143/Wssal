import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import '../functions.dart';
import 'displayAttributes.dart';

class AddAttribute extends StatefulWidget {
  // const AddAttribute({ Key? key }) : super(key: key);

  @override
  _AddAttributeState createState() => _AddAttributeState();
}

class _AddAttributeState extends State<AddAttribute> {
  TextEditingController priceController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  List variation = [];
  Widget auVariation = Container();
  final _formKey = GlobalKey<FormState>();
  String title;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    setState(() {
      auVariation = addVariations(null, null, null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
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
                "Add Attributes",
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
          controller: _scrollController,
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
                        hintText: "Attribute Title",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(195, 153, 141, 1)),
                        // labelText: '     Product Title'
                      ),
                    )),
                auVariation,
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
                        'Add Attribute',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
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
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color.fromRGBO(240, 173, 78, 1),
                    child: Text('Edit'),
                    onPressed: () {
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                      setState(() {
                        auVariation = addVariations('${variation[i]['value']}',
                            '${variation[i]['price']}', i);
                      });
                    },
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Color.fromRGBO(215, 89, 70, 1),
                    textColor: Colors.white,
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
    setState(() {
      if (varValue != null) {
        valueController = TextEditingController(text: varValue);
      }
      if (varPrice != null) {
        priceController = TextEditingController(text: varPrice);
      }
    });
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
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
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
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
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                if (listIndex != null) {
                  setState(() {
                    variation.removeAt(listIndex);

                    variation.insert(listIndex, {
                      "value": "$varValue",
                      "price": "$varPrice",
                    });
                  });
                } else {
                  setState(() {
                    variation.add({
                      "value": "$varValue",
                      "price": "$varPrice",
                    });
                  });
                }

                setState(() {
                  priceController.clear();
                  valueController.clear();
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('All Fields Required')));
              }
              setState(() {
                auVariation = addVariations(null, null, null);
              });
            },
            child: Text(listIndex == null ? "Add" : 'Edit'),
            textColor: Colors.black,
            color: Colors.white,
          )
        ],
      ),
    ));
  }

  addattribute() async {
    try {
      var url = 'https://wassldev.einnovention.tech/api/vendor/attributes';
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DisplayAttributes(),
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
