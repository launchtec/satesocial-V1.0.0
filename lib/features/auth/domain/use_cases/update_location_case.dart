import 'package:sate_social/features/auth/data/models/user_location_fcm.dart';
import 'package:sate_social/features/auth/domain/repositories/auth_repository.dart';

class UpdateLocationCase {
  final AuthRepository authRepository;

  UpdateLocationCase({required this.authRepository});

  Future<void> call(String userId, UserLocationFcm userLocation) {
    return authRepository.updateUserLocation(
        userId: userId,
        userLocation: userLocation
    );
  }
}