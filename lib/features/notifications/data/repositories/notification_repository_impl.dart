import 'package:sate_social/features/notifications/data/models/notification_model.dart';
import 'package:sate_social/features/notifications/domain/repositories/notification_repository.dart';

import '../../../../core/data/data_sources/firestore_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirestoreDataSource firestoreDataSource;

  const NotificationRepositoryImpl({required this.firestoreDataSource});

  @override
  Future<void> addOrUpdateNotification(
      {required String userId, required NotificationModel notification}) async {
    await firestoreDataSource.addOrUpdateNotification(userId, notification);
  }

  @override
  Future<List<NotificationModel>> getNotifications(
      {required String userId}) async {
    final notificationsSnapshot =
        await firestoreDataSource.getNotifications(userId);
    return notificationsSnapshot.docs
        .map((doc) => NotificationModel(
            id: doc.get("id"),
            title: doc.get("title"),
            content: doc.get("content"),
            created: doc.get("created"),
            location: doc.get("location"),
            isOpen: doc.get("isOpen")
        ))
        .toList();
  }

  @override
  Stream<Iterable<NotificationModel>> getStreamNotifications({required String userId}) {
    return firestoreDataSource.getStreamNotifications(userId).map((snapshot) =>
        snapshot.docs.map((doc) => NotificationModel(
            id: doc.get("id"),
            title: doc.get("title"),
            content: doc.get("content"),
            created: doc.get("created"),
            location: doc.get("location"))));
  }
}
