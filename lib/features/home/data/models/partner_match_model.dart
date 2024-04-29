class PartnerMatchModel {
  final String id;
  final String userId;
  final String userName;
  final String religion;
  final String ethnicity;
  final String education;
  final String age;
  final List<String> bodyTypes;
  final String diet;
  final String politics;

  const PartnerMatchModel({
      required this.id,
      required this.userId,
      required this.userName,
      required this.religion,
      required this.ethnicity,
      required this.education,
      required this.age,
      required this.bodyTypes,
      required this.diet,
      required this.politics
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'userName': userName,
      'religion': religion,
      'ethnicity': ethnicity,
      'education': education,
      'age': age,
      'bodyTypes': bodyTypes,
      'diet': diet,
      'politics': politics,
    };
  }
}