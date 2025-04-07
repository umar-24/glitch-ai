import 'package:flutter/material.dart';
import 'package:glitch_ai/services/auth_gate.dart';


class SplashProvider with ChangeNotifier {
  
  void navigateToLogin(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AuthGate()),
      );
    });
  }
}