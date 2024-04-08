import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';

class GetPostsCase {
  final PostRepository postRepository;

  GetPostsCase({required this.postRepository});

  Future<List<PostModel>> call() {
    return postRepository.getPosts();
  }
}