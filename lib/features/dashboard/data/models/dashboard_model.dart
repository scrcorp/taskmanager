import '../../domain/entities/dashboard_summary.dart';

class DashboardSummaryModel extends DashboardSummary {
  const DashboardSummaryModel({
    required super.assignmentSummary,
    required super.attendance,
    required super.recentNotices,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    final as_ = json['assignment_summary'] as Map<String, dynamic>? ?? {};
    final att = json['attendance'] as Map<String, dynamic>? ?? {};
    final notices = json['recent_notices'] as List<dynamic>? ?? [];

    return DashboardSummaryModel(
      assignmentSummary: AssignmentSummary(
        total: as_['total'] as int? ?? 0,
        completed: as_['completed'] as int? ?? 0,
        inProgress: as_['in_progress'] as int? ?? 0,
        todo: as_['todo'] as int? ?? 0,
        completionRate: (as_['completion_rate'] as num?)?.toDouble() ?? 0,
      ),
      attendance: AttendanceStatus(
        status: att['status'] as String? ?? 'not_started',
        clockIn: att['clock_in'] != null
            ? DateTime.parse(att['clock_in'] as String)
            : null,
      ),
      recentNotices: notices.map((e) {
        final m = e as Map<String, dynamic>;
        return RecentNotice(
          id: m['id'] as String,
          title: m['title'] as String? ?? '',
          createdAt: DateTime.parse(
            m['created_at'] as String? ?? DateTime.now().toIso8601String(),
          ),
        );
      }).toList(),
    );
  }
}
