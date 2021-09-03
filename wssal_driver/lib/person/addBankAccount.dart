import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';

import '../function.dart';
// import 'functions.dart';


class AddBankAccount extends StatefulWidget {
  // const AddBankAccount({ Key? key }) : super(key: key);

  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  @override
    Widget build(BuildContext context) {
    latestContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          // iconTheme:
          backgroundColor: Colors.white,
          elevation: 0,
          title: Align(
            alignment: Alignment.center,
            child: Text("Add Bank Account",
            style: TextStyle(
              color: Colors.black
            ),
            ),
          ),
          iconTheme: new IconThemeData(color: Colors.black),
          // child: new Icon(Icons.add),

          // actions: [
          //   Image(
          //     image: AssetImage('assets/app_logo.png'),
          //   )
          // ],
          automaticallyImplyLeading: true,
          // centerTitle: true,
        ),
      ),
      //  appBar: AppBar(
      //   title: Align(
      //     alignment: Alignment.center,
      //     child: Text('Add Bank Account'),
      //   ),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
             Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  // onFieldSubmitted: (value) {
                  //   print(value);
                  //   setState(() {
                  //     addressList.add(value);
                  //   });
                  //   addressController.clear();
                  // },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // icon: Icon(
                      //   Icons.calendar_today_outlined,
                      //   color: Color.fromRGBO(193, 199, 208, 1),
                      // ),
                      labelText: '     Account Name'),
                )),
                Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  // onFieldSubmitted: (value) {
                  //   print(value);
                  //   setState(() {
                  //     addressList.add(value);
                  //   });
                  //   addressController.clear();
                  // },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // icon: Icon(
                      //   Icons.calendar_today_outlined,
                      //   color: Color.fromRGBO(193, 199, 208, 1),
                      // ),
                      labelText: '     IBAN Number'),
                )),
                Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  // onFieldSubmitted: (value) {
                  //   print(value);
                  //   setState(() {
                  //     addressList.add(value);
                  //   });
                  //   addressController.clear();
                  // },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // icon: Icon(
                      //   Icons.calendar_today_outlined,
                      //   color: Color.fromRGBO(193, 199, 208, 1),
                      // ),
                      labelText: '     Bank Name'),
                )),
                Container(
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 245, 247, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                // margin: EdgeInsets.only(left: 30),
                height: 50,
                width: width,
                child: TextFormField(
                  // controller: seachController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  // onFieldSubmitted: (value) {
                  //   print(value);
                  //   setState(() {
                  //     addressList.add(value);
                  //   });
                  //   addressController.clear();
                  // },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // icon: Icon(
                      //   Icons.calendar_today_outlined,
                      //   color: Color.fromRGBO(193, 199, 208, 1),
                      // ),
                      labelText: '     Swift Code'),
                )),
                Container(
                //  alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                child: Row(
                  children: [
                    AnimatedIconButton(
                      size: 25,
                      onPressed: () => print('all icons pressed'),
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.check_circle,
                            color: textColor,
                          ),
                          onPressed: () => print('add pressed'),
                        ),
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'I Agree on Terms and Conditions',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),
                  Container(
                //  alignment: Alignment.centerLeft,
                margin: EdgeInsets.only( left: 15, right: 15),
                child: Row(
                  children: [
                    AnimatedIconButton(
                      size: 25,
                      onPressed: () => print('all icons pressed'),
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.check_circle,
                            color: textColor,
                          ),
                          onPressed: () => print('add pressed'),
                        ),
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'I Agree on Terms and Conditions',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),
                  Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
              height: 50,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(15)),
              child: Align(alignment: Alignment.center, child: Text('Add Bank Account')),
            ),
            
          ],
        ),
      ),
    );
  }
}