
import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';

class PostsCategoryCase {
  final PostRepository postRepository;

  PostsCategoryCase({required this.postRepository});

  Future<List<PostModel>> call(String category) {
    return postRepository.getPostsCategory(category);
  }
}