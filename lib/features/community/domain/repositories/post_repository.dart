import 'package:sate_social/features/community/data/models/post_model.dart';

abstract class PostRepository {
  Future<void> addOrUpdatePost({
    required PostModel postModel
  });

  Stream<Iterable<PostModel>> getStreamPosts();

  Future<List<PostModel>> getPosts();

  Future<String?> uploadDoc(String filePath, String fileName, String userId);
}
