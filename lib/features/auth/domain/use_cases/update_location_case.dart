import 'package:sate_social/features/auth/data/models/user_location.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UpdateLocationCase {
  final AuthRepository authRepository;

  UpdateLocationCase({required this.authRepository});

  Future<void> call(String userId, UserLocation userLocation) {
    return authRepository.updateUserLocation(
        userId: userId,
        userLocation: userLocation
    );
  }
}