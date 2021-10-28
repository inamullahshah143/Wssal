import 'package:flutter/material.dart';

class DeliveryForm extends StatefulWidget {
  const DeliveryForm({Key key}) : super(key: key);

  @override
  _DeliveryFormState createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm> {
  TextEditingController name = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  String _country = 'Select Country';
  TextEditingController code = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.1,
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
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
                    'Billing Information',
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
                        'Billing Name',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: name,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Full Name Here"),
                        ),
                      ),
                      Text(
                        'Billing Company',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: company,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Company Name Here"),
                        ),
                      ),
                      Text(
                        'Billing Address',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: address,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Full Address Here..."),
                        ),
                      ),
                      Text(
                        'City',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: city,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "City Name Here"),
                        ),
                      ),
                      Text(
                        'Country',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          // showCountryPicker(
                          //   context: context,
                          //   // optional. Shows phone code before the country name.
                          //   onSelect: (Country country) {
                          //     setState(
                          //       () {
                          //         _country = country.name;
                          //       },
                          //     );
                          //   },
                          // );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(_country),
                          ),
                        ),
                      ),
                      Text(
                        'Postal Code',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: code,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Postal Code Here"),
                        ),
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            height: 1.5, color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintText: "Phone Number Here"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(name.text);
                          print(company.text);
                          print(address.text);
                          print(city.text);
                          print(_country);
                          print(code.text);
                          print(phone.text);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 35, bottom: 15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 199, 0, 100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
