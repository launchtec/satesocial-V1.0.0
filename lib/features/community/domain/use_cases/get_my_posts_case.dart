import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';

class GetMyPostsCase {
  final PostRepository postRepository;

  GetMyPostsCase({required this.postRepository});

  Stream<Iterable<PostModel>> call(String userId) {
    return postRepository.getMyStreamPosts(userId);
  }
}