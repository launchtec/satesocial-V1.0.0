import 'package:sate_social/features/community/data/models/post_model.dart';

import '../../../../core/data/data_sources/firestore_data_source.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final FirestoreDataSource firestoreDataSource;

  const PostRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<void> addOrUpdatePost({required PostModel postModel}) async {
    await firestoreDataSource.addOrUpdatePost(postModel);
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final postsSnapshot = await firestoreDataSource.getPosts();
    return postsSnapshot.docs
        .map((doc) => PostModel(
        id: doc.get("id"),
        userId: doc.get("userId"),
        title: doc.get("title"),
        content: doc.get("content"),
        category: doc.get("category"),
        group: doc.get("group"),
        zipCode: doc.get("zipCode"),
        created: doc.get("created"),
    )).toList();
  }

  @override
  Stream<Iterable<PostModel>> getStreamPosts() {
    return firestoreDataSource.getStreamPosts().map((snapshot) =>
        snapshot.docs.map((doc) => PostModel(
          id: doc.get("id"),
          userId: doc.get("userId"),
          title: doc.get("title"),
          content: doc.get("content"),
          category: doc.get("category"),
          group: doc.get("group"),
          zipCode: doc.get("zipCode"),
          created: doc.get("created"),
        )));
  }
}
