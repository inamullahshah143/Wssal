import 'package:flutter/material.dart';
import 'package:wassal_customer/design_pages/order/Ongoing%20Order.dart';
import 'package:wassal_customer/design_pages/order/history_list.dart';
 

class History extends StatefulWidget {
 
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          new PageRouteBuilder(
                            opaque: true,
                            transitionDuration:
                                const Duration(milliseconds: 100),
                            pageBuilder: (BuildContext context, _, __) {
                              return Ongoing();
                            },
                            transitionsBuilder: (_, Animation<double> animation,
                                __, Widget child) {
                              return new SlideTransition(
                                child: child,
                                position: new Tween<Offset>(
                                  begin: Offset(1, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: Text(
                          'Ongoing',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.red),
                        ),
                      ),
                      child: Text(
                        'History',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/1.3,
                child: ListView.builder(
                  itemCount: history == null ? 0 : history.length,
                  itemBuilder: (_, i) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${history[i]["food"]}'),
                              SizedBox(width: 10),
                              Text(
                                '${history[i]["status"]}',
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              Text(
                                '${history[i]["date"]}',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Image(
                                width: 50,
                                height: 50,
                                image: AssetImage('${history[i]["img"]}'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${history[i]["brand"]}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Padding(
                                      padding: const EdgeInsets.only(left:12.0),
                                        child: Icon(
                                          Icons.verified_user_rounded,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:12.0),
                                    child: Text('${history[i]["address"]}'),
                                  ),
                                  Padding(
                              padding: const EdgeInsets.only(top:12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "\$ ${history[i]["price"]}",
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.red),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "${history[i]["items"]} Items",
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 15,
                                      ),
                                      Text('Rated'),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text('Reorder'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.explore_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.receipt_rounded,
                      color: Colors.red,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_offer_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_rounded,
                      color: Colors.grey,
                    ),
                    label: ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
