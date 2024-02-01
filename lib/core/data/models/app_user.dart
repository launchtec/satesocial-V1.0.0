import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  final int age;
  final String profilePhotoPath;
  final String bio;

  const AppUser({
    required this.id,
    required this.name,
    required this.age,
    required this.profilePhotoPath,
    required this.bio
  });

  factory AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    return AppUser(
        id: snapshot['id'],
        name: snapshot['name'],
        age: snapshot['age'],
        profilePhotoPath: snapshot['profile_photo_path'],
        bio: snapshot.get('bio') ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'profile_photo_path': profilePhotoPath,
      'bio': bio
    };
  }
}