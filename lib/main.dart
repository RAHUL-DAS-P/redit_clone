import 'package:flutter/material.dart';
import 'package:redit_clone/features/screens/login_screen.dart';
import 'package:redit_clone/theme/pallete.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Pallete.darkModeAppTheme,
      home: const LoginScreen(),
    );
  }
}
