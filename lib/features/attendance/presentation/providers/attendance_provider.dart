import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/mock/mock_repositories.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/attendance_remote_datasource.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../domain/entities/attendance_record.dart';
import '../../domain/repositories/attendance_repository.dart';

final attendanceRemoteDatasourceProvider =
    Provider<AttendanceRemoteDatasource>((ref) {
  return AttendanceRemoteDatasource(client: ref.watch(dioClientProvider));
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  if (AppConfig.useMockData) return MockAttendanceRepository();
  return AttendanceRepositoryImpl(
    remoteDatasource: ref.watch(attendanceRemoteDatasourceProvider),
  );
});

final todayAttendanceProvider =
    FutureProvider.autoDispose<AttendanceRecord?>((ref) async {
  return ref.watch(attendanceRepositoryProvider).getToday();
});

final attendanceHistoryProvider =
    FutureProvider.autoDispose.family<Map<String, dynamic>, ({int? year, int? month})>((ref, params) async {
  return ref.watch(attendanceRepositoryProvider).getHistory(year: params.year, month: params.month);
});
