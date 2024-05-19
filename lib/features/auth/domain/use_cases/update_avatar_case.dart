import 'package:sate_social/features/auth/data/models/avatar_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UpdateAvatarCase {
  final AuthRepository authRepository;

  UpdateAvatarCase({required this.authRepository});

  Future<void> call(String userId, AvatarUser avatarUser) {
    return authRepository.updateUserAvatar(
        userId: userId,
        avatarUser: avatarUser
    );
  }
}