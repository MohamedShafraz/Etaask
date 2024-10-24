import 'dart:async';

import 'package:etaask/services/taskService.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToIntroSlider();
  }

  void _navigateToIntroSlider() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/intro');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF182c54),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to eTaask',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
