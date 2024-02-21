import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/sign_up_use_case.dart';
import '../../../domain/value_objects/email.dart';
import '../../../domain/value_objects/password.dart';
import '../email_status.dart';
import '../form_status.dart';
import '../password_status.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit({
    required SignUpUseCase signUpUseCase,
  })  : _signUpUseCase = signUpUseCase,
        super(const SignUpState());

  void nameChanged(String name) {
    emit(
      state.copyWith(
        name: name,
      ),
    );
  }

  void emailChanged(String value) {
    try {
      Email email = Email((email) => email..value = value);
      emit(
        state.copyWith(
          email: email,
          emailStatus: EmailStatus.valid,
        ),
      );
    } on ArgumentError {
      emit(state.copyWith(emailStatus: EmailStatus.invalid));
    }
  }

  void passwordChanged(String value) {
    try {
      Password password = Password((password) => password..value = value);
      emit(
        state.copyWith(
          password: password,
          passwordStatus: PasswordStatus.valid,
        ),
      );
    } on ArgumentError {
      emit(state.copyWith(passwordStatus: PasswordStatus.invalid));
    }
  }

  void ageChanged(int age) {
    emit(
      state.copyWith(
        age: age,
      ),
    );
  }

  void heightChanged(int height) {
    emit(
      state.copyWith(
        height: height,
      ),
    );
  }

  void genderChanged(String gender) {
    emit(
      state.copyWith(
        gender: gender,
      ),
    );
  }

  void ethnicityChanged(String ethnicity) {
    emit(
      state.copyWith(
        ethnicity: ethnicity,
      ),
    );
  }

  void sexualityChanged(String sexuality) {
    emit(
      state.copyWith(
        sexuality: sexuality,
      ),
    );
  }

  void openToConnectToChanged(String openToConnectTo) {
    emit(
      state.copyWith(
        openToConnectTo: openToConnectTo,
      ),
    );
  }

  void howDidYouKnowAboutUsChanged(String howDidYouKnowAboutUs) {
    emit(
      state.copyWith(
        howDidYouKnowAboutUs: howDidYouKnowAboutUs,
      ),
    );
  }

  void confirmRealPersonChanged(bool confirmRealPerson) {
    emit(
      state.copyWith(
        confirmRealPerson: confirmRealPerson,
      ),
    );
  }

  Future<void> signUp() async {
    if (!(state.emailStatus == EmailStatus.valid) ||
        !(state.passwordStatus == PasswordStatus.valid)) {
      emit(state.copyWith(formStatus: FormStatus.invalid));
      emit(state.copyWith(formStatus: FormStatus.initial));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      await _signUpUseCase(
        SignUpParams(
            name: state.name!,
            email: state.email!,
            password: state.password!,
            gender: state.gender!,
            age: state.age!,
            height: state.height,
            ethnicity: state.ethnicity,
            sexuality: state.sexuality!,
            openToConnectTo: state.openToConnectTo!,
            howDidYouKnowAboutUs: state.howDidYouKnowAboutUs,
            confirmRealPerson: state.confirmRealPerson!
        ),
      );
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }
}