import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class AddNewPayment extends StatefulWidget {
  @override
  _AddNewPaymentState createState() => _AddNewPaymentState();
}

class _AddNewPaymentState extends State<AddNewPayment> {
  @override
  Widget build(BuildContext context) {
    bool isChecked;
    return Container(
      // height: MediaQuery.of(context).size.height / 1.1,
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Add your payment methods",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Divider(
                color: Colors.grey.shade500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on,
                            color: Colors.grey.shade500),
                        border: InputBorder.none,
                        hintText: 'Card Holder '),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on,
                            color: Colors.grey.shade500),
                            
                                suffix:  Container(
                                  width: 30,
                                  height: 30,
                                  child: RoundCheckBox(
                              size: 20,
                              onTap: (selected) {},
                              uncheckedColor: Colors.white,
                            ),
                                ),

                         
                         
                        border: InputBorder.none,
                        hintText: '0000-0000-0000-0000'),
                  ),
                ),
              ),
            ),
            //  Padding(
            //    padding: const EdgeInsets.only(top: 12.0),
            //    child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.grey.shade300,
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       height: 60,
            //        width: 300,
            //       child: Row(
            //           children: [
                        
            //        Container(
            //       alignment: Alignment.center,
            //       height: 60,
            //       width: 300,
            //       decoration: BoxDecoration(
            //         color: Colors.grey.shade300,
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: TextField(
            //           decoration: InputDecoration(
            //               prefixIcon: Icon(Icons.location_on,
            //                   color: Colors.grey.shade500),
            //             suffix:  RoundCheckBox(
            //                   size: 30,
            //                   onTap: (selected) {},
            //                   uncheckedColor: Colors.white,
            //                 ),

                           
                           
            //               border: InputBorder.none,
            //               hintText: '0000-0000-0000-0000'),
            //         ),
            //       ),
            //     ),
                      
            //           ],
            //         ),
                   
            //     ),
            //  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                       
                        border: InputBorder.none,
                        hintText: 'MM/YY'),
                  ),
                ),
              ),
            ),
                  Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      
                        border: InputBorder.none,
                        hintText: 'CVC'),
                  ),
                ),
              ),
            ),
              ],
            ),
             Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255,199,0,1 ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add Card")
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 12.0,bottom: 50),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text("Scan Card")
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
