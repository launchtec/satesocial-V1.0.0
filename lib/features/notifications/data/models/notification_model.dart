import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final String created;
  final String location;
  bool isOpen;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.created,
    required this.location,
    this.isOpen = false
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'created': created,
      'location': location,
      'isOpen': isOpen
    };
  }

  @override
  List<Object?> get props => [id, title, content, created, location];
}