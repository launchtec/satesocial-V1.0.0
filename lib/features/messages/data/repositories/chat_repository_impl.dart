import 'package:sate_social/features/auth/data/models/app_user.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/data/models/message.dart';
import 'package:sate_social/features/messages/domain/repositories/chat_repository.dart';

import '../../../../core/data/data_sources/firestore_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirestoreDataSource firestoreDataSource;

  const ChatRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<void> addChat({required Chat chat}) async {
    return await firestoreDataSource.addChat(chat);
  }

  @override
  Future<void> addMessage({required String chatId, required Message message}) async {
    return await firestoreDataSource.addMessage(chatId, message);
  }

  @override
  Future<List<Chat>> getChats({required String userId}) async {
    final chatsSnapshot = await firestoreDataSource.getChats(userId);
    final listChats = Future.wait(chatsSnapshot.docs.map((doc) async {
      final sender = await firestoreDataSource.getUserInfo(doc.get("senderId"));
      final receiver =
          await firestoreDataSource.getUserInfo(doc.get("receiverId"));
      return Chat(
          id: doc.get("id"),
          name: doc.get("name"),
          senderId: doc.get("senderId"),
          sender: AppUser.fromSnapshot(sender),
          receiver: AppUser.fromSnapshot(receiver),
          receiverId: doc.get("receiverId"),
          postInfo: doc.get("postInfo") != null ? PostInfo.fromMap(doc.get("postInfo")) : null,
          connectId: doc.get("connectId"));
    }).toList());
    return listChats;
  }

  @override
  Stream<Iterable<Chat>> getStreamChats({required String userId}) {
    return firestoreDataSource
        .getStreamChats(userId)
        .map((snapshot) => snapshot.docs.map((doc) {
              return Chat(
                  id: doc.get("id"),
                  name: doc.get("name"),
                  senderId: doc.get("senderId"),
                  receiverId: doc.get("receiverId"),
                  postInfo: doc.data().toString().contains('postInfo') ? PostInfo.fromMap(doc.get("postInfo")) : null,
                  connectId: doc.get("connectId"));
            }));
  }

  @override
  Stream<Iterable<Message>> getStreamMessages({required String chatId}) {
    return firestoreDataSource
        .getStreamMessages(chatId)
        .map((snapshot) => snapshot.docs.map((doc) {
      return Message(
          id: doc.get("id"),
          text: doc.get("text"),
          senderId: doc.get("senderId"),
          created: doc.get("created"),
      );
    }));
  }
}
