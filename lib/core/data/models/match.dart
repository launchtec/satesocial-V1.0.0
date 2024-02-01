import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  final String id;

  const Match({required this.id});

  factory Match.fromSnapshot(DocumentSnapshot snapshot) {
    return Match(id: snapshot['id']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }
}