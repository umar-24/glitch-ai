import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glitch_ai/firebase_options.dart';
import 'package:glitch_ai/provider/splash_screen_provider.dart';
import 'package:glitch_ai/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
