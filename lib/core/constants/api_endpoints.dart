class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';
  static const String me = '/auth/me';
  static const String sendVerification = '/auth/send-verification';
  static const String verifyEmail = '/auth/verify-email';

  // Assignments
  static const String assignments = '/assignments';
  static const String myAssignments = '/assignments/my';
  static String assignmentById(String id) => '/assignments/$id';
  static String assignmentStatus(String id) => '/assignments/$id/status';
  static String assignmentAssignees(String id) => '/assignments/$id/assignees';
  static String removeAssignee(String assignmentId, String userId) => '/assignments/$assignmentId/assignees/$userId';
  static String assignmentComments(String id) => '/assignments/$id/comments';
  static String deleteComment(String assignmentId, String commentId) => '/assignments/$assignmentId/comments/$commentId';

  // Daily Checklists
  static const String dailyChecklists = '/daily-checklists';
  static String checklistById(String id) => '/daily-checklists/$id';
  static const String generateChecklist = '/daily-checklists/generate';
  static String updateChecklistItem(String checklistId, int itemIndex) => '/daily-checklists/$checklistId/items/$itemIndex';

  // Notices
  static const String notices = '/notices';
  static String noticeById(String id) => '/notices/$id';
  static String confirmNotice(String id) => '/notices/$id/confirm';

  // Users
  static const String userProfile = '/users/me/profile';
  static const String changePassword = '/users/me/password';

  // Dashboard
  static const String dashboardSummary = '/dashboard/summary';

  // Attendance
  static const String attendanceToday = '/attendance/today';
  static const String clockIn = '/attendance/clock-in';
  static const String clockOut = '/attendance/clock-out';
  static const String attendanceHistory = '/attendance/history';

  // Opinions
  static const String opinions = '/opinions';

  // Notifications
  static const String notifications = '/notifications';
  static String markNotificationRead(String id) => '/notifications/$id/read';
  static const String markAllNotificationsRead = '/notifications/read-all';

  // Files
  static const String fileUpload = '/files/upload';
  static const String presignedUrl = '/files/presigned-url';
  static const String fileDelete = '/files/delete';
}
