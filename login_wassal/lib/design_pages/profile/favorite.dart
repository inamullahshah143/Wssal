import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
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
                'Favorite List',
                style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
              ),
            ),
            Divider(),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              margin: EdgeInsets.only(bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Image(
                        image: AssetImage('asset/Content.png'),
                      ),
                      title: Text('title'),
                      trailing: Container(
                        child: RatingBar.builder(
                          itemSize: 22,
                          initialRating: 1,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 1,
                          itemBuilder: (context, _) => Icon(
                            Icons.favorite,
                            color: Color.fromRGBO(255, 199, 0, 100),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
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
                                      left:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 199, 0, 100),
                                          border: Border.all(
                                              color: Colors.white, width: 3),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        width: 50,
                                        height: 50,
                                        child: Icon(Icons.warning,
                                            color: Colors.white, size: 40),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Are You sure to Remove this item',
                                            style: TextStyle(
                                                height: 1.5, fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                actions: <Widget>[
                                  Container(
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Yes'),
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            height: 1.5, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'No'),
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            height: 1.5, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text('price'),
                          Container(
                            margin: EdgeInsets.only(right: 5, left: 5),
                            child: Icon(Icons.fiber_manual_record_rounded,
                                size: 5),
                          ),
                          Text('subtitle')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
