import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';

class AddChatCase {
  final ChatRepository chatRepository;

  AddChatCase({required this.chatRepository});

  Future<void> call(Chat chat) {
    return chatRepository.addChat(chat: chat);
  }
}
