import 'package:flutter/material.dart';
import 'credit_cards.dart';
import 'recahrge_wallet.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key key}) : super(key: key);

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height / 1.1,
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height -70,
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
                    margin: EdgeInsets.all(20),
                    child: Image(image: AssetImage('asset/Group 213.png')),
                  ),
                  Text(
                    'Don’t have any card',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'It looks like you do not have a credit or debit card yet. Please add your cards easily',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
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
                            child: CreditCards(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 100),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255,199,0,100),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Center(
                        child: Text('Add Cards'),
                      ),
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
                            child: RechargeWallet(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255,199,0,100),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Center(
                        child: Text('Recharge Wallet'),
                      ),
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
