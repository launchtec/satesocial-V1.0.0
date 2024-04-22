import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class GetUsersCase {
  final AuthRepository authRepository;

  GetUsersCase({required this.authRepository});

  Future<List<AppUser>> call() {
    return authRepository.getUsers();
  }
}