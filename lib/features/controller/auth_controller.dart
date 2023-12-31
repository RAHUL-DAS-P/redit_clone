// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/utils.dart';
import 'package:redit_clone/features/repository/auth_repository.dart';
import 'package:redit_clone/model/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authStateChangeProvider = StreamProvider((ref) {
  return ref.watch(authControllerProvider.notifier).authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(authControllerProvider.notifier).getUserData(uid);
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      authRepository: ref.watch(
        authRepositoryProvider,
      ),
      ref: ref,
    );
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
