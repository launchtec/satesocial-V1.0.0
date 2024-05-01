import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_chat_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat_connect/add_chat_connect_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../auth/data/models/app_user.dart';

class AddChatConnectCubit extends Cubit<AddChatConnectState> {
  final AddChatCase _addChatCase;

  AddChatConnectCubit({
    required AddChatCase addChatCase,
  })  : _addChatCase = addChatCase,
        super(const AddChatConnectState());

  Future<String> addChat(AppUser receiver) async {
    String chatId = const Uuid().v4();
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _addChatCase(Chat(
          id: chatId,
          name: receiver.name,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: receiver.id,
          connectId: const Uuid().v4()
      ));
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
      emit(state.copyWith(requestStatus: RequestStatus.initial));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
    return chatId;
  }
}
