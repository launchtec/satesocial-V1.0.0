import 'package:equatable/equatable.dart';

class PostCategory extends Equatable {
  final String name;
  final String imagePath;

  const PostCategory({
    required this.name,
    required this.imagePath
  });

  @override
  List<Object?> get props => [name, imagePath];
}