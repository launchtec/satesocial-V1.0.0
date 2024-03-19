import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<void> addOrUpdateNotification({
    required String userId,
    required NotificationModel notification
  });

  Stream<Iterable<NotificationModel>> getStreamNotifications({
    required String userId
  });

  Future<List<NotificationModel>> getNotifications({
    required String userId
  });
}
