class AttendanceRecord {
  final String id;
  final String companyId;
  final String userId;
  final String? branchId;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final String? location;
  final String status;
  final double? workHours;

  const AttendanceRecord({
    required this.id,
    required this.companyId,
    required this.userId,
    this.branchId,
    this.clockIn,
    this.clockOut,
    this.location,
    required this.status,
    this.workHours,
  });

  bool get isOnDuty => status == 'on_duty';
  bool get isCompleted => status == 'completed' || status == 'off_duty';
}
