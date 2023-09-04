import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/router.dart';
import 'package:redit_clone/theme/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:redit_clone/firebase_options.dart';
import 'package:routemaster/routemaster.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Pallete.darkModeAppTheme,
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => loggedOutRoute),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
