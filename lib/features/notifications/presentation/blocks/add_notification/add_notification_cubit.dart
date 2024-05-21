import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';
import 'package:sate_social/features/notifications/domain/use_cases/add_notification_case.dart';
import 'package:sate_social/features/notifications/presentation/blocks/read_notification/read_notification_state.dart';
import 'package:uuid/uuid.dart';

class AddNotificationCubit extends Cubit<ReadNotificationState> {
  final AddNotificationCase _addNotificationCase;

  AddNotificationCubit({
    required AddNotificationCase addNotificationCase,
  })  : _addNotificationCase = addNotificationCase,
        super(const ReadNotificationState());

  Future<void> addNotification(String title, String message, String recipientUserId, String chatId) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      await _addNotificationCase(NotificationModel(
          id: const Uuid().v4(),
          title: "Sate Social: $title",
          message: message,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          recipientUserId: recipientUserId,
          chatId: chatId,
          created: DateTime.now().toUtc().toIso8601String(),
      ));
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
