import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';

class GetPostCase {
  final PostRepository postRepository;

  GetPostCase({required this.postRepository});

  Future<PostModel> call(String postId) {
    return postRepository.getPost(postId);
  }
}