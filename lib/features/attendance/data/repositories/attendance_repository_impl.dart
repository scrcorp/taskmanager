import '../../domain/entities/attendance_record.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDatasource _remoteDatasource;

  AttendanceRepositoryImpl({
    required AttendanceRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<AttendanceRecord?> getToday() => _remoteDatasource.getToday();

  @override
  Future<AttendanceRecord> clockIn({String? branchId, String? location}) =>
      _remoteDatasource.clockIn(branchId: branchId, location: location);

  @override
  Future<AttendanceRecord> clockOut() => _remoteDatasource.clockOut();

  @override
  Future<Map<String, dynamic>> getHistory({int? year, int? month}) =>
      _remoteDatasource.getHistory(year: year, month: month);
}
