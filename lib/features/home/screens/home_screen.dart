import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/features/controller/auth_controller.dart';
import 'package:redit_clone/features/home/drawer/community_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void showCommunityDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => showCommunityDrawer(context),
              icon: const Icon(Icons.menu),
            );
          },
        ),
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            iconSize: 2,
            onPressed: () {},
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                user.profilePic,
              ),
            ),
          ),
        ],
      ),
      drawer: const CommunityListDrawer(),
    );
  }
}
