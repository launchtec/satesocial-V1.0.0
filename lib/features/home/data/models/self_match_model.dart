class SelfMatchModel {
  final String id;
  final String zodiac;
  final String religion;
  final String ethnicity;
  final String education;
  final String height;
  final String bodyType;
  final String children;
  final String familyPlan;
  final String marijuana;
  final String smokerCigarette;
  final String alcohol;
  final String diet;
  final String politics;
  final String satisfaction;
  final List<String> features;
  final List<String> physicalFeatures;
  final String cheating;
  final List<String> happiest;
  final String howOftenWorkout;
  final List<String> vacations;
  final List<String> mostInterestedInPerson;
  final List<String> dress;
  final String importantIsSex;
  final String marriage;
  final List<String> likeToDo;
  final List<String> eatingBehaviors;
  final List<String> reasonsRelationship;
  final List<String> datingIntentions;
  final List<String> relationshipType;
  final List<String> sportsHobbies;
  final List<String> musicHobbies;
  final List<String> interestHobbies;
  final List<String> fetishes;

  const SelfMatchModel({
      required this.id,
      required this.zodiac,
      required this.religion,
      required this.ethnicity,
      required this.education,
      required this.height,
      required this.bodyType,
      required this.children,
      required this.familyPlan,
      required this.marijuana,
      required this.smokerCigarette,
      required this.alcohol,
      required this.diet,
      required this.politics,
      required this.satisfaction,
      required this.features,
      required this.physicalFeatures,
      required this.cheating,
      required this.happiest,
      required this.howOftenWorkout,
      required this.vacations,
      required this.mostInterestedInPerson,
      required this.dress,
      required this.importantIsSex,
      required this.marriage,
      required this.likeToDo,
      required this.eatingBehaviors,
      required this.reasonsRelationship,
      required this.datingIntentions,
      required this.relationshipType,
      required this.sportsHobbies,
      required this.musicHobbies,
      required this.interestHobbies,
      required this.fetishes});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'zodiac': zodiac,
      'religion': religion,
      'ethnicity': ethnicity,
      'education': education,
      'height': height,
      'bodyType': bodyType,
      'children': children,
      'familyPlan': familyPlan,
      'marijuana': marijuana,
      'smokerCigarette': smokerCigarette,
      'diet': diet,
      'politics': politics,
      'satisfaction': satisfaction,
      'features': features,
      'physicalFeatures': physicalFeatures,
      'cheating': cheating,
      'happiest': happiest,
      'howOftenWorkout': howOftenWorkout,
      'vacations': vacations,
      'mostInterestedInPerson': mostInterestedInPerson,
      'dress': dress,
      'importantIsSex': importantIsSex,
      'marriage': marriage,
      'likeToDo': likeToDo,
      'eatingBehaviors': eatingBehaviors,
      'reasonsRelationship': reasonsRelationship,
      'datingIntentions': datingIntentions,
      'relationshipType': relationshipType,
      'sportsHobbies': sportsHobbies,
      'musicHobbies': musicHobbies,
      'interestHobbies': interestHobbies,
      'fetishes': fetishes
    };
  }
}
