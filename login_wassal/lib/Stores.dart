import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Storedetail.dart';
import 'const.dart';

class AllShops extends StatefulWidget {
  @override
  _AllShopsState createState() => _AllShopsState();
}

class _AllShopsState extends State<AllShops> {
  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(false, context, "Shops", true, true),
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
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: allShops(context),
            builder: ((context, snap) {
              if (snap.hasData) {
                return snap.data;
              } else if (snap.hasError) {
                return Text("No Record Found");
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.yellow,
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

Future<Widget> allShops(BuildContext context) async {
  var response = await http.get(Uri.parse("$apiURL/allShops"));
  if (json.decode(response.body)['status'] == 200) {
    List data = json.decode(response.body)['data'];
    List<Widget> x = [];
    data.forEach((element) {
      x.add(
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return StoreDetail(storeBlock: element);
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(imageURL + '/${element['logo']}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${element['title']}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.verified,
                                color: Colors.green,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Promoted',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: element['open_close'] == 1
                                      ? 'Open'
                                      : 'Close',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: element['open_close'] == 1
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: "Burger",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.circle,
                                      size: 5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: "Sandwitch",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(text: " "),
                                      TextSpan(
                                        text: "4.8",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Colors.grey[500],
                                    size: 16.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text('25-35 Min'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: Colors.grey[500],
                                    size: 16.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text('3.5 L.E'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
    return Column(
      children: x,
    );
  } else {
    return Text("No Shops Available");
  }
}
