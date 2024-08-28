import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UpdateBuyMatchCase {
  final AuthRepository authRepository;

  UpdateBuyMatchCase({required this.authRepository});

  Future<void> call(String userId, bool buyMatch) {
    return authRepository.updateUserBuyMatch(
        userId: userId,
        buyMatch: buyMatch
    );
  }
}