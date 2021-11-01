import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wassal_customer/const.dart';
import 'package:http/http.dart' as http;
import 'package:wassal_customer/productDetails.dart';

import 'Storedetail.dart';

class SpecialOffers extends StatefulWidget {
  final Map categoryBlock;
  const SpecialOffers({
    Key key,
    @required this.categoryBlock,
  }) : super(key: key);

  @override
  _SpecialOffersState createState() =>
      _SpecialOffersState(categoryBlock: categoryBlock);
}

class _SpecialOffersState extends State<SpecialOffers> {
  final Map categoryBlock;
  _SpecialOffersState({
    @required this.categoryBlock,
  });
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(true, context, "Special Offers", true, true),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: FutureBuilder(
          future: specialOffers(),
          builder: ((context, snap) {
            if (snap.hasData) {
              return snap.data;
            } else if (snap.hasError) {
              return Text('${snap.error}');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<Widget> specialOffers() async {
    var response =
        await http.get(Uri.parse("$apiURL/offer/${categoryBlock['id']}"));
    List<Widget> x = [];
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      data.forEach((element) {
        x.add(
          InkWell(
            onTap: () async {
              if (element['offer_on'] == 'shop') {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return StoreDetail(storeBlock: element['shop']);
                  },
                );
              } else {
                await http
                    .get((Uri.parse(
                        "$apiURL/productDetail/${element['product_id']}")))
                    .then((value) {
                  if (value.statusCode == 200) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ProductDetails(
                            d: json.decode(value.body)['data']);
                      },
                    );
                  }
                });
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageURL + '/${element['bgimage']}'),
                  ),
                ),
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(25, 25, 25, 0),
                        Color.fromRGBO(25, 25, 25, 1),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${element['title']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: themePrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${element['subtitle']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              margin: EdgeInsets.all(5),
            ),
          ),
        );
      });
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: x,
      ),
    );
  }
}
