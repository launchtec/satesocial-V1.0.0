import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String text;
  final String senderId;
  final String created;

  const Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.created
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'senderId': senderId,
      'created': created
    };
  }

  @override
  List<Object?> get props => [id, text, senderId, created];
}