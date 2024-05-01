import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String message;
  final String senderId;
  final String recipientUserId;
  final String created;
  bool isOpen;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.senderId,
    required this.recipientUserId,
    required this.created,
    this.isOpen = false
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'senderId': senderId,
      'recipientUserId': recipientUserId,
      'created': created,
      'isOpen': isOpen
    };
  }

  @override
  List<Object?> get props => [id, title, message, senderId, recipientUserId, created, isOpen];
}