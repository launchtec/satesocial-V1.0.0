import 'package:sate_social/features/auth/data/models/app_user.dart';

import '../entities/auth_user.dart';
import '../use_cases/sign_up_use_case.dart';

abstract class AuthRepository {
  Stream<AuthUser> get authUser;

  Future<AppUser> getUserInfo({required String userId});

  Future<AuthUser> signUp({
    required SignUpParams signUpParams,
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<bool> recoveryPass({
    required String email,
  });

  Future<void> signOut();
}