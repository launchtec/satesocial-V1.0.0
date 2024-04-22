import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UserInfoCase {
  final AuthRepository authRepository;

  UserInfoCase({required this.authRepository});

  Future<AppUser> call(String userId) {
    return authRepository.getUserInfo(userId: userId);
  }
}