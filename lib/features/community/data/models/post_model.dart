import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final String category;
  final String group;
  final String zip;
  final String created;
  final String location;

  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.group,
    required this.zip,
    required this.created,
    required this.location,
  });

  @override
  List<Object?> get props => [id, title, content, category, group, zip, created, location];
}