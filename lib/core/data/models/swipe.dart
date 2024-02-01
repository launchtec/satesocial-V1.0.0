import 'package:cloud_firestore/cloud_firestore.dart';

class Swipe {
  final String id;
  final bool liked;

  const Swipe({
    required this.id,
    required this.liked
  });

  factory Swipe.fromSnapshot(DocumentSnapshot snapshot) {
    return Swipe(
        id: snapshot['id'],
        liked: snapshot['liked']
    );
  }

  factory Swipe.fromMap(Map<String, dynamic> map) {
    return Swipe(
        id: map['id'],
        liked: map['liked']
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'liked': liked};
  }
}