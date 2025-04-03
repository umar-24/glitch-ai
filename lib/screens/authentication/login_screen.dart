import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/screens/authentication/register_screen.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

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
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Login to your account",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildElevatedButton(
                    borderColor: AppColors.white,
                    textColor: AppColors.black,
                    color: AppColors.white,
                    "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Proceed with login
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
                    onPressed: () {},
                    color: AppColors.white,
                    borderColor: AppColors.white,
                    textColor: AppColors.black,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : false,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.black54),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Iconsax.eye
                        : Iconsax.eye_slash,
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
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\$',
            ).hasMatch(value)) {
          return "Enter a valid email";
        }
        if (isPassword &&
            !RegExp(
              r'^(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}\$',
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
          icon:
              icon ?? const SizedBox(),
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
}
