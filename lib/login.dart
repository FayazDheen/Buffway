import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'otp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controller = TextEditingController();
  bool isFullNumber = true;
  isFullNumberCheck() {
    if (_controller.text.length == 10) {
      setState(() {
        isFullNumber = true;
      });
      return true;
    } else
      return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.topLeft, children: [
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 60),
                      child: Text(
                        'Enter Mobile\nNumber',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 60),
                      child: Text(
                        'Enter your phone number to verify\nyour account and place Order',
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.green,
                      // primaryColorDark: Colors.red,
                    ),
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 1, color: Colors.green),
                        ),
                        focusColor: Colors.green,
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        hintText: 'Phone Number',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('+91'),
                        ),
                      ),
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: _controller,
                    ),
                  ),
                ),
                isFullNumber
                    ? Container()
                    : Text(
                        "Please enter 10 Digit number",
                        style: TextStyle(color: Colors.red),
                      ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 160,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isFullNumberCheck()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPScreen(_controller.text)));
                      } else {
                        setState(() {
                          isFullNumber = false;
                        });
                      }
                    },
                    child: Text(
                      'SEND',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 35),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 40, height: 40),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 14,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
