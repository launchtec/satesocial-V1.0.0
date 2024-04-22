import 'package:sate_social/features/messages/data/models/message.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';


class GetMessagesCase {
  final ChatRepository chatRepository;

  GetMessagesCase({required this.chatRepository});

  Stream<Iterable<Message>> call(String chatId) {
    return chatRepository.getStreamMessages(chatId: chatId);
  }
}