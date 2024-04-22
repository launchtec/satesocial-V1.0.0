import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/auth/data/models/user_location.dart';
import 'package:sate_social/features/auth/domain/use_cases/update_location_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/update_location/update_location_state.dart';

class UpdateLocationCubit extends Cubit<UpdateLocationState> {
  final UpdateLocationCase _updateLocationCase;

  UpdateLocationCubit({
    required UpdateLocationCase updateLocationCase,
  })  : _updateLocationCase = updateLocationCase,
        super(const UpdateLocationState());

  Future<void> updateLocation(UserLocation userLocation) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _updateLocationCase(
          FirebaseAuth.instance.currentUser!.uid, userLocation);
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
