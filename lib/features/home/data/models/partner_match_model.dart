class PartnerMatchModel {
  final String id;
  final List<String> religions;
  final List<String> ethnicities;
  final List<String> educations;
  final String? age;
  final List<String> bodyTypes;
  final String? diet;
  final String? politics;

  const PartnerMatchModel({
      required this.id,
      required this.religions,
      required this.ethnicities,
      required this.educations,
      required this.age,
      required this.bodyTypes,
      required this.diet,
      required this.politics
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'religion': religions,
      'ethnicity': ethnicities,
      'education': educations,
      'age': age,
      'bodyTypes': bodyTypes,
      'diet': diet,
      'politics': politics,
    };
  }
}