import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sate_social/features/messages/data/models/message.dart';
import 'package:sate_social/features/messages/domain/use_cases/get_messages_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/get_messages/get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  StreamSubscription? _myMessagesSubscription;
  final GetMessagesCase _getMessagesCase;

  GetMessagesCubit({
    required GetMessagesCase getMessagesCase,
  })  : _getMessagesCase = getMessagesCase,
        super(const GetMessagesState());

  Future<void> init(String chatId) async {
    _myMessagesSubscription =
        _getMessagesCase.call(chatId).listen(myMessagesListen);
  }

  void myMessagesListen(
      Iterable<Message> messages) async {
    emit(GetMessagesState(
      isLoading: false,
      messages: messages,
    ));
  }

  @override
  Future<void> close() {
    _myMessagesSubscription?.cancel();
    return super.close();
  }
}
