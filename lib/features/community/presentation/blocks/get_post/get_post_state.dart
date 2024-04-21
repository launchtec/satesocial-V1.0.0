import 'package:equatable/equatable.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

class GetPostState extends Equatable {
  final bool isLoading;
  final PostModel? postModel;

  const GetPostState({
    this.isLoading = true,
    this.postModel,
  });

  @override
  List<Object?> get props => [isLoading, postModel];
}