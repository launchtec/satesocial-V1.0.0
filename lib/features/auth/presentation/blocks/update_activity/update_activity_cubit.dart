import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/auth/domain/use_cases/update_activity_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/update_activity/update_activity_state.dart';

class UpdateActivityCubit extends Cubit<UpdateActivityState> {
  final UpdateActivityCase _updateActivityCase;

  UpdateActivityCubit({
    required UpdateActivityCase updateActivityCase,
  })  : _updateActivityCase = updateActivityCase,
        super(const UpdateActivityState());

  Future<void> updateActivity() async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _updateActivityCase(
          FirebaseAuth.instance.currentUser!.uid, DateTime.now().toIso8601String());
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
