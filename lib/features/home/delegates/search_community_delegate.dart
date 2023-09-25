// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/common/error_text.dart';
import 'package:redit_clone/common/progress_indicator.dart';
import 'package:redit_clone/features/community/controller/community_contrtoller.dart';
import 'package:routemaster/routemaster.dart';

class SearchCommunityDelegate extends SearchDelegate {
  final WidgetRef _ref;
  SearchCommunityDelegate({
    required WidgetRef ref,
  }) : _ref = ref;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  void navigateToCommunityProfile(BuildContext context, String communityName) {
    Routemaster.of(context).push("/r/$communityName");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _ref.watch(searchCommunityProvider(query)).when(
          data: (communities) => ListView.builder(
            itemBuilder: (context, index) {
              final community = communities[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(community.banner),
                ),
                title: Text("r/${community.name}"),
                onTap: () =>
                    navigateToCommunityProfile(context, community.name),
              );
            },
            itemCount: communities.length,
          ),
          error: (error, stackTrace) => Errortext(
            text: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
