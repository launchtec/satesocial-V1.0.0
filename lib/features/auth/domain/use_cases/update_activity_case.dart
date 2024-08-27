import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UpdateActivityCase {
  final AuthRepository authRepository;

  UpdateActivityCase({required this.authRepository});

  Future<void> call(String userId, String lastActivity) {
    return authRepository.updateUserActivity(
        userId: userId,
        lastActivity: lastActivity
    );
  }
}