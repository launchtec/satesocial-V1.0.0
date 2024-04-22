import 'package:equatable/equatable.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

class GetMyPostsState extends Equatable {
  final bool isLoading;
  final Iterable<PostModel> postModels;

  const GetMyPostsState({
    this.isLoading = true,
    this.postModels = const [],
  });

  @override
  List<Object?> get props => [isLoading, postModels];
}