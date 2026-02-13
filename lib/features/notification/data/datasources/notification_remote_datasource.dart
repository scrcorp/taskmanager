import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/notification_model.dart';

class NotificationRemoteDatasource {
  final DioClient _client;

  NotificationRemoteDatasource({required DioClient client}) : _client = client;

  Future<({int unreadCount, List<NotificationModel> notifications})>
      getNotifications() async {
    try {
      final response = await _client.get(ApiEndpoints.notifications);
      final data = response.data as Map<String, dynamic>;
      return (
        unreadCount: data['unread_count'] as int? ?? 0,
        notifications: (data['notifications'] as List)
            .map((e) =>
                NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _client.patch(ApiEndpoints.markNotificationRead(id));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _client.patch(ApiEndpoints.markAllNotificationsRead);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
