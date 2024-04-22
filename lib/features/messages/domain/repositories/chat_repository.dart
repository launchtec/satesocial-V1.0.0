
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/data/models/message.dart';

abstract class ChatRepository {
  Future<void> addChat({
    required Chat chat
  });

  Future<void> addMessage({
    required String chatId,
    required Message message
  });

  Stream<Iterable<Chat>> getStreamChats({
    required String userId
  });

  Stream<Iterable<Message>> getStreamMessages({
    required String chatId
  });

  Future<List<Chat>> getChats({
    required String userId
  });
}
