import 'package:flutter/material.dart';
import 'dart:async';

import 'package:itqan/first_Page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navigate to the next page (e.g., HomePage)
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => FirstPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'lib/images/logo.png',
          width: 200, // Adjust the width of the logo as needed
        ),

      ),



    );
  }
}
