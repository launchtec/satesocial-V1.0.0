import 'package:bloc/bloc.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_chat_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_chat/get_chat_state.dart';

class GetChatCubit extends Cubit<GetChatState> {
  final GetChatCase _getChatCase;

  GetChatCubit({
    required GetChatCase getChatCase,
  })  : _getChatCase = getChatCase,
        super(const GetChatState());

  Future<void> getChat(String chatId) async {
    Chat chat = await _getChatCase.call(chatId);
    emit(GetChatState(isLoading: false, chat: chat));
  }
}
