import 'views/intro_slider.dart';
import 'views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'views/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eTask',
      theme: ThemeData(
        primaryColor: Color(0xFF182c55),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF182c55),
          ),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/intro': (context) => IntroSlider(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
