import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/common/error_text.dart';
import 'package:redit_clone/common/progress_indicator.dart';
import 'package:redit_clone/features/community/controller/community_contrtoller.dart';
import 'package:redit_clone/model/community_model.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push("/create-community");
  }

  void navigateToCommunityProfile(BuildContext context, Community community) {
    Routemaster.of(context).push("/r/${community.name}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Create a community"),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ref.watch(userCommunitiesProvider).when(
                data: (comms) => Expanded(
                        child: ListView.builder(
                      itemBuilder: (BuildContext context, index) {
                        Community cumm = comms[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(cumm.avatar),
                          ),
                          title: Text("r/${cumm.name}"),
                          onTap: () =>
                              navigateToCommunityProfile(context, cumm),
                        );
                      },
                      itemCount: comms.length,
                    )),
                error: (error, stacktrace) => Errortext(text: error.toString()),
                loading: () => const Loader())
          ],
        ),
      ),
    );
  }
}
