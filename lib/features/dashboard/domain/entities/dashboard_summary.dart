class DashboardSummary {
  final AssignmentSummary assignmentSummary;
  final AttendanceStatus attendance;
  final List<RecentNotice> recentNotices;

  const DashboardSummary({
    required this.assignmentSummary,
    required this.attendance,
    required this.recentNotices,
  });
}

class AssignmentSummary {
  final int total;
  final int completed;
  final int inProgress;
  final int todo;
  final double completionRate;

  const AssignmentSummary({
    required this.total,
    required this.completed,
    required this.inProgress,
    required this.todo,
    required this.completionRate,
  });
}

class AttendanceStatus {
  final String status;
  final DateTime? clockIn;

  const AttendanceStatus({required this.status, this.clockIn});
}

class RecentNotice {
  final String id;
  final String title;
  final DateTime createdAt;

  const RecentNotice({
    required this.id,
    required this.title,
    required this.createdAt,
  });
}
