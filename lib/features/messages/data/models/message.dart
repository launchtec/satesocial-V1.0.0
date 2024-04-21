import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String text;
  final String created;

  const Message({
    required this.id,
    required this.text,
    required this.created
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'created': created
    };
  }

  @override
  List<Object?> get props => [id, text, created];
}