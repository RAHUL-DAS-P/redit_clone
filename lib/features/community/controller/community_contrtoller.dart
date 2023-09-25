import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/core/providers/storage_repository.dart';
import 'package:redit_clone/core/utils.dart';
import 'package:redit_clone/features/community/repository/community_repository.dart';
import 'package:redit_clone/features/controller/auth_controller.dart';
import 'package:redit_clone/model/community_model.dart';
import 'package:routemaster/routemaster.dart';

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
});

final userCommunitiesProvider = StreamProvider((ref) {
  return ref
      .watch(
        communityControllerProvider.notifier,
      )
      .getUserCommities();
});

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>(
  (ref) {
    return CommunityController(
      storageRepository: ref.watch(storageRepositoryProvider),
      communityRepository: ref.watch(communityRepositoryProvider),
      ref: ref,
    );
  },
);

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createCommunity(BuildContext context, String name) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? "";
    Community community = Community(
      name,
      name,
      Constants.bannerDefault,
      Constants.avatarDefault,
      [uid],
      [uid],
    );

    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, "Community created successfully");
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Community>> getUserCommities() {
    final user = _ref.read(userProvider);
    return _communityRepository.getUserCommunities(user!.uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

  void editCommunity({
    required Community community,
    required File? profileFile,
    required File? bannerFile,
    required BuildContext context,
  }) async {
    state = true;
    if (profileFile != null) {
      final res = await _storageRepository.sendUserData(
        path: "communities/profile",
        id: community.name,
        file: profileFile,
      );

      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) {
          showSnackBar(context, "Community details updated");
          community = community.copyWith(avatar: r);
        },
      );
    }

    if (bannerFile != null) {
      final res = await _storageRepository.sendUserData(
        path: "communities/banner",
        id: community.name,
        file: bannerFile,
      );

      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) {
          showSnackBar(context, "Community details updated");
          community = community.copyWith(banner: r);
        },
      );
    }

    final res = await _communityRepository.editCommunity(community);
    state = false;
    res.fold(
      (l) {
        // print(l.message);
        showSnackBar(context, l.message);
      },
      (r) => Routemaster.of(context).pop(),
    );
  }
}
