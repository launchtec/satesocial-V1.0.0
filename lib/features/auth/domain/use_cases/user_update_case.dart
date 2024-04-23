import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UserUpdateCase {
  final AuthRepository authRepository;

  UserUpdateCase({required this.authRepository});

  Future<void> call(AppUser user) {
    return authRepository.updateUserInfo(
        user: user
    );
  }
}