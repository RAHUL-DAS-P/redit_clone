import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/common/error_text.dart';
import 'package:redit_clone/common/progress_indicator.dart';
import 'package:redit_clone/features/community/controller/community_contrtoller.dart';
import 'package:redit_clone/features/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

class CommunityProfileScreen extends ConsumerWidget {
  final String name;
  const CommunityProfileScreen({super.key, required this.name});

  void navigateToEditModerator(BuildContext context) {
    Routemaster.of(context).push("/mod-tools/$name");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
          data: (community) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 150,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            community.banner,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                community.avatar,
                              ),
                              radius: 35,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "r/${community.name}",
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              community.mods.contains(user.uid)
                                  ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                      ),
                                      onPressed: () =>
                                          navigateToEditModerator(context),
                                      child: const Text("Mod Tools"),
                                    )
                                  : OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        community.members.contains(user.uid)
                                            ? "Joined"
                                            : "Join",
                                      ),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("${community.members.length} members"),
                          )
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: const Text("displaying the posts")),
          error: (error, stackTrace) => Errortext(text: error.toString()),
          loading: () => const Loader()),
    );
  }
}
