import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everytime App Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Onboarding(),
    );
  }
}

// Onboarding
class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset('image/OnboardingScreen.jpg'),
      ),
    );
  }
}
