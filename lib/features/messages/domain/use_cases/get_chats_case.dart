import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';

class GetChatsCase {
  final ChatRepository chatRepository;

  GetChatsCase({required this.chatRepository});

  Future<List<Chat>> call(String userId) {
    return chatRepository.getChats(
      userId: userId
    );
  }
}
