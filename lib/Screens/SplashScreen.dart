import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  int duration = 0;
  Widget gotoPage;
  SplashPage({super.key, required this.gotoPage, required this.duration});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: duration), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => gotoPage));
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset(
          "assets/logo.png",
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
