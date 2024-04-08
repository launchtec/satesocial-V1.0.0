import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/core/data/blocks/request_status.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';
import 'package:sate_social/features/notifications/domain/use_cases/read_notification_case.dart';
import 'package:sate_social/features/notifications/presentation/blocks/read_notification/read_notification_state.dart';

class ReadNotificationCubit extends Cubit<ReadNotificationState> {
  final ReadNotificationCase _readNotificationCase;

  ReadNotificationCubit({
    required ReadNotificationCase readNotificationCase,
  })  : _readNotificationCase = readNotificationCase,
        super(const ReadNotificationState());

  Future<void> readNotification(NotificationModel notificationModel) async {
    emit(state.copyWith(requestStatus: RequestStatus.submissionInProgress));
    try {
      notificationModel.isOpen = true;
      await _readNotificationCase(
          FirebaseAuth.instance.currentUser!.uid, notificationModel);
      emit(state.copyWith(requestStatus: RequestStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(requestStatus: RequestStatus.submissionFailure));
    }
  }
}
