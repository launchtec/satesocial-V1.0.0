import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final int epochTimeMs;
  final bool seen;
  final String senderId;
  final String text;

  const Message({
    required this.epochTimeMs,
    required this.seen,
    required this.senderId,
    required this.text
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        epochTimeMs: map['epoch_time_ms'],
        seen: map['seen'],
        senderId: map['sender_id'],
        text: map['text']
    );
  }

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
        epochTimeMs: snapshot['epoch_time_ms'],
        seen: snapshot['seen'],
        senderId: snapshot['sender_id'],
        text: snapshot['text']
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'epoch_time_ms': epochTimeMs,
      'seen': seen,
      'sender_id': senderId,
      'text': text
    };
  }
}