// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/constants/images.dart';
import 'package:glitch_ai/provider/splash_screen_provider.dart';
import 'package:provider/provider.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashProvider>(context, listen: false).navigateToLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(AppImages.logo, height: 200),
        )
      ),
    );
  }
}