import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/mock/mock_repositories.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';

final notificationRemoteDatasourceProvider =
    Provider<NotificationRemoteDatasource>((ref) {
  return NotificationRemoteDatasource(client: ref.watch(dioClientProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  if (AppConfig.useMockData) return MockNotificationRepository();
  return NotificationRepositoryImpl(
    remoteDatasource: ref.watch(notificationRemoteDatasourceProvider),
  );
});

final notificationsProvider = FutureProvider.autoDispose<
    ({int unreadCount, List<AppNotification> notifications})>((ref) async {
  return ref.watch(notificationRepositoryProvider).getNotifications();
});
