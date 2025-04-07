// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/screens/authentication/login_screen.dart';
import 'package:glitch_ai/screens/chat_screen.dart';
import 'package:glitch_ai/services/auth_service.dart';
import 'package:glitch_ai/utils/toast_message.dart';
import 'package:iconsax/iconsax.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback? onPressed;
  const RegisterScreen({super.key, this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child(
    'User',
  );
  void register() async {
    _auth
        .createUserWithEmailAndPassword(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
        )
        .then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
          Toasts().toastMessages("Account Created");
          final userId = value.user!.uid;
          _database.child(userId).set({
            "username": _usernameController.text.toString(),
            "email": _emailController.text.toString(),
            "password": _passwordController.text.toString(),
          });
        })
        .onError((error, StackTrace) {
          Toasts().toastMessagesAlert(error.toString());
          print("Error: ${error.toString()}");
        })
        .catchError((error) {
          Toasts().toastMessagesAlert(error.toString());
          print("Error: ${error.toString()}");
        })
        .whenComplete(() {
          setState(() {});
        });
  }

  // void register() async {
  //   try {
  //     // Create user with email and password
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(
  //           email: _emailController.text.toString(),
  //           password: _passwordController.text.toString(),
  //         );
  //     // Navigate to next screen
  //     Navigator.pushReplacement(
  //       // ignore: use_build_context_synchronously
  //       context,
  //       MaterialPageRoute(builder: (context) => ChatScreen()),
  //     );

  //     // Show success message
  //     Toasts().toastMessages("Account Created");

  //     // Save user data to Realtime Database
  //     final userId = userCredential.user!.uid;
  //     await _database.child(userId).set({
  //       "username": _usernameController.text.toString(),
  //       "email": _emailController.text.toString(),
  //       "password": _passwordController.text.toString(),
  //     });
  //   } on FirebaseAuthException catch (error) {
  //     // Handle authentication errors
  //     Toasts().toastMessagesAlert(error.message ?? "Authentication error");
  //     print("Error: ${error.message}");
  //   } catch (e) {
  //     // Handle any other errors
  //     Toasts().toastMessagesAlert("An error occurred: $e");
  //     print("Error: $e");
  //   } finally {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(gradient: AppColors.primaryGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.05,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Create a new account to get started",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    _usernameController,
                    "Username",
                    Iconsax.user,
                    isUsername: true,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    _emailController,
                    "Email",
                    Iconsax.direct_right,
                    isEmail: true,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    _passwordController,
                    "Password",
                    Iconsax.lock,
                    isPassword: true,
                  ),
                  // const SizedBox(height: 10),
                  // _buildTextField(
                  //   _confirmPasswordController,
                  //   "Confirm Password",
                  //   Iconsax.lock,
                  //   isPassword: true,
                  // ),
                  const SizedBox(height: 10),
                  _buildElevatedButton(
                    borderColor: AppColors.white,
                    textColor: AppColors.black,
                    color: AppColors.white,
                    "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Proceed with registration
                        register();
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildDividerWithText("OR"),
                  const SizedBox(height: 10),
                  _buildElevatedButton(
                    "Continue with Google",
                    icon: Image.asset(
                      "assets/logo/google.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: () async {
                      final userCredential =
                          await AuthService().signInWithGoogle();

                      if (userCredential == null) {
                        // Handle sign-in failure (e.g., show an error message)
                        print('Google sign-in failed or was canceled');
                      } else {
                        // Sign-in successful, navigate to BottomNavBarPage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      }
                    },
                    color: AppColors.white,
                    borderColor: AppColors.white,
                    textColor: AppColors.black,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        // onPressed: widget.onPressed, // Toggle to LoginScreen
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool isPassword = false,
    bool isEmail = false,
    bool isUsername = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : false,
      keyboardType:
          isEmail
              ? TextInputType.emailAddress
              : isUsername
              ? TextInputType.text
              : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.black54),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
                : null,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (isEmail &&
            !RegExp(
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
            ).hasMatch(value)) {
          return "Enter a valid email";
        }
        if (isUsername && value.length < 3) {
          return "Username must be at least 3 characters long";
        }
        if (isPassword &&
            !RegExp(
              r'^(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}$',
            ).hasMatch(value)) {
          return "Password must be 8+ chars, include 1 uppercase, 1 number & 1 special character";
        }
        return null;
      },
    );
  }

  Widget _buildElevatedButton(
    String text, {
    Widget? icon,
    required VoidCallback onPressed,
    Color? color,
    Color? borderColor,
    Color? textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: borderColor ?? AppColors.transparent,
              width: 2,
            ),
          ),
          onPressed: onPressed,
          icon: icon ?? const SizedBox(),
          label: Text(
            text,
            style: TextStyle(color: textColor ?? AppColors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
      ],
    );
  }

  // Route _createRoute(Widget child) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => child,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.1);
  //       const end = Offset.zero;
  //       const curve = Curves.easeInOut;

  //       var tween = Tween(
  //         begin: begin,
  //         end: end,
  //       ).chain(CurveTween(curve: curve));
  //       var offsetAnimation = animation.drive(tween);

  //       return SlideTransition(position: offsetAnimation, child: child);
  //     },
  //   );
  // }
}
