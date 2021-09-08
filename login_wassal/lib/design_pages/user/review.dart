import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wassal_customer/design_pages/user/popular.dart';
 

class Review extends StatefulWidget {
  

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                RatingBarIndicator(
                  rating: 3.5,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                ),
                Text(
                  '4.6 (999+)',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                Text(
                  'Overall',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: 5,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            itemCount: 5,
                            itemSize: 15.0,
                          ),
                          Text('(500+)')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: 5,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            itemCount: 5,
                            itemSize: 15.0,
                          ),
                          Text('(50+)')
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: 3,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            itemCount: 3,
                            itemSize: 15.0,
                          ),
                          Text('(50+)')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: 2,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            itemCount: 2,
                            itemSize: 15.0,
                          ),
                          Text('(10+)')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: 1,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            itemCount: 1,
                            itemSize: 15.0,
                          ),
                          Text('(10+)')
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 400,
            child: ListView.builder(
              itemCount: coment == null ? 0 : coment.length,
              itemBuilder: (_, i) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('${coment[i]["img"]}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${coment[i]["name"]}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 40),
                                  Text(
                                    '${coment[i]["time"]}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: coment[i]["rating"],
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.red,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${coment[i]["short-coment"]}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${coment[i]["coment"]}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('asset/pizza.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('asset/coffee.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('asset/pizza.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('asset/starbucks.png'),
                        colorFilter: ColorFilter.mode(
                            Colors.black, BlendMode.saturation),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Text(
                      '+4',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 400,
            child: ListView.builder(
              itemCount: badcoment == null ? 0 : badcoment.length,
              itemBuilder: (_, i) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage('${badcoment[i]["img"]}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${badcoment[i]["name"]}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: 40),
                                  Text(
                                    '${badcoment[i]["time"]}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: badcoment[i]["rating"],
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.red,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${badcoment[i]["short-coment"]}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${badcoment[i]["coment"]}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
