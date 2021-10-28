import 'package:flutter/material.dart';

import 'add_cards.dart';

class CreditCards extends StatefulWidget {
  const CreditCards({Key key}) : super(key: key);

  @override
  _CreditCardsState createState() => _CreditCardsState();
}

class _CreditCardsState extends State<CreditCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 1.1,
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height - 150,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credit Cards',
                    style: TextStyle(
                        height: 1.5, color: Colors.grey, fontSize: 14),
                  ),
                  Container(
                    // margin: EdgeInsets.only(bottom: 20),
                    child: Divider(),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10, bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image(image: AssetImage('asset/visa.png'))],
                      ),
                      title: Text('Ahmad Khalid'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      subtitle: Text('Ends with 7009'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('asset/payment.png'))
                        ],
                      ),
                      title: Text('Ahmad Khalid'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      subtitle: Text('Ends with 1433'),
                    ),
                  ),
                  Text(
                    'Wallet Balance',
                    style: TextStyle(
                        height: 1.5, color: Colors.grey, fontSize: 14),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 20),
                    child: Divider(),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10, bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('asset/wallet.png'))
                        ],
                      ),
                      title: Text('1350.00 LE'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      subtitle: Text('Credit'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: AddCards(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 60),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 199, 0, 100),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Center(
                        child: Text('Add Cards'),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
