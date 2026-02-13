import '../entities/app_notification.dart';

abstract class NotificationRepository {
  Future<({int unreadCount, List<AppNotification> notifications})>
      getNotifications();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
}
