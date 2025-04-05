import 'package:flutter/material.dart';
import 'package:glitch_ai/screens/authentication/welcome_screen.dart';


class SplashProvider with ChangeNotifier {
  
  void navigateToLogin(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }
}