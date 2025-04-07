import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glitch_ai/screens/authentication/welcome_screen.dart';
import 'package:glitch_ai/screens/chat_screen.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show a loading indicator while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong. Please try again.'));
          }

          // Check if user is logged in
          if (snapshot.hasData) {
            // If user is logged in, navigate to HomeScreen
            return ChatScreen();
          } else {
            // If no user is logged in, navigate to SelectionScreen
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}