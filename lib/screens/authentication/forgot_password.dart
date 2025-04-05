import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/widgets/custom_elevated_button.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.primaryGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color of the back button
          ),
          backgroundColor: Colors.transparent,
          title: Text('Forgot Password', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset Your Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter your email address below and we will send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      prefixIcon: Icon(Iconsax.direct_right),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    text: "Send Reset Link",
                    color: AppColors.white,
                    textColor: AppColors.black,
                    size: 16,
                    onPressed: () {
                      // Handle password reset logic here
                      String email = _emailController.text;
                      if (email.isNotEmpty) {
                        // Simulate sending a password reset email
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password reset link sent to $email'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter your email')),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Navigate back to login or home screen
                      Navigator.pop(context);
                    },
                    child: Text('Back to Login', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
