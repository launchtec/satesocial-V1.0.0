import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/features/home/data/models/self_match_model.dart';
import 'package:sate_social/features/home/domain/use_cases/self_match_case.dart';
import 'package:sate_social/features/home/presentation/blocks/self_match/self_match_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data/blocks/request_status.dart';

class SelfMatchCubit extends Cubit<SelfMatchState> {
  final SelfMatchUseCase _selfMatchUseCase;

  SelfMatchCubit({
    required SelfMatchUseCase selfMatchUseCase,
  })  : _selfMatchUseCase = selfMatchUseCase,
        super(const SelfMatchState());

  void zodiacChanged(String zodiac) {
    emit(
      state.copyWith(
        zodiac: zodiac,
      ),
    );
  }

  void religionChanged(String religion) {
    emit(
      state.copyWith(
        religion: religion,
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

  void educationChanged(String education) {
    emit(
      state.copyWith(
        education: education,
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

  void bodyTypeChanged(String bodyType) {
    emit(
      state.copyWith(
        bodyType: bodyType,
      ),
    );
  }

  void childrenChanged(String children) {
    emit(
      state.copyWith(
        children: children,
      ),
    );
  }

  void familyPlanChanged(String familyPlan) {
    emit(
      state.copyWith(
        familyPlan: familyPlan,
      ),
    );
  }

  void marijuanaChanged(String marijuana) {
    emit(
      state.copyWith(
        marijuana: marijuana,
      ),
    );
  }

  void smokerCigaretteChanged(String smokerCigarette) {
    emit(
      state.copyWith(
        smokerCigarette: smokerCigarette,
      ),
    );
  }

  void alcoholChanged(String alcohol) {
    emit(
      state.copyWith(
        alcohol: alcohol,
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

  void satisfactionChanged(String satisfaction) {
    emit(
      state.copyWith(
        satisfaction: satisfaction,
      ),
    );
  }

  void addFeaturesChanged(String feature) {
    var features = state.features.toList();
    features.add(feature);
    emit(
      state.copyWith(
        features: features,
      ),
    );
  }

  void removeFeaturesChanged(String feature) {
    var features = state.features.toList();
    features.remove(feature);
    emit(
      state.copyWith(
        features: features,
      ),
    );
  }

  void addPhysicalFeaturesChanged(String feature) {
    var physicalFeatures = state.physicalFeatures.toList();
    physicalFeatures.add(feature);
    emit(
      state.copyWith(
        physicalFeatures: physicalFeatures,
      ),
    );
  }

  void removePhysicalFeaturesChanged(String feature) {
    var physicalFeatures = state.physicalFeatures.toList();
    physicalFeatures.remove(feature);
    emit(
      state.copyWith(
        physicalFeatures: physicalFeatures,
      ),
    );
  }

  void cheatingChanged(String cheating) {
    emit(
      state.copyWith(
        cheating: cheating,
      ),
    );
  }

  void addHappiestChanged(String happiest) {
    var happiestList = state.happiest.toList();
    happiestList.add(happiest);
    emit(
      state.copyWith(
        happiest: happiestList,
      ),
    );
  }

  void removeHappiestChanged(String happiest) {
    var happiestList = state.happiest.toList();
    happiestList.remove(happiest);
    emit(
      state.copyWith(
        happiest: happiestList,
      ),
    );
  }

  void howOftenWorkoutChanged(String howOftenWorkout) {
    emit(
      state.copyWith(
        howOftenWorkout: howOftenWorkout,
      ),
    );
  }

  void addVacationsChanged(String vacation) {
    var vacations = state.vacations.toList();
    vacations.add(vacation);
    emit(
      state.copyWith(
        vacations: vacations,
      ),
    );
  }

  void removeVacationsChanged(String vacation) {
    var vacations = state.vacations.toList();
    vacations.remove(vacation);
    emit(
      state.copyWith(
        vacations: vacations,
      ),
    );
  }

  void addMostInterestedPersonChanged(String mostInterestedPerson) {
    var mostInterestedPersonList = state.mostInterestedInPerson.toList();
    mostInterestedPersonList.add(mostInterestedPerson);
    emit(
      state.copyWith(
        mostInterestedInPerson: mostInterestedPersonList,
      ),
    );
  }

  void removeMostInterestedPersonChanged(String mostInterestedPerson) {
    var mostInterestedPersonList = state.likeToDo.toList();
    mostInterestedPersonList.remove(mostInterestedPerson);
    emit(
      state.copyWith(
        mostInterestedInPerson: mostInterestedPersonList,
      ),
    );
  }

  void addDressChanged(String dress) {
    var dresses = state.dress.toList();
    dresses.add(dress);
    emit(
      state.copyWith(
        dress: dresses,
      ),
    );
  }

  void removeDressChanged(String dress) {
    var dresses = state.dress.toList();
    dresses.remove(dress);
    emit(
      state.copyWith(
        dress: dresses,
      ),
    );
  }

  void importantIsSexChanged(String importantIsSex) {
    emit(
      state.copyWith(
        importantIsSex: importantIsSex,
      ),
    );
  }

  void marriageChanged(String marriage) {
    emit(
      state.copyWith(
        marriage: marriage,
      ),
    );
  }

  void addLikeToDoChanged(String likeToDo) {
    var likeToDoList = state.likeToDo.toList();
    likeToDoList.add(likeToDo);
    emit(
      state.copyWith(
        likeToDo: likeToDoList,
      ),
    );
  }

  void removeLikeToDoChanged(String likeToDo) {
    var likeToDoList = state.likeToDo.toList();
    likeToDoList.remove(likeToDo);
    emit(
      state.copyWith(
        likeToDo: likeToDoList,
      ),
    );
  }

  void addEatingBehaviorsChanged(String eatingBehavior) {
    var eatingBehaviors = state.eatingBehaviors.toList();
    eatingBehaviors.add(eatingBehavior);
    emit(
      state.copyWith(
        eatingBehaviors: eatingBehaviors,
      ),
    );
  }

  void removeEatingBehaviorsChanged(String eatingBehavior) {
    var eatingBehaviors = state.eatingBehaviors.toList();
    eatingBehaviors.remove(eatingBehavior);
    emit(
      state.copyWith(
        eatingBehaviors: eatingBehaviors,
      ),
    );
  }

  void addReasonsRelationshipChanged(String reasonsRelationship) {
    var reasonsRelationshipList = state.reasonsRelationship.toList();
    reasonsRelationshipList.add(reasonsRelationship);
    emit(
      state.copyWith(
        reasonsRelationship: reasonsRelationshipList,
      ),
    );
  }

  void removeReasonsRelationshipChanged(String reasonsRelationship) {
    var reasonsRelationshipList = state.reasonsRelationship.toList();
    reasonsRelationshipList.remove(reasonsRelationship);
    emit(
      state.copyWith(
        reasonsRelationship: reasonsRelationshipList,
      ),
    );
  }

  void addDatingIntentionsChanged(String datingIntention) {
    var datingIntentionList = state.datingIntentions.toList();
    datingIntentionList.add(datingIntention);
    emit(
      state.copyWith(
        datingIntentions: datingIntentionList,
      ),
    );
  }

  void removeDatingIntentionsChanged(String datingIntention) {
    var datingIntentionList = state.datingIntentions.toList();
    datingIntentionList.remove(datingIntention);
    emit(
      state.copyWith(
        datingIntentions: datingIntentionList,
      ),
    );
  }

  void addRelationshipTypeChanged(String relationshipType) {
    var relationshipTypeList = state.relationshipType.toList();
    relationshipTypeList.add(relationshipType);
    emit(
      state.copyWith(
        relationshipType: relationshipTypeList,
      ),
    );
  }

  void removeRelationshipTypeChanged(String relationshipType) {
    var relationshipTypeList = state.relationshipType.toList();
    relationshipTypeList.remove(relationshipType);
    emit(
      state.copyWith(
        relationshipType: relationshipTypeList,
      ),
    );
  }

  void addSportsHobbiesChanged(String sportsHobby) {
    var sportsHobbies = state.sportsHobbies.toList();
    sportsHobbies.add(sportsHobby);
    emit(
      state.copyWith(
        sportsHobbies: sportsHobbies,
      ),
    );
  }

  void removeSportsHobbiesChanged(String sportsHobby) {
    var sportsHobbies = state.sportsHobbies.toList();
    sportsHobbies.remove(sportsHobby);
    emit(
      state.copyWith(
        sportsHobbies: sportsHobbies,
      ),
    );
  }

  void addMusicHobbiesChanged(String musicHobby) {
    var musicHobbies = state.musicHobbies.toList();
    musicHobbies.add(musicHobby);
    emit(
      state.copyWith(
        musicHobbies: musicHobbies,
      ),
    );
  }

  void removeMusicHobbiesChanged(String musicHobby) {
    var musicHobbies = state.musicHobbies.toList();
    musicHobbies.remove(musicHobby);
    emit(
      state.copyWith(
        musicHobbies: musicHobbies,
      ),
    );
  }

  void addInterestHobbiesChanged(String interestHobby) {
    var interestHobbies = state.interestHobbies.toList();
    interestHobbies.add(interestHobby);
    emit(
      state.copyWith(
        interestHobbies: interestHobbies,
      ),
    );
  }

  void removeInterestHobbiesChanged(String interestHobby) {
    var interestHobbies = state.interestHobbies.toList();
    interestHobbies.remove(interestHobby);
    emit(
      state.copyWith(
        interestHobbies: interestHobbies,
      ),
    );
  }

  void addFetishesChanged(String fetish) {
    var fetishes = state.interestHobbies.toList();
    fetishes.add(fetish);
    emit(
      state.copyWith(
        fetishes: fetishes,
      ),
    );
  }

  void removeFetishesChanged(String fetish) {
    var fetishes = state.interestHobbies.toList();
    fetishes.remove(fetish);
    emit(
      state.copyWith(
        fetishes: fetishes,
      ),
    );
  }

  Future<void> submitSelfMatchForm() async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _selfMatchUseCase(FirebaseAuth.instance.currentUser!.uid, SelfMatchModel(
          id: const Uuid().v4(),
          zodiac: state.zodiac ?? '',
          religion: state.religion ?? '',
          ethnicity: state.ethnicity ?? '',
          education: state.education ?? '',
          height: state.height ?? '',
          bodyType: state.bodyType ?? '',
          children: state.children ?? '',
          familyPlan: state.familyPlan ?? '',
          marijuana: state.marijuana ?? '',
          smokerCigarette: state.smokerCigarette ?? '',
          alcohol: state.alcohol ?? '',
          diet: state.diet ?? '',
          politics: state.politics ?? '',
          satisfaction: state.satisfaction ?? '',
          features: state.features,
          physicalFeatures: state.physicalFeatures,
          cheating: state.cheating ?? '',
          happiest: state.happiest,
          howOftenWorkout: state.howOftenWorkout ?? '',
          vacations: state.vacations,
          mostInterestedInPerson: state.mostInterestedInPerson,
          dress: state.dress,
          importantIsSex: state.importantIsSex ?? '',
          marriage: state.marriage ?? '',
          likeToDo: state.likeToDo,
          eatingBehaviors: state.eatingBehaviors,
          reasonsRelationship: state.reasonsRelationship,
          datingIntentions: state.datingIntentions,
          relationshipType: state.relationshipType,
          sportsHobbies: state.sportsHobbies,
          musicHobbies: state.musicHobbies,
          interestHobbies: state.interestHobbies,
          fetishes: state.fetishes,
      ));
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
      emit(state.copyWith(requestStatus: RequestStatus.initial));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}