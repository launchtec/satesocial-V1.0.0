import 'package:sate_social/core/data/data_sources/storage_data_source.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';

import '../../../../core/data/data_sources/firestore_data_source.dart';
import '../../../../core/data/data_sources/response.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final FirestoreDataSource firestoreDataSource;
  final StorageDataSource storageDataSource;

  const PostRepositoryImpl(
      {required this.firestoreDataSource, required this.storageDataSource});

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
            isConfirmed: doc.get("isConfirmed") as bool,
            rate: doc.data().toString().contains('rate') ? doc.get('rate') : '',
            employmentType: doc.data().toString().contains('employmentType')
                ? doc.get('employmentType')
                : '',
            urlDoc: doc.data().toString().contains('urlDoc')
                ? doc.get('urlDoc')
                : ''))
        .toList();
  }

  @override
  Future<List<PostModel>> getPostsCategory(String category) async {
    final postsSnapshot = await firestoreDataSource.getPostsCategory(category);
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
            isConfirmed: doc.get("isConfirmed") as bool,
            rate: doc.data().toString().contains('rate') ? doc.get('rate') : '',
            employmentType: doc.data().toString().contains('employmentType')
                ? doc.get('employmentType')
                : '',
            urlDoc: doc.data().toString().contains('urlDoc')
                ? doc.get('urlDoc')
                : ''))
        .toList();
  }

  @override
  Stream<Iterable<PostModel>> getMyStreamPosts(String userId) {
    return firestoreDataSource.getExistingUserPosts(userId).map((snapshot) =>
        snapshot.docs.map((doc) => PostModel(
            id: doc.get("id"),
            userId: doc.get("userId"),
            title: doc.get("title"),
            content: doc.get("content"),
            category: doc.get("category"),
            group: doc.get("group"),
            zipCode: doc.get("zipCode"),
            created: doc.get("created"),
            isConfirmed: doc.get("isConfirmed") as bool,
            rate: doc.data().toString().contains('rate') ? doc.get('rate') : '',
            employmentType: doc.data().toString().contains('employmentType')
                ? doc.get('employmentType')
                : '',
            urlDoc: doc.data().toString().contains('urlDoc')
                ? doc.get('urlDoc')
                : '')));
  }

  @override
  Future<String?> uploadDoc(
      String filePath, String fileName, String userId) async {
    Response<String> response = await storageDataSource.uploadUserGigDocument(
        filePath, fileName, userId);
    if (response is Success<String>) {
      return response.value;
    } else {
      return null;
    }
  }

  @override
  Future<void> deletePost({required String postId}) async {
    await firestoreDataSource.deletePost(postId);
  }
}
