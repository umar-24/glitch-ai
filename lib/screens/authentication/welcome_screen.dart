// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/constants/images.dart';
import 'package:glitch_ai/screens/authentication/login_screen.dart';
import 'package:glitch_ai/screens/authentication/register_screen.dart';
import 'package:glitch_ai/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Getting the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjusting font sizes based on screen width
    double titleFontSize = screenWidth * 0.06; // 6% of screen width
    double subtitleFontSize = screenWidth * 0.04; // 4% of screen width
    double buttonPadding = screenWidth * 0.05; // 5% of screen width

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Adjusting the logo size according to screen width
                  Image.asset(
                    AppImages.logo,
                    width: screenWidth * 0.9, // 50% of screen width
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Welcome to Glitch AI',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Your AI companion for all your needs',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  CustomElevatedButton(
                    text: "Login",
                    size: 18,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(_createRoute(const LoginScreen()));
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomElevatedButton(
                    text: "Register",
                    size: 18,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(_createRoute(const RegisterScreen()));
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.1);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
