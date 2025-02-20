import 'package:flutter/material.dart';
import 'sign_in_page.dart';  // Import the SignInPage


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sign In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage1(),
    );
  }
}
