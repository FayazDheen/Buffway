import 'package:buffway/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(alignment: Alignment.topLeft, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Verification Code',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Please type the verification code sent to\n+91 ${widget.phone}',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.black54,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: PinPut(
                        fieldsCount: 6,
                        textStyle: const TextStyle(
                            fontSize: 25.0, color: Colors.white),
                        eachFieldWidth: 40.0,
                        eachFieldHeight: 55.0,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration,
                        followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.fade,
                        onSubmit: (pin) async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode,
                                        smsCode: pin))
                                .then((value) async {
                              try {
                                if (value.user != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                      (route) => false);
                                } else {
                                  print(value);
                                }
                              } on PlatformException catch (p) {
                                print(p);
                                FocusScope.of(context).unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Invalid OTP")));
                              } on Exception catch (e) {
                                print(e);
                                FocusScope.of(context).unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Invalid OTP")));
                              }
                            });
                          } on PlatformException catch (p) {
                            print(p);
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid OTP")));
                          } on Exception catch (e) {
                            print(e);
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Invalid OTP")));
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          'I don\'t receive code!',
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.black54,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          child: Text(
                            "Please resend",
                            style: GoogleFonts.robotoCondensed(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _verifyPhone();
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 10));
    setState(() {
      isLoading = false;
    });
  }
}
