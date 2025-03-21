import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/data/models/avatar_user.dart';
import 'package:sate_social/features/auth/data/models/user_location_fcm.dart';

import '../entities/auth_user.dart';
import '../use_cases/sign_up_use_case.dart';

abstract class AuthRepository {
  Stream<AuthUser> get authUser;

  Future<AppUser> getUserInfo({required String userId});

  Future<List<AppUser>> getUsers();

  Future<void> updateUserLocation({required String userId, required UserLocationFcm userLocation});

  Future<void> updateUserActivity({required String userId, required String lastActivity});

  Future<void> updateUserBuyMatch({required String userId, required bool buyMatch});

  Future<void> updateUserAvatar({required String userId, required AvatarUser avatarUser});

  Future<void> updateUserInfo({required AppUser user});

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