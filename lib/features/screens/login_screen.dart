import 'package:flutter/material.dart';
import 'package:redit_clone/core/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          Constants.logoPath2,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Skip",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Dive into anything",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(Constants.googlePath),
        ],
      ),
    );
  }
}
