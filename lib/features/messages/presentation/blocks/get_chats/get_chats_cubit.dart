import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_chats_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chats/get_chats_state.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  final GetChatsCase _getChatsCase;

  GetChatsCubit({
    required GetChatsCase getChatsCase,
  })  : _getChatsCase = getChatsCase,
        super(const GetChatsState());

  Future<void> init(String userId, bool needPost) async {
    getChats(userId, needPost);
  }

  Future<void> getChats(String userId, bool needPost) async {
    List<Chat> chats = needPost
        ? (await _getChatsCase.call(userId))
            .where((chat) => chat.postInfo != null)
            .toList()
        : (await _getChatsCase.call(userId))
            .where((chat) => chat.connectId != null)
            .toList();
    emit(GetChatsState(isLoading: false, chats: chats));
  }
}
