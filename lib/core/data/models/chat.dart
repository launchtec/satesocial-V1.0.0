import 'package:cloud_firestore/cloud_firestore.dart';

import 'message.dart';

class Chat {
  final String id;
  final Message? lastMessage;

  const Chat({
    required this.id,
    this.lastMessage
  });

  factory Chat.fromSnapshot(DocumentSnapshot snapshot) {
    return Chat(
        id: snapshot['id'],
        lastMessage: snapshot['last_message'] != null
            ? Message.fromMap(snapshot['last_message'])
            : null
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'last_message': lastMessage != null ? lastMessage!.toMap() : null,
    };
  }
}