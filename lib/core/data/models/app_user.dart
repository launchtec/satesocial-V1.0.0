import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String sexuality;
  final String openToConnectTo;
  final bool confirmRealPerson;
  final String? height;
  final String? ethnicity;
  final String? howDidYouKnowAboutUs;
  final String? avatarUrl;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.sexuality,
    required this.openToConnectTo,
    required this.confirmRealPerson,
    this.height,
    this.ethnicity,
    this.howDidYouKnowAboutUs,
    this.avatarUrl,
  });

  factory AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    return AppUser(
        id: snapshot['id'],
        name: snapshot['name'],
        email: snapshot['email'],
        age: snapshot['age'],
        gender: snapshot['gender'],
        sexuality: snapshot['sexuality'],
        openToConnectTo: snapshot['openToConnectTo'],
        confirmRealPerson: snapshot['confirmRealPerson'],
        height: snapshot['height'],
        ethnicity: snapshot['ethnicity'],
        howDidYouKnowAboutUs: snapshot['howDidYouKnowAboutUs'],
        avatarUrl: snapshot['avatarUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'sexuality': sexuality,
      'openToConnectTo': openToConnectTo,
      'confirmRealPerson': confirmRealPerson,
      'height': height,
      'ethnicity': ethnicity,
      'howDidYouKnowAboutUs': howDidYouKnowAboutUs,
      'avatarUrl': avatarUrl,
    };
  }
}