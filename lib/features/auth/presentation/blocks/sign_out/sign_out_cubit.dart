import 'package:bloc/bloc.dart';
import 'package:sate_social/features/auth/presentation/blocks/sign_out/sign_out_state.dart';

import '../../../domain/use_cases/sign_out_use_case.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOutUseCase;

  SignOutCubit({
    required SignOutUseCase signOutUseCase,
  })  : _signOutUseCase = signOutUseCase,
        super(InitialSignOutState());


  Future<void> signOut() async {
    emit(LoadingSignOutState());
    try {
      await _signOutUseCase();
      emit(SuccessSignOutState());
    } catch (err) {
      emit(FailureSignOutState(err));
    }
  }
}