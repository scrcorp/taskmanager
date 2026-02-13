import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource _remoteDatasource;

  NotificationRepositoryImpl({
    required NotificationRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<({int unreadCount, List<AppNotification> notifications})>
      getNotifications() async {
    final result = await _remoteDatasource.getNotifications();
    return (
      unreadCount: result.unreadCount,
      notifications: result.notifications,
    );
  }

  @override
  Future<void> markAsRead(String id) => _remoteDatasource.markAsRead(id);

  @override
  Future<void> markAllAsRead() => _remoteDatasource.markAllAsRead();
}
