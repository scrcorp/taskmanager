import '../entities/attendance_record.dart';

abstract class AttendanceRepository {
  Future<AttendanceRecord?> getToday();
  Future<AttendanceRecord> clockIn({String? branchId, String? location});
  Future<AttendanceRecord> clockOut();
  Future<Map<String, dynamic>> getHistory({int? year, int? month});
}
