import 'package:equatable/equatable.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';

class SelfMatchState extends Equatable {
  final String? zodiac;
  final String? religion;
  final String? ethnicity;
  final String? education;
  final String? height;
  final String? bodyType;
  final String? children;
  final String? familyPlan;
  final String? marijuana;
  final String? smokerCigarette;
  final String? alcohol;
  final String? diet;
  final String? politics;
  final String? satisfaction;
  final List<String> features;
  final List<String> physicalFeatures;
  final String? cheating;
  final List<String> happiest;
  final String? howOftenWorkout;
  final List<String> vacations;
  final List<String> mostInterestedInPerson;
  final List<String> dress;
  final String? importantIsSex;
  final String? marriage;
  final List<String> likeToDo;
  final List<String> eatingBehaviors;
  final List<String> reasonsRelationship;
  final List<String> datingIntentions;
  final List<String> relationshipType;
  final List<String> sportsHobbies;
  final List<String> musicHobbies;
  final List<String> interestHobbies;
  final List<String> fetishes;
  final RequestStatus requestStatus;

  const SelfMatchState({
    this.zodiac,
    this.religion,
    this.ethnicity,
    this.education,
    this.height,
    this.bodyType,
    this.children,
    this.familyPlan,
    this.marijuana,
    this.smokerCigarette,
    this.alcohol,
    this.diet,
    this.politics,
    this.satisfaction,
    this.features = const [],
    this.physicalFeatures = const [],
    this.cheating,
    this.happiest = const [],
    this.howOftenWorkout,
    this.vacations = const [],
    this.mostInterestedInPerson = const [],
    this.dress = const [],
    this.importantIsSex,
    this.marriage,
    this.likeToDo = const [],
    this.eatingBehaviors = const [],
    this.reasonsRelationship = const [],
    this.datingIntentions = const [],
    this.relationshipType = const [],
    this.sportsHobbies = const [],
    this.musicHobbies = const [],
    this.interestHobbies = const [],
    this.fetishes = const [],
    this.requestStatus = RequestStatus.initial,
  });

  SelfMatchState copyWith({
    String? zodiac,
    String? religion,
    String? ethnicity,
    String? education,
    String? height,
    String? bodyType,
    String? children,
    String? familyPlan,
    String? marijuana,
    String? smokerCigarette,
    String? alcohol,
    String? diet,
    String? politics,
    String? satisfaction,
    List<String>? features,
    List<String>? physicalFeatures,
    String? cheating,
    List<String>? happiest,
    String? howOftenWorkout,
    List<String>? vacations,
    List<String>? mostInterestedInPerson,
    List<String>? dress,
    String? importantIsSex,
    String? marriage,
    List<String>? likeToDo,
    List<String>? eatingBehaviors,
    List<String>? reasonsRelationship,
    List<String>? datingIntentions,
    List<String>? relationshipType,
    List<String>? sportsHobbies,
    List<String>? musicHobbies,
    List<String>? interestHobbies,
    List<String>? fetishes,
    RequestStatus? requestStatus
    }) {
    return SelfMatchState(
      zodiac: zodiac ?? this.zodiac,
      religion: religion ?? this.religion,
      ethnicity: ethnicity ?? this.ethnicity,
      education: education ?? this.education,
      height: height ?? this.height,
      bodyType: bodyType ?? this.bodyType,
      children: children ?? this.children,
      familyPlan: familyPlan ?? this.familyPlan,
      marijuana: marijuana ?? this.marijuana,
      smokerCigarette: smokerCigarette ?? this.smokerCigarette,
      alcohol: alcohol ?? this.alcohol,
      diet: diet ?? this.diet,
      politics: politics ?? this.politics,
      satisfaction: satisfaction ?? this.satisfaction,
      features: features ?? this.features,
      physicalFeatures: physicalFeatures ?? this.physicalFeatures,
      cheating: cheating ?? this.cheating,
      happiest: happiest ?? this.happiest,
      howOftenWorkout: howOftenWorkout ?? this.howOftenWorkout,
      vacations: vacations ?? this.vacations,
      mostInterestedInPerson: mostInterestedInPerson ?? this.mostInterestedInPerson,
      dress: dress ?? this.dress,
      importantIsSex: importantIsSex ?? this.importantIsSex,
      marriage: marriage ?? this.marriage,
      likeToDo: likeToDo ?? this.likeToDo,
      eatingBehaviors: eatingBehaviors ?? this.eatingBehaviors,
      reasonsRelationship: reasonsRelationship ?? this.reasonsRelationship,
      datingIntentions: datingIntentions ?? this.datingIntentions,
      relationshipType: relationshipType ?? this.relationshipType,
      sportsHobbies: sportsHobbies ?? this.sportsHobbies,
      musicHobbies: musicHobbies ?? this.musicHobbies,
      interestHobbies: interestHobbies ?? this.interestHobbies,
      fetishes: fetishes ?? this.fetishes,
      requestStatus: requestStatus ?? this.requestStatus
    );
  }

  @override
  List<Object?> get props => [
    zodiac,
    religion,
    ethnicity,
    education,
    height,
    bodyType,
    children,
    familyPlan,
    marijuana,
    smokerCigarette,
    alcohol,
    diet,
    politics,
    satisfaction,
    features,
    physicalFeatures,
    cheating,
    happiest,
    howOftenWorkout,
    vacations,
    mostInterestedInPerson,
    dress,
    importantIsSex,
    marriage,
    likeToDo,
    eatingBehaviors,
    reasonsRelationship,
    datingIntentions,
    relationshipType,
    sportsHobbies,
    musicHobbies,
    interestHobbies,
    fetishes,
    requestStatus
  ];
}
