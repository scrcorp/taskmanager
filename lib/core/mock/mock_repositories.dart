import 'mock_data.dart';
import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/models/login_request.dart';
import '../../features/auth/data/models/signup_request.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/entities/dashboard_summary.dart';
import '../../features/assignment/domain/repositories/assignment_repository.dart';
import '../../features/assignment/domain/entities/assignment.dart';
import '../../features/notice/domain/repositories/notice_repository.dart';
import '../../features/notice/domain/entities/notice.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/domain/entities/app_notification.dart';
import '../../features/attendance/domain/repositories/attendance_repository.dart';
import '../../features/attendance/domain/entities/attendance_record.dart';
import '../../features/opinion/domain/repositories/opinion_repository.dart';
import '../../features/opinion/domain/entities/opinion.dart';
import '../../features/checklist/domain/repositories/checklist_repository.dart';
import '../../features/checklist/domain/entities/daily_checklist.dart';
import '../../features/user/domain/repositories/user_repository.dart';
import '../../features/file/domain/repositories/file_repository.dart';

// ─── Auth ─────────────────────────────────────────────

class MockAuthRepository implements AuthRepository {
  @override
  Future<User> login(LoginRequest request) async => MockData.currentUser;

  @override
  Future<User> signup(SignupRequest request) async => MockData.currentUser;

  @override
  Future<void> logout() async {}

  @override
  Future<User> getCurrentUser() async => MockData.currentUser;

  @override
  Future<void> sendVerification(String email) async {}

  @override
  Future<void> verifyEmail(String email, String code) async {}

  @override
  Future<bool> isAuthenticated() async => true;
}

// ─── Dashboard ────────────────────────────────────────

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardSummary> getSummary() async => MockData.dashboardSummary;
}

// ─── Assignment ───────────────────────────────────────

class MockAssignmentRepository implements AssignmentRepository {
  @override
  Future<List<Assignment>> getAssignments({String? status, String? branchId}) async {
    if (status != null) {
      return MockData.assignments.where((a) => a.status == status).toList();
    }
    return MockData.assignments;
  }

  @override
  Future<List<Assignment>> getMyAssignments() async => MockData.assignments;

  @override
  Future<Assignment> getAssignment(String id) async {
    return MockData.assignments.firstWhere(
      (a) => a.id == id,
      orElse: () => MockData.assignments.first,
    );
  }

  @override
  Future<Assignment> createAssignment(Map<String, dynamic> data) async =>
      MockData.assignments.first;

  @override
  Future<Assignment> updateAssignment(String id, Map<String, dynamic> data) async {
    return MockData.assignments.firstWhere(
      (a) => a.id == id,
      orElse: () => MockData.assignments.first,
    );
  }

  @override
  Future<void> deleteAssignment(String id) async {}

  @override
  Future<Assignment> updateStatus(String id, String status) async {
    return MockData.assignments.firstWhere(
      (a) => a.id == id,
      orElse: () => MockData.assignments.first,
    );
  }

  @override
  Future<List<Comment>> getComments(String assignmentId) async {
    return MockData.comments[assignmentId] ?? [];
  }

  @override
  Future<Comment> createComment(String assignmentId, Map<String, dynamic> data) async {
    return Comment(
      id: 'mock-new-comment-${DateTime.now().millisecondsSinceEpoch}',
      assignmentId: assignmentId,
      userId: MockData.currentUser.id,
      userName: MockData.currentUser.fullName,
      isManager: MockData.currentUser.isManager,
      content: data['content'] as String?,
      contentType: data['content_type'] as String? ?? 'text',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> deleteComment(String assignmentId, String commentId) async {}

  @override
  Future<Map<String, dynamic>> addAssignees(String assignmentId, List<String> userIds) async {
    return {'success': true};
  }

  @override
  Future<void> removeAssignee(String assignmentId, String userId) async {}
}

// ─── Notice ───────────────────────────────────────────

class MockNoticeRepository implements NoticeRepository {
  @override
  Future<List<Notice>> getNotices({int? limit}) async {
    if (limit != null) return MockData.notices.take(limit).toList();
    return MockData.notices;
  }

  @override
  Future<Notice> getNotice(String id) async {
    return MockData.notices.firstWhere(
      (n) => n.id == id,
      orElse: () => MockData.notices.first,
    );
  }

  @override
  Future<void> confirmNotice(String id) async {}

  @override
  Future<Notice> createNotice(Map<String, dynamic> data) async =>
      MockData.notices.first;

  @override
  Future<Notice> updateNotice(String id, Map<String, dynamic> data) async {
    return MockData.notices.firstWhere(
      (n) => n.id == id,
      orElse: () => MockData.notices.first,
    );
  }

  @override
  Future<void> deleteNotice(String id) async {}
}

// ─── Notification ─────────────────────────────────────

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<({int unreadCount, List<AppNotification> notifications})> getNotifications() async {
    final unread = MockData.notifications.where((n) => !n.isRead).length;
    return (unreadCount: unread, notifications: MockData.notifications);
  }

  @override
  Future<void> markAsRead(String id) async {}

  @override
  Future<void> markAllAsRead() async {}
}

// ─── Attendance ───────────────────────────────────────

class MockAttendanceRepository implements AttendanceRepository {
  @override
  Future<AttendanceRecord?> getToday() async => MockData.todayAttendance;

  @override
  Future<AttendanceRecord> clockIn({String? branchId, String? location}) async {
    return MockData.todayAttendance;
  }

  @override
  Future<AttendanceRecord> clockOut() async {
    return AttendanceRecord(
      id: MockData.todayAttendance.id,
      companyId: MockData.todayAttendance.companyId,
      userId: MockData.todayAttendance.userId,
      clockIn: MockData.todayAttendance.clockIn,
      clockOut: DateTime.now(),
      status: 'completed',
      workHours: 8.5,
    );
  }

  @override
  Future<Map<String, dynamic>> getHistory({int? year, int? month}) async {
    return MockData.attendanceHistory;
  }
}

// ─── Opinion ──────────────────────────────────────────

class MockOpinionRepository implements OpinionRepository {
  @override
  Future<List<Opinion>> getOpinions() async => MockData.opinions;

  @override
  Future<Opinion> createOpinion(String content) async {
    return Opinion(
      id: 'mock-new-opinion-${DateTime.now().millisecondsSinceEpoch}',
      companyId: 'mock-company-1',
      userId: MockData.currentUser.id,
      content: content,
      status: 'submitted',
      createdAt: DateTime.now(),
    );
  }
}

// ─── Checklist ────────────────────────────────────────

class MockChecklistRepository implements ChecklistRepository {
  @override
  Future<List<DailyChecklist>> getChecklists(String branchId, String date) async {
    return MockData.checklists;
  }

  @override
  Future<DailyChecklist> getChecklist(String id) async {
    return MockData.checklists.firstWhere(
      (c) => c.id == id,
      orElse: () => MockData.checklists.first,
    );
  }

  @override
  Future<DailyChecklist> updateItem(
    String checklistId,
    int itemIndex,
    bool isCompleted, {
    String? verificationData,
  }) async {
    return MockData.checklists.firstWhere(
      (c) => c.id == checklistId,
      orElse: () => MockData.checklists.first,
    );
  }

  @override
  Future<DailyChecklist> generate({
    required String templateId,
    required String branchId,
    required String date,
    List<String>? groupIds,
  }) async {
    return MockData.checklists.first;
  }
}

// ─── User ─────────────────────────────────────────────

class MockUserRepository implements UserRepository {
  @override
  Future<User> getProfile() async => MockData.currentUser;

  @override
  Future<User> updateProfile(Map<String, dynamic> data) async =>
      MockData.currentUser;

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {}
}

// ─── File ─────────────────────────────────────────────

class MockFileRepository implements FileRepository {
  @override
  Future<Map<String, dynamic>> uploadFile(String filePath, {String folder = 'uploads'}) async {
    return {
      'file_path': 'mock/uploaded_file.jpg',
      'url': 'https://example.com/mock/uploaded_file.jpg',
    };
  }

  @override
  Future<String> getPresignedUrl(String filePath) async {
    return 'https://example.com/mock/presigned/$filePath';
  }

  @override
  Future<void> deleteFile(String filePath) async {}
}
