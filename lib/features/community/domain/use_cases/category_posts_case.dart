import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';

class CategoryPostsCase {
  final PostRepository postRepository;

  CategoryPostsCase({required this.postRepository});

  Future<List<PostModel>> call(String category) {
    return postRepository.getPostsCategory(category);
  }
}