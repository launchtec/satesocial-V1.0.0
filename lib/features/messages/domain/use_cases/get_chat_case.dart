import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';

class GetChatCase {
  final ChatRepository chatRepository;

  GetChatCase({required this.chatRepository});

  Future<Chat> call(String chatId) {
    return chatRepository.getChat(chatId: chatId);
  }
}