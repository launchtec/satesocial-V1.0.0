import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sate_social/features/notifications/data/models/notification_model.dart';
import 'package:sate_social/features/notifications/presentation/blocks/get_notifications/notifications_state.dart';

import '../../../domain/use_cases/get_notifications_case.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  StreamSubscription? _myNotificationsSubscription;
  final GetNotificationsCase _notificationsUseCase;

  NotificationsCubit({
    required GetNotificationsCase notificationsUseCase,
  })  : _notificationsUseCase = notificationsUseCase,
        super(const NotificationsState());

  Future<void> init() async {
    // Subscribe to listen for changes in the myUser list
    _myNotificationsSubscription =
        _notificationsUseCase.call(FirebaseAuth.instance.currentUser!.uid).listen(myNotificationsListen);
  }

  // Every time the myUser list is updated, this function will be called
  // with the latest data
  void myNotificationsListen(
      Iterable<NotificationModel> notificationModels) async {
    emit(NotificationsState(
      isLoading: false,
      notificationModels: notificationModels,
    ));
  }

  @override
  Future<void> close() {
    _myNotificationsSubscription?.cancel();
    return super.close();
  }
}
