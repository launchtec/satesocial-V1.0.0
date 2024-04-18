import 'package:sate_social/features/community/data/models/post_model.dart';

abstract class PostRepository {
  Future<void> addOrUpdatePost({
    required PostModel postModel
  });

  Stream<Iterable<PostModel>> getMyStreamPosts(String userId);

  Future<List<PostModel>> getPosts();

  Future<List<PostModel>> getPostsCategory(String category);

  Future<String?> uploadDoc(String filePath, String fileName, String userId);

  Future<void> deletePost({
    required String postId
  });
}
