import 'package:bloc/bloc.dart';
import 'package:sate_social/features/auth/presentation/blocks/recovery_pass/recovery_pass_state.dart';

import '../../../domain/use_cases/recovery_pass_use_case.dart';
import '../../../domain/value_objects/email.dart';
import '../email_status.dart';
import '../form_status.dart';

class RecoveryPassCubit extends Cubit<RecoveryPassState> {
  final RecoveryPassUseCase _recoveryPassUseCase;

  RecoveryPassCubit({
    required RecoveryPassUseCase recoveryPassUseCase,
  })  : _recoveryPassUseCase = recoveryPassUseCase,
        super(const RecoveryPassState());

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

  Future<void> accountRecovery() async {
    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      await _recoveryPassUseCase(
        state.email!.value
      );
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }
}