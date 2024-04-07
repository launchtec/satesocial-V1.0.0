import 'package:equatable/equatable.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

class CategoryPostsState extends Equatable {
  final bool isLoading;
  final List<PostModel> postModels;

  const CategoryPostsState({
    this.isLoading = true,
    this.postModels = const [],
  });

  @override
  List<Object?> get props => [isLoading, postModels];
}