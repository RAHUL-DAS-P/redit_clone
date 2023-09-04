import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/common/progress_indicator.dart';
import 'package:redit_clone/features/community/controller/community_contrtoller.dart';

class CreateCommunitySCreen extends ConsumerStatefulWidget {
  const CreateCommunitySCreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunitySCreenState();
}

class _CreateCommunitySCreenState extends ConsumerState<CreateCommunitySCreen> {
  final TextEditingController communityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityController.dispose();
  }

  void createCommunity() {
    ref.read(communityControllerProvider.notifier).createCommunity(
          context,
          communityController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Comminity"),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Community"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: communityController,
                    decoration: const InputDecoration(
                      hintText: "r/Community-name",
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    maxLength: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Create Community",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
