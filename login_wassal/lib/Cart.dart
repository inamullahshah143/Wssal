import 'dart:async';
import 'dart:convert';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'const.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Timer timer;
  int cartFinalPrice = 0;
  @override
  void initState() {
    finalPriceForCart = 0;
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      // print("cartFinalPrice: $productPriceValue");
      setState(() {
        cartFinalPrice = finalPriceForCart;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    //
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () {
            showAlert(context: context, title: "Payment Method", actions: [
              AlertAction(
                  text: "Cash on delivery",
                  onPressed: () {
                    cartCheckout(context, "cash_on_delivery");
                  }),
              AlertAction(
                  text: "Pay from wallet",
                  onPressed: () {
                    cartCheckout(context, "direct_wallet_payment");
                  }),
            ]);
            print("HelloFinalCartValue: ${json.encode(cartFinalPrice)}");
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 199, 0, 100),
                  borderRadius: BorderRadius.circular(15)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Checkout (\$ ${cartFinalPrice})",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
        ),
      ),
      backgroundColor: Color.fromRGBO(244, 245, 247, 1),
      appBar: getAppbar(context, 'Cart'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Container(
                height: 550,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCartProducts(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }

  cartCheckout(context, method) async {
    var url = "$apiURL/user/punchOrder";
    var response = await http.post(Uri.parse(url), body: {
      "grand_total": "$cartFinalPrice",
      "payment_method": "$method",
      "productData": json.encode(finalProductsForCart),
      "billing_name": "Obaid",
      "billing_company": "Einnovention",
      "billing_address": "Barkat Market Central Plaza",
      "billing_city": "Lahore",
      "billing_country": "Pakistan",
      "billing_postal_code": "54000",
      "billing_phone": "+923074174328",
    }, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $loginToken',
    });
    print("cartCheckout: ${response.body}");
    Map data = json.decode(response.body);
    if (data['message'] == "Order successfully punched") {
      showAlert(
          context: context,
          title: "Success",
          body: "Order No ${data['order no']} successfully created");
    } else {
      showAlert(
          context: context, title: "Error", body: "Not Enough Funds in wallet");
    }
  }

  Widget _buildCartProducts() {
    if (finalProductsForCart.isNotEmpty) {
      List<Widget> x = [];
      finalProductsForCart.forEach((cartProduct) {
        x.add(CartProduct(cartProductBlock: cartProduct));
      });
      return Column(
        children: x,
      );
    } else {
      return Text("Cart Is Empty");
    }
  }
}

class CartProduct extends StatefulWidget {
  final Map cartProductBlock;
  CartProduct({@required this.cartProductBlock});
  @override
  _CartProductState createState() =>
      _CartProductState(cartProductBlock: cartProductBlock);
}

class _CartProductState extends State<CartProduct> {
  final Map cartProductBlock;
  _CartProductState({@required this.cartProductBlock});

  int cartProductBlockPrice;
  int cartProductBlockQty;
  @override
  void initState() {
    setState(() {
      cartProductBlockQty = cartProductBlock['quantity'];
      cartProductBlockPrice = cartProductBlock['product_price'];
      // finalPriceForCart = cartProductBlock['product_price'];
      cartProductBlockPrice =
          cartProductBlock['product_price'] * cartProductBlockQty;
      finalPriceForCart = finalPriceForCart + cartProductBlockPrice;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latestContext = context;
    return ListTile(
      leading: Image(
        image: NetworkImage("${cartProductBlock['product_image']}"),
      ),
      title: Text("${cartProductBlock['product_name']}"),
      subtitle: buildExtras(cartProductBlock['extras']),
      trailing: Column(
        children: [
          Text("\$ $cartProductBlockPrice"),
          RichText(
              text: TextSpan(text: "", children: [
            WidgetSpan(
              child: Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                child: GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      cartProductBlockQty++;
                      cartProductBlockPrice =
                          cartProductBlock['product_price'] *
                              cartProductBlockQty;
                      finalPriceForCart =
                          finalPriceForCart + cartProductBlock['product_price'];
                    });
                  },
                ),
              ),
            ),
            WidgetSpan(
              child: Container(
                  margin: EdgeInsets.only(left: 3, right: 3),
                  child: Text("$cartProductBlockQty")),
            ),
            WidgetSpan(
              child: Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                child: GestureDetector(
                  child: Icon(Icons.remove),
                  onTap: () {
                    if (cartProductBlockQty > 1) {
                      setState(() {
                        cartProductBlockQty--;
                        cartProductBlockPrice =
                            cartProductBlock['product_price'] *
                                cartProductBlockQty;
                        finalPriceForCart = finalPriceForCart -
                            cartProductBlock['product_price'];
                      });
                    }
                  },
                ),
              ),
            ),
          ]))
        ],
      ),
    );
  }
}

Widget buildExtras(List extras) {
  List<Widget> x = [];
  extras.forEach((extra) {
    x.add(RichText(
        text: TextSpan(text: "", children: [
      WidgetSpan(
        child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Text("${extra['title']}")),
      ),
      WidgetSpan(
        child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("\$${extra['price']}")),
      ),
    ])));
  });
  return Column(
    children: x,
  );
}
