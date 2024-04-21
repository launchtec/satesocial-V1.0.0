
import 'package:sate_social/features/messages/data/models/chat.dart';

abstract class ChatRepository {
  Future<void> addChat({
    required Chat chat
  });

  Stream<Iterable<Chat>> getStreamChats({
    required String userId
  });

  Future<List<Chat>> getChats({
    required String userId
  });
}
