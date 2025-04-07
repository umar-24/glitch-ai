import 'package:flutter/material.dart';
import 'package:glitch_ai/screens/authentication/login_screen.dart';
import 'package:glitch_ai/screens/authentication/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
      print("Toggled: $showLoginPage"); // Debug print
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onPressed: togglePages,
      );
    } else {
      return RegisterScreen(
        onPressed: togglePages,
      );
    }
  }
}