import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/auth/data/models/avatar_user.dart';
import 'package:sate_social/features/auth/domain/use_cases/update_avatar_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/update_avatar/update_avatar_state.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  final UpdateAvatarCase _updateAvatarCase;

  UpdateAvatarCubit({
    required UpdateAvatarCase updateAvatarCase,
  })  : _updateAvatarCase = updateAvatarCase,
        super(const UpdateAvatarState());

  Future<void> updateAvatar(AvatarUser avatarUser) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _updateAvatarCase(
          FirebaseAuth.instance.currentUser!.uid, avatarUser);
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
