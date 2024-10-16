import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void _showPopup() {}
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "eTaask",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF182C55),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _showPopup,
            child: Text("+"),
          ),
        ));
  }
}
