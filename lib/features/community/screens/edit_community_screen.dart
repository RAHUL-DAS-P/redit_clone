import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/common/error_text.dart';
import 'package:redit_clone/common/progress_indicator.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/features/community/controller/community_contrtoller.dart';
import 'package:redit_clone/theme/pallete.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
        data: (community) => Scaffold(
              appBar: AppBar(
                backgroundColor: Pallete.darkModeAppTheme.canvasColor,
                title: const Text("Edit Community"),
                centerTitle: false,
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Save",
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          DottedBorder(
                            strokeCap: StrokeCap.round,
                            dashPattern: const [10, 4],
                            radius: const Radius.circular(10),
                            color: Pallete
                                .darkModeAppTheme.textTheme.bodySmall!.color!,
                            borderType: BorderType.RRect,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: community.banner.isEmpty ||
                                      community.banner ==
                                          Constants.bannerDefault
                                  ? const Center(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 40,
                                      ),
                                    )
                                  : Image.network(
                                      community.banner,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                community.avatar,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => Errortext(text: error.toString()),
        loading: () => const Loader());
  }
}
