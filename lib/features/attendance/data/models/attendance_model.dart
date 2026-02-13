import '../../domain/entities/attendance_record.dart';

class AttendanceRecordModel extends AttendanceRecord {
  const AttendanceRecordModel({
    required super.id,
    required super.companyId,
    required super.userId,
    super.branchId,
    super.clockIn,
    super.clockOut,
    super.location,
    required super.status,
    super.workHours,
  });

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return AttendanceRecordModel(
      id: json['id'] as String? ?? '',
      companyId: json['company_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      branchId: json['branch_id'] as String?,
      clockIn: json['clock_in'] != null
          ? DateTime.parse(json['clock_in'] as String)
          : null,
      clockOut: json['clock_out'] != null
          ? DateTime.parse(json['clock_out'] as String)
          : null,
      location: json['location'] as String?,
      status: json['status'] as String? ?? 'not_started',
      workHours: (json['work_hours'] as num?)?.toDouble(),
    );
  }
}
