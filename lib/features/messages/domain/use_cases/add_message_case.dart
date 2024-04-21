import 'package:sate_social/features/messages/data/models/message.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';

class AddMessageCase {
  final ChatRepository chatRepository;

  AddMessageCase({required this.chatRepository});

  Future<void> call(String chatId, Message message) {
    return chatRepository.addMessage(chatId: chatId, message: message);
  }
}
