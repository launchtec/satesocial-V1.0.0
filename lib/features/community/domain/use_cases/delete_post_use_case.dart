import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository postRepository;

  DeletePostUseCase({required this.postRepository});

  Future<void> call(String postId) {
    return postRepository.deletePost(
        postId: postId
    );
  }
}