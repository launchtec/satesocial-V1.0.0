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

  Future<void> init(String userId) async {
    getChats(userId);
  }

  Future<void> getChats(String userId) async {
    List<Chat> chats = await _getChatsCase.call(userId);
    emit(GetChatsState(isLoading: false, chats: chats));
  }
}
