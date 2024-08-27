import 'package:bloc/bloc.dart';
import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/auth/domain/use_cases/user_update_case.dart';
import 'package:sate_social/features/auth/presentation/blocks/user_update/user_update_state.dart';

import '../../../../../core/data/blocks/request_status.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  final UserUpdateCase _userUpdateCase;

  UserUpdateCubit({
    required UserUpdateCase userUpdateCase,
  })  : _userUpdateCase = userUpdateCase,
        super(const UserUpdateState());

  void ageChanged(int age) {
    emit(
      state.copyWith(
        age: age,
      ),
    );
  }

  void heightChanged(String height) {
    emit(
      state.copyWith(
        height: height,
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

  void genderChanged(String gender) {
    emit(
      state.copyWith(
        gender: gender,
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

  void openToConnectToChanged(List<String> listOpenToConnectTo) {
    emit(
      state.copyWith(
        openToConnectTo: listOpenToConnectTo,
      ),
    );
  }

  void addOpenToConnectToChanged(String openToConnectTo) {
    var openToConnectList = state.openToConnectTo ?? [];
    openToConnectList.add(openToConnectTo);
    emit(
      state.copyWith(
        openToConnectTo: openToConnectList,
      ),
    );
  }

  void removeOpenToConnectToChanged(String openToConnectTo) {
    var openToConnectList = state.openToConnectTo ?? [];
    openToConnectList.remove(openToConnectTo);
    emit(
      state.copyWith(
        openToConnectTo: openToConnectList,
      ),
    );
  }

  void relationshipChanged(String relationship) {
    emit(
      state.copyWith(
        relationship: relationship,
      ),
    );
  }

  void relationshipActiveChanged(bool activeOnCard) {
    emit(
      state.copyWith(
        activeRelationship: activeOnCard,
      ),
    );
  }

  void userLinkInstagramChanged(String userLinkInstagram) {
    emit(
      state.copyWith(
        userLinkInstagram: userLinkInstagram,
      ),
    );
  }

  void instagramActiveChanged(bool activeOnCard) {
    emit(
      state.copyWith(
        activeInstagram: activeOnCard,
      ),
    );
  }

  Future<void> updateUserInfo(AppUser user) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _userUpdateCase(AppUser(
          id: user.id,
          name: user.name,
          email: user.email,
          age: state.age ?? user.age,
          height: state.height ?? user.height,
          ethnicity: state.ethnicity ?? user.ethnicity,
          gender: state.gender ?? user.gender,
          sexuality: state.sexuality ?? user.sexuality,
          openToConnectTo: state.openToConnectTo ?? user.openToConnectTo,
          relationship: state.relationship ?? user.relationship,
          activeRelationship: state.activeRelationship ?? user.activeRelationship,
          userLinkInstagram: state.userLinkInstagram ?? user.userLinkInstagram,
          activeInstagram: state.activeInstagram ?? user.activeInstagram,
          avatar: user.avatar,
          confirmRealPerson: user.confirmRealPerson
      ));
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
      emit(state.copyWith(requestStatus: RequestStatus.initial));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
