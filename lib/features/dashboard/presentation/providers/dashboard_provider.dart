import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/mock/mock_repositories.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_summary.dart';
import '../../domain/repositories/dashboard_repository.dart';

final dashboardRemoteDatasourceProvider =
    Provider<DashboardRemoteDatasource>((ref) {
  return DashboardRemoteDatasource(client: ref.watch(dioClientProvider));
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  if (AppConfig.useMockData) return MockDashboardRepository();
  return DashboardRepositoryImpl(
    remoteDatasource: ref.watch(dashboardRemoteDatasourceProvider),
  );
});

final dashboardProvider =
    FutureProvider.autoDispose<DashboardSummary>((ref) async {
  return ref.watch(dashboardRepositoryProvider).getSummary();
});
