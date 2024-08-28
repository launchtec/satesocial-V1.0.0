import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String sexuality;
  final List<String> openToConnectTo;
  final bool confirmRealPerson;
  final String? height;
  final String? ethnicity;
  final String? howDidYouKnowAboutUs;
  final String? avatar;
  final String? relationship;
  final bool? activeRelationship;
  final String? userLinkInstagram;
  final bool? activeInstagram;
  final double? latitude;
  final double? longitude;
  final String? lastActivity;
  final bool? buyMatch;

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
    this.avatar,
    this.relationship,
    this.activeRelationship,
    this.userLinkInstagram,
    this.activeInstagram,
    this.latitude,
    this.longitude,
    this.lastActivity,
    this.buyMatch
  });

  factory AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    return AppUser(
      id: snapshot.get('id'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      age: snapshot.get('age') as int,
      gender: snapshot.get('gender'),
      sexuality: snapshot.get('sexuality'),
      openToConnectTo: (snapshot.get('openToConnectTo') as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      confirmRealPerson: snapshot.get('confirmRealPerson') as bool,
      height: snapshot.data().toString().contains('height')
          ? snapshot.get('height')
          : '',
      ethnicity: snapshot.data().toString().contains('ethnicity')
          ? snapshot.get('ethnicity')
          : '',
      howDidYouKnowAboutUs:
          snapshot.data().toString().contains('howDidYouKnowAboutUs')
              ? snapshot.get('howDidYouKnowAboutUs')
              : '',
      avatar: snapshot.data().toString().contains('avatarMap')
          ? snapshot.get('avatarMap')
          : '',
      longitude: snapshot.data().toString().contains('longitude')
          ? snapshot.get('longitude') as double
          : null,
      latitude: snapshot.data().toString().contains('latitude')
          ? snapshot.get('latitude') as double
          : null,
      relationship: snapshot.data().toString().contains('relationship')
          ? snapshot.get('relationship')
          : '',
      activeRelationship:
          snapshot.data().toString().contains('activeRelationship')
              ? snapshot.get('activeRelationship')
              : false,
      userLinkInstagram:
          snapshot.data().toString().contains('userLinkInstagram')
              ? snapshot.get('userLinkInstagram')
              : '',
      activeInstagram: snapshot.data().toString().contains('activeInstagram')
          ? snapshot.get('activeInstagram')
          : false,
      lastActivity: snapshot.data().toString().contains('lastActivity')
          ? snapshot.get('lastActivity')
          : null,
      buyMatch: snapshot.data().toString().contains('buyMatch')
          ? snapshot.get('buyMatch')
          : false,
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
      'avatarMap': avatar,
      'relationship': relationship,
      'activeRelationship': activeRelationship,
      'userLinkInstagram': userLinkInstagram,
      'activeInstagram': activeInstagram,
      'lastActivity': lastActivity,
      'buyMatch': buyMatch
    };
  }

  static AppUser fromMap(Map<String, dynamic> json) {
    return AppUser(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        age: json['age'],
        gender: json['gender'],
        sexuality: json['sexuality'],
        openToConnectTo: (json['openToConnectTo'] as List<dynamic>)
            .map((item) => item as String)
            .toList(),
        confirmRealPerson: json['confirmRealPerson'],
        height: json['height'],
        ethnicity: json['ethnicity'],
        howDidYouKnowAboutUs: json['howDidYouKnowAboutUs'],
        avatar: json['avatarMap']);
  }
}
