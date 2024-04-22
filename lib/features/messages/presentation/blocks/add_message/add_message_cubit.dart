import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/messages/data/models/message.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_message_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_message/add_message_state.dart';
import 'package:uuid/uuid.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  final AddMessageCase _addMessageCase;

  AddMessageCubit({
    required AddMessageCase addMessageCase,
  })  : _addMessageCase = addMessageCase,
        super(const AddMessageState());

  Future<void> addMessage(String chatId, String text) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _addMessageCase(chatId, Message(
          id: const Uuid().v4(),
          text: text,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          created: DateTime.now().toIso8601String())
      );
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
