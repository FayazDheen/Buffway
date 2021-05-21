import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
@override
  void initState() {
    Future.delayed(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Text(
              "Welcome to",
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Alhaji Suya",
              style: GoogleFonts.robotoCondensed(
                color: Colors.green,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(

              "Your favourite foods delevired\nfast at your door.",
              textAlign: TextAlign.left,
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 20,
                
              ),
            ),
            SizedBox(height:180),
            Image(
              image: AssetImage("asset/GrillFlame.jpg"),
            )
          ],
        ),
      ),
    );
  }
}
