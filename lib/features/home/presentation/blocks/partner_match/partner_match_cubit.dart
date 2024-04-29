import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/features/home/data/models/partner_match_model.dart';
import 'package:sate_social/features/home/domain/use_cases/partner_match_case.dart';
import 'package:sate_social/features/home/presentation/blocks/partner_match/partner_match_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data/blocks/request_status.dart';

class PartnerMatchCubit extends Cubit<PartnerMatchState> {
  final PartnerMatchUseCase _partnerMatchUseCase;

  PartnerMatchCubit({
    required PartnerMatchUseCase partnerMatchUseCase,
  })  : _partnerMatchUseCase = partnerMatchUseCase,
        super(const PartnerMatchState());

  void addReligionsChanged(String religion) {
    var religions = state.religions.toList();
    religions.add(religion);
    emit(
      state.copyWith(
        religions: religions,
      ),
    );
  }

  void removeReligionsChanged(String religion) {
    var religions = state.religions.toList();
    religions.remove(religion);
    emit(
      state.copyWith(
        religions: religions,
      ),
    );
  }

  void addEthnicitiesChanged(String ethnicity) {
    var ethnicities = state.ethnicities.toList();
    ethnicities.add(ethnicity);
    emit(
      state.copyWith(
        ethnicities: ethnicities,
      ),
    );
  }

  void removeEthnicitiesChanged(String ethnicity) {
    var ethnicities = state.ethnicities.toList();
    ethnicities.remove(ethnicity);
    emit(
      state.copyWith(
        ethnicities: ethnicities,
      ),
    );
  }

  void addEducationsChanged(String education) {
    var educations = state.educations.toList();
    educations.add(education);
    emit(
      state.copyWith(
        educations: educations,
      ),
    );
  }

  void removeEducationsChanged(String education) {
    var educations = state.educations.toList();
    educations.remove(education);
    emit(
      state.copyWith(
        educations: educations,
      ),
    );
  }

  void ageChanged(String age) {
    emit(
      state.copyWith(
        age: age,
      ),
    );
  }

  void addBodyTypesChanged(String bodyType) {
    var bodyTypes = state.bodyTypes.toList();
    bodyTypes.add(bodyType);
    emit(
      state.copyWith(
        bodyTypes: bodyTypes,
      ),
    );
  }

  void removeBodyTypesChanged(String bodyType) {
    var bodyTypes = state.bodyTypes.toList();
    bodyTypes.remove(bodyType);
    emit(
      state.copyWith(
        bodyTypes: bodyTypes,
      ),
    );
  }

  void dietChanged(String diet) {
    emit(
      state.copyWith(
        diet: diet,
      ),
    );
  }

  void politicsChanged(String politics) {
    emit(
      state.copyWith(
        politics: politics,
      ),
    );
  }

  Future<void> submitPartnerMatchForm() async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _partnerMatchUseCase(FirebaseAuth.instance.currentUser!.uid, PartnerMatchModel(
        id: const Uuid().v4(),
        religions: state.religions,
        ethnicities: state.ethnicities,
        educations: state.educations,
        age: state.age ?? '',
        bodyTypes: state.bodyTypes,
        diet: state.diet ?? '',
        politics: state.politics ?? ''
      ));
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
      emit(state.copyWith(requestStatus: RequestStatus.initial));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
