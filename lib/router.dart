import 'package:flutter/material.dart';
import 'package:redit_clone/features/community/screens/create_community_screen.dart';
import 'package:redit_clone/features/home/screens/home_screen.dart';
import 'package:redit_clone/features/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: LoginScreen(),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    "/": (_) => const MaterialPage(
          child: HomePage(),
        ),
    "/create-community": (route) => const MaterialPage(
          child: CreateCommunitySCreen(),
        ),
  },
);
