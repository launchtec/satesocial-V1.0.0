import 'package:sate_social/features/community/domain/repositories/post_repository.dart';

class UploadDocUseCase {
  final PostRepository postRepository;

  UploadDocUseCase({required this.postRepository});

  Future<String?> call(String filePath, String fileName, String userId) {
    return postRepository.uploadDoc(
        filePath,
        fileName,
        userId
    );
  }
}