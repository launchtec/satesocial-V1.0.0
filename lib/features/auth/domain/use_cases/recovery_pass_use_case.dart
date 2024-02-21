import '../repositories/auth_repository.dart';

class RecoveryPassUseCase {
  final AuthRepository authRepository;

  RecoveryPassUseCase({required this.authRepository});

  Future<bool> call(String email) async {
    try {
      bool result = await authRepository.recoveryPass(
        email: email,
      );
      return result;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}