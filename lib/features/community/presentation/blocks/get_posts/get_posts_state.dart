import 'package:equatable/equatable.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

class GetPostsState extends Equatable {
  final bool isLoading;
  final List<PostModel> postModels;

  const GetPostsState({
    this.isLoading = true,
    this.postModels = const [],
  });

  @override
  List<Object?> get props => [isLoading, postModels];
}