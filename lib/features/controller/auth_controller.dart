import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/utils.dart';
import 'package:redit_clone/features/repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>(
  (ref) {
    return AuthController(
      authRepository: ref.read(
        authRepositoryProvider,
      ),
    );
  },
);

class AuthController {
  final AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    user.fold(
      (l) => showSnackBar(context, l.message),
      (r) => null,
    );
  }
}
