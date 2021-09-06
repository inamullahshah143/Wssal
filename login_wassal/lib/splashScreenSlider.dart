import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';
import 'numberlogin.dart';

class SplashScreenSlider extends StatefulWidget {
  const SplashScreenSlider({Key key}) : super(key: key);

  @override
  _SplashScreenSliderState createState() => _SplashScreenSliderState();
}

class _SplashScreenSliderState extends State<SplashScreenSlider> {
  bool firstSlideIndecator = true;
  bool secondSlideIndecator = false;
  bool thirdSlideIndicator = false;
  @override
  void initState() {
    super.initState();

    firstSlideIndecator = true;
    secondSlideIndecator = false;
    thirdSlideIndicator = false;
    SharedPreferences.getInstance().then((value) {
      value.setBool("showSlider", true);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: pagesBackground,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: height / 1.4,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          if (index == 0) {
                            firstSlideIndecator = true;
                            secondSlideIndecator = false;
                            thirdSlideIndicator = false;
                          } else if (index == 1) {
                            firstSlideIndecator = false;
                            secondSlideIndecator = true;
                            thirdSlideIndicator = false;
                          } else {
                            firstSlideIndecator = false;
                            secondSlideIndecator = false;
                            thirdSlideIndicator = true;
                          }
                        },
                      );
                    },
                  ),
                  items: [
                    Column(
                      children: [
                        SizedBox(
                          height: height / 12,
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height) / 2.1,
                          width: width,
                          decoration: BoxDecoration(),
                          child: Image.asset("assets/Illustration1.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 57),
                          child: Column(
                            children: [
                              Text(
                                'Diverse and fresh food.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: height / 90,
                              ),
                              Text(
                                "With the best local ingrdients, we have create\nfresh,delicious food and drinks",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 12,
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height) / 2.1,
                          width: width,
                          child: Image.asset("assets/Illustration3.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 57),
                          child: Column(
                            children: [
                              Text(
                                "+15K Restaurants",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: height / 90,
                              ),
                              Text(
                                "Easily find your favorite food and make deliveries in\na fat time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 12,
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height) / 2.1,
                          width: width,
                          child: Image.asset("assets/Illustration2.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 57),
                          child: Column(
                            children: [
                              Text(
                                "Free delivery on all orders",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: height / 90,
                              ),
                              Text(
                                "Free shipping on the first order when using CaPay\npayment method.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                firstSlideIndecator
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: height / 200,
                            width: width / 20,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: height / 200,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            width: width / 30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: height / 200,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            width: width / 30,
                          ),
                        ],
                      )
                    : secondSlideIndecator
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: height / 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                width: width / 30,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: height / 200,
                                width: width / 20,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                height: height / 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                width: width / 30,
                              ),
                            ],
                          )
                        : thirdSlideIndicator
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    height: height / 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5)),
                                    width: width / 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    height: height / 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5)),
                                    width: width / 30,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    height: height / 200,
                                    width: width / 20,
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ],
                              )
                            : null,
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        primary: themePrimaryColor,
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
