import 'package:flutter/material.dart';

class RechargeWallet extends StatefulWidget {
  const RechargeWallet({Key key}) : super(key: key);

  @override
  _RechargeWalletState createState() => _RechargeWalletState();
}

class _RechargeWalletState extends State<RechargeWallet> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 1.1,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Payment Methods',
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage('asset/Contant.png'),
                    ),
                  ),
                  Text(
                    'Recharge Wallet',
                    style: TextStyle(
                        height: 1.5, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Recharge your wallet balance or transfer and recharge any amount to family or friends easily',
                    style: TextStyle(
                        height: 1.5, fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.red,
                            indicatorColor: Colors.red,
                            indicatorPadding:
                                EdgeInsets.only(right: 30, left: 30),
                            tabs: [
                              Tab(text: "My Wallet"),
                              Tab(text: "Send Balance"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                          height: 350,
                          child: TabBarView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'To my Wallet balance',
                                      style:
                                          TextStyle(height: 1.5, fontSize: 10),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.only(bottom: 5, top: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "E.g. 500 L.E",
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Table(
                                            border: TableBorder(
                                                horizontalInside: BorderSide(
                                                    width: 1,
                                                    color:
                                                        Colors.grey.shade400)),
                                            // defaultVerticalAlignment:
                                            // TableCellVerticalAlignment
                                            //     .middle,
                                            children: <TableRow>[
                                              TableRow(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.all(5),
                                                    // height: 25,
                                                    // width: 100,
                                                    child: Text(
                                                      'Current Balance',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    margin: EdgeInsets.all(5),
                                                    // height: 25,
                                                    // width: 80,
                                                    child: Text(
                                                      '1350.00 L.E',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        // border: Border(
                                                        //   top: BorderSide(
                                                        //       color: Colors.grey),
                                                        //   bottom: BorderSide(
                                                        //       color: Colors.grey),
                                                        // ),
                                                        ),
                                                    // height: 35,
                                                    // width: 100,
                                                    child: Text(
                                                      'Recharge Balance',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        // border: Border(
                                                        //   // top: BorderSide(
                                                        //   //     color: Colors.grey),
                                                        //   // bottom: BorderSide(
                                                        //   //     color: Colors.grey),
                                                        // ),
                                                        ),
                                                    // height: 35,
                                                    // width: 80,
                                                    child: Text(
                                                      '370.00 L.E',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    // height: 25,
                                                    // width: 100,
                                                    child: Text(
                                                      'Total',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.all(5),
                                                    // height: 25,
                                                    // width: 80,
                                                    child: Text(
                                                      '1720.00 L.E',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 60,
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 199, 0, 100),
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Center(
                                        child: Text('Recharge Now'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount',
                                      style:
                                          TextStyle(height: 1.5, fontSize: 10),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.only(bottom: 20, top: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "E.g. 500 L.E",
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'To Phone Number ',
                                          style: TextStyle(
                                              height: 1.5, fontSize: 10),
                                        ),
                                        Text(
                                          '*(Must be a member to receive your amount)',
                                          style: TextStyle(
                                              height: 1.5,
                                              fontSize: 10,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "0123456789",
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'The receiver will receive a SMS immediately after transaction completed successfully.',
                                      style: TextStyle(
                                          height: 1.5,
                                          fontSize: 10,
                                          color: Colors.grey),
                                    ),
                                    GestureDetector(
                                      onTap: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                          ),
                                          // contentPadding: EdgeInsets.all(0),
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                top: -45,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 3),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  width: 50,
                                                  height: 50,
                                                  child: Icon(
                                                      Icons.check_rounded,
                                                      color: Colors.white,
                                                      size: 40),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Your payment success',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      'Your new balance has added to your wallet',
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          actions: <Widget>[
                                            Center(
                                              child: TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: Container(
                                        height: 60,
                                        margin: EdgeInsets.only(top: 7),
                                        padding: EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 199, 0, 100),
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: Center(
                                          child: Text('Recharge Now'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
