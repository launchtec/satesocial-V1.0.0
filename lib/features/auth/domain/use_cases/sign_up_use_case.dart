import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthUser> call(SignUpParams params) async {
    try {
      AuthUser authUser = await authRepository.signUp(
        email: params.email.value,
        password: params.password.value,
      );
      return authUser;
    } on ArgumentError catch (error) {
      throw Exception(error);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class SignUpParams {
  final String name;
  final Email email;
  final Password password;
  final int age;
  final String gender;
  final String sexuality;
  final String openToConnectTo;
  final int? height;
  final String? ethnicity;
  final String? howDidYouKnowAboutUs;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    required this.sexuality,
    required this.openToConnectTo,
    this.height,
    this.ethnicity,
    this.howDidYouKnowAboutUs,
  });
}