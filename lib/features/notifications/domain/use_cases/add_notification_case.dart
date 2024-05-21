import 'package:sate_social/features/notifications/data/models/notification_model.dart';

import '../repositories/notification_repository.dart';

class AddNotificationCase {
  final NotificationRepository notificationRepository;

  AddNotificationCase({required this.notificationRepository});

  Future<void> call(NotificationModel notificationModel) {
    return notificationRepository.addOrUpdateNotification(
        notification: notificationModel
    );
  }
}