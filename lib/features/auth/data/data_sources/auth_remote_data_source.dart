import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthUserModel?> get user;

  Future<AuthUserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name
  });

  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> recoveryPassword({
    required String email
  });

  Future<void> signOut();
}