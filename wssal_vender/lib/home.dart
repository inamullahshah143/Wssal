import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:wssal_vender/functions.dart';
import 'package:wssal_vender/variants/displayVariants.dart';
import 'attributes/displayAttributes.dart';

class BarChartModel {
  String month;
  String year;
  int financial;
  final charts.Color color;

  BarChartModel({
    this.month,
    this.year,
    this.financial,
    this.color,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<BarChartModel> data = [
    BarChartModel(
      year: "Sun",
      financial: 250,
      color: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
    ),
    BarChartModel(
      year: "Mon",
      financial: 300,
      color: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    BarChartModel(
      year: "Tue",
      financial: 100,
      color: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    BarChartModel(
      year: "Wed",
      financial: 450,
      color: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    BarChartModel(
      year: "Thu",
      financial: 630,
      color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
    ),
    BarChartModel(
      year: "Fri",
      financial: 1000,
      color: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
    BarChartModel(
      year: "Sat",
      financial: 400,
      color: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // title: Text("Flutter Animated Bar Chart Demo"),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/Logo_wssal.png'),
                      fit: BoxFit.contain)),
            ),
            // ListTile(
            //   title: Text('NewFile'),
            //   onTap: () {

            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => StoreProfile(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: Text('NewFile'),
            //   onTap: () {

            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => TestFile(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: Text('Variants'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DisplayVariants(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Attributes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DisplayAttributes(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: getbottomBar(0, context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 15, left: 15, top: 25, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'This Month',
                          style: TextStyle(),
                        ),
                        Text(
                          'All Report',
                          style: TextStyle(color: Colors.blue[200]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 120,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(244, 245, 247, 1),
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // height: 120,
                            width: 160,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.auto_graph_outlined,
                                          size: 15, color: Colors.blue[200])),
                                  WidgetSpan(
                                      child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Gross Sale',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue[200]),
                                    ),
                                  )),
                                  WidgetSpan(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 5, top: 15),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                  )),
                                  WidgetSpan(
                                      child: Text(
                                    '+10%',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  )),
                                ])),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '98666.00 LE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.blue[200]),
                                  ),
                                )
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(244, 245, 247, 1),
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // height: 100,
                            width: 160,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.image,
                                          size: 15, color: Colors.green)),
                                  WidgetSpan(
                                      child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Total Earning',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    ),
                                  )),
                                  WidgetSpan(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 5, top: 15),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                      size: 15,
                                    ),
                                  )),
                                  WidgetSpan(
                                      child: Text(
                                    '+10%',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  )),
                                ])),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '98666.00 LE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.green),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 120,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(244, 245, 247, 1),
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 100,
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.all_inbox_rounded)),
                                  WidgetSpan(child: Text('Sold Items')),
                                ])),
                                Text(
                                  '2232',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )),
                        Container(
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(244, 245, 247, 1),
                              color: Color.fromRGBO(244, 245, 247, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 100,
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(Icons.all_inbox_rounded)),
                                  WidgetSpan(child: Text('Order Received')),
                                ])),
                                Text(
                                  '2232',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                // color: Color.fromRGBO(244, 245, 247, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 100,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 70,
                    width: 160,
                    child: Container(
                        height: 70,
                        width: 160,
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(Icons.download),
                            ),
                            WidgetSpan(
                              child: Column(
                                children: [
                                  Text('New'),
                                  Text('Order'),
                                ],
                              ),
                            ),
                            WidgetSpan(
                                child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                '03',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            )),
                            WidgetSpan(
                                child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Icon(Icons.arrow_right_outlined)))
                          ]),
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(244, 245, 247, 1),
                      color: Color.fromRGBO(244, 245, 247, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 70,
                    width: 160,
                    child: Container(
                        height: 70,
                        width: 160,
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(Icons.timer),
                            ),
                            WidgetSpan(
                              child: Column(
                                children: [
                                  Text('Pending'),
                                  Text('Order'),
                                ],
                              ),
                            ),
                            WidgetSpan(
                                child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                '02',
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            )),
                            WidgetSpan(
                                child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Icon(Icons.arrow_right_outlined)))
                          ]),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, left: 15, top: 25, bottom: 25),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(13)),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 6, top: 6, right: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sales by Week'),
                        RichText(
                            text: TextSpan(text: '', children: [
                          WidgetSpan(
                              child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromRGBO(76, 154, 255, 1),
                              ),
                              Text('Gross Sale'),
                            ],
                          )),
                          WidgetSpan(
                              child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromRGBO(87, 217, 163, 1),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Total Earning')),
                            ],
                          )),
                        ]))
                      ],
                    ),
                  ),
                  BarChartGraph(
                    data: data,
                  ),
                  // ListView(
                  //   // scrollDirection: Axis.vertical,

                  //   shrinkWrap: true,
                  //   children: [
                  //     BarChartGraph(
                  //       data: data,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // requestVender() async {
  //   var url = 'https://wassl.einnovention.tech/api/vendor/requests';
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {'Authorization': 'Bearer $stringValue'},
  //   );
  //   print('buildProductsResponse: ${response.body}');
  //   var data = json.decode(response.body);

  //   if (data['data'][0]['status'] == 0) {
  //     print('Ahmad');
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => AddProduct(),
  //       ),
  //     );
  //   } else if (data['data'][0]['status'] == 1) {
  //     print('Ahmad');
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => ApproveRequest(),
  //       ),
  //     );
  //   } else if (data['data'][0]['status'] == 2) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => RequestRejected(),
  //       ),
  //     );
  //   } else {
  //     CircularProgressIndicator();
  //   }
  // }
}

class BarChartGraph extends StatefulWidget {
  final List<BarChartModel> data;

  const BarChartGraph({Key key, this.data}) : super(key: key);

  @override
  _BarChartGraphState createState() => _BarChartGraphState();
}

class _BarChartGraphState extends State<BarChartGraph> {
  List<BarChartModel> _barChartList;

  @override
  void initState() {
    super.initState();
    _barChartList = [
      BarChartModel(month: "Oct"),
      // BarChartModel(month: "Nov"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
          id: "Financial",
          data: widget.data,
          domainFn: (BarChartModel series, _) => series.year,
          measureFn: (BarChartModel series, _) => series.financial,
          colorFn: (BarChartModel series, _) => series.color),
    ];

    return _buildFinancialList(series);
  }

  Widget _buildFinancialList(series) {
    return _barChartList != null
        ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              height: 5,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _barChartList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height / 2.3,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_barChartList[index].month,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(child: charts.BarChart(series, animate: true)),
                  ],
                ),
              );
            },
          )
        : SizedBox();
  }
}
