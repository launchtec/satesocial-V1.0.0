import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

class AddPostUseCase {
  final PostRepository postRepository;

  AddPostUseCase({required this.postRepository});

  Future<void> call(PostModel postModel) {
    return postRepository.addOrUpdatePost(
        postModel: postModel
    );
  }
}