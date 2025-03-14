import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../repositories/notification_repository.dart';

class ReadNotificationCase {
  final NotificationRepository notificationRepository;

  ReadNotificationCase({required this.notificationRepository});

  Future<void> call(NotificationModel notificationModel) {
    return notificationRepository.addOrUpdateNotification(
      notification: notificationModel
    );
  }
}