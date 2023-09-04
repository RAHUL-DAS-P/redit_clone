import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Comminity"),
      ),
      body: Padding(
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
              onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
