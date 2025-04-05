import 'package:flutter/material.dart';
import 'package:glitch_ai/provider/splash_screen_provider.dart';
import 'package:glitch_ai/screens/home_screen.dart';
import 'package:glitch_ai/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add your providers here
        ChangeNotifierProvider(create: (_) => SplashProvider()), // Example
        // You can add other providers as needed, e.g.,
        // ChangeNotifierProvider(create: (_) => AnotherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: SplashScreen (),
      ),
    );
  }
}
