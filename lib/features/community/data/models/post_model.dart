import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String category;
  final String group;
  final String zipCode;
  final String created;

  const PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.category,
    required this.group,
    required this.zipCode,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'category': category,
      'group': group,
      'zipCode': zipCode,
      'created': created,
    };
  }

  @override
  List<Object?> get props => [id, userId, title, content, category, group, zipCode, created];
}