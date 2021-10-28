import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wassal_customer/design_pages/user/AddNewItem.dart';
import 'package:wassal_customer/design_pages/user/popular.dart';

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Items',
            style: TextStyle(
                height: 1.5, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popular == null ? 0 : popular.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddNewItem(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 145,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 145,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage('asset/coffee.png'),
                            ),
                          ),
                        ),
                        Text(
                          'Mocha Cookie Cream',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(height: 1.5, fontSize: 16),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\$4.99',
                              style: TextStyle(height: 1.5, color: Colors.red),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.fiber_manual_record,
                                size: 8,
                              ),
                            ),
                            Text('Coffee'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text(
            'Our Menu',
            style: TextStyle(
                height: 1.5, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            height: 70,
            child: ListView.builder(
              itemCount: menu == null ? 0 : menu.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image(
                        height: 30,
                        image: AssetImage('${menu[i]["img"]}'),
                      ),
                      Text('${menu[i]["name"]}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
            'Hot Coffees',
            style: TextStyle(
                height: 1.5, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemCount: popular == null ? 0 : popular.length,
              itemBuilder: (_, i) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage('${popular[i]["img"]}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${popular[i]["name"]}'),
                              SizedBox(
                                width: 50,
                              ),
                              RatingBarIndicator(
                                rating: popular[i]["rating"],
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 1,
                                itemSize: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${popular[i]["price"]}',
                                style:
                                    TextStyle(height: 1.5, color: Colors.red),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Icons.fiber_manual_record,
                                  size: 8,
                                ),
                              ),
                              Text('${popular[i]["type"]}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
            'Frappuccino® Blended Beverages',
            style: TextStyle(
                height: 1.5, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemCount: popular == null ? 0 : popular.length,
              itemBuilder: (_, i) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage('${popular[i]["img"]}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${popular[i]["name"]}'),
                              SizedBox(
                                width: 50,
                              ),
                              RatingBarIndicator(
                                rating: popular[i]["rating"],
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 1,
                                itemSize: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${popular[i]["price"]}',
                                style:
                                    TextStyle(height: 1.5, color: Colors.red),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Icons.fiber_manual_record,
                                  size: 8,
                                ),
                              ),
                              Text('${popular[i]["type"]}'),
                            ],
                          ),
                        ],
                      ),
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
