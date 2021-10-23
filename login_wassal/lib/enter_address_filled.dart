import 'package:flutter/material.dart';

class EnterAddressFilled extends StatefulWidget {
  const EnterAddressFilled({Key key}) : super(key: key);

  @override
  _EnterAddressFilledState createState() => _EnterAddressFilledState();
}

class _EnterAddressFilledState extends State<EnterAddressFilled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 8),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                // padding: EdgeInsets.all(50),
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/images/location_mark.png'),
                  ),
                ),
              ),
              Text(
                'Find restaurants near you',
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Please enter your location or allow access to your\nlocation to find restaurants near you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25),
                ),
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(244, 245, 247, 1),
                ),
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Color.fromRGBO(222, 61, 48, 1),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Color.fromRGBO(0, 135, 90, 1),
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        isDense: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 40, top: 15),
                        hintText: "Enter a new address",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(118, 129, 150, 1),
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromRGBO(244, 245, 247, 1),
                        ),
                        child: const ListTile(
                          dense: true,
                          minLeadingWidth: 0,
                          title: Text('Hanoi'),
                          subtitle: Text('Hoan Kiem, Hanoi'),
                          leading: Icon(
                            Icons.near_me_rounded,
                            color: Colors.grey,
                          ),
                          trailing: Icon(
                            Icons.check_circle_rounded,
                            color: Color.fromRGBO(0, 135, 90, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2.5),
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(244, 245, 247, 1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const ListTile(
                          dense: true,
                          minLeadingWidth: 0,
                          title: Text('Hanoi'),
                          subtitle: Text('Hoan Kiem, Hanoi'),
                          leading: Icon(
                            Icons.near_me_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2.5),
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(244, 245, 247, 1),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const ListTile(
                          dense: true,
                          minLeadingWidth: 0,
                          title: Text('Hanoi'),
                          subtitle: Text('Hoan Kiem, Hanoi'),
                          leading: Icon(
                            Icons.near_me_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    fixedSize: Size(MediaQuery.of(context).size.width - 60, 45),
                    primary: const Color.fromRGBO(255, 199, 0, 1),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
