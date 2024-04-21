import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/community/data/models/post_model.dart';
import 'package:sate_social/features/messages/data/models/chat.dart';
import 'package:sate_social/features/messages/domain/use_cases/add_chat_case.dart';
import 'package:sate_social/features/messages/presentation/blocks/add_chat/add_chat_state.dart';
import 'package:uuid/uuid.dart';

class AddChatCubit extends Cubit<AddChatState> {
  final AddChatCase _addChatCase;

  AddChatCubit({
    required AddChatCase addChatCase,
  })  : _addChatCase = addChatCase,
        super(const AddChatState());

  Future<void> addChat(PostModel post) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _addChatCase(Chat(
          id: const Uuid().v4(),
          name: post.title,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: post.userId,
          postInfo: PostInfo(
              id: post.id,
              title: post.title,
              category: post.shortCategory(),
              created: post.created
          )
      ));
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
