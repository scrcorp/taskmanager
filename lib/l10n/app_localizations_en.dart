// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TaskManager';

  @override
  String get mypage_title => 'My Page';

  @override
  String get mypage_editProfile => 'Edit Profile';

  @override
  String get mypage_changePassword => 'Change Password';

  @override
  String get mypage_languageSettings => 'Language Settings';

  @override
  String get mypage_appInfo => 'App Info';

  @override
  String get mypage_logout => 'Logout';

  @override
  String get mypage_logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get mypage_cancel => 'Cancel';

  @override
  String get mypage_roleManager => 'Manager';

  @override
  String get mypage_roleAdmin => 'Admin';

  @override
  String get mypage_roleEmployee => 'Employee';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_tasks => 'My Tasks';

  @override
  String get nav_notices => 'Notices';

  @override
  String get notification_title => 'Notifications';

  @override
  String get notification_markAllRead => 'Mark All Read';

  @override
  String get notification_errorLoad => 'Could not load notifications';

  @override
  String get notification_empty => 'No notifications';

  @override
  String get attendance_title => 'Attendance';

  @override
  String get attendance_errorLoad => 'Could not load attendance info';

  @override
  String get attendance_clockIn => 'Clock In Time';

  @override
  String get attendance_clockOut => 'Clock Out Time';

  @override
  String get attendance_clockInSuccess => 'Clock in recorded';

  @override
  String attendance_clockInFail(String error) {
    return 'Failed to clock in: $error';
  }

  @override
  String get attendance_clockOutSuccess => 'Clock out recorded';

  @override
  String attendance_clockOutFail(String error) {
    return 'Failed to clock out: $error';
  }

  @override
  String get attendance_statusBefore => 'Before Clock In';

  @override
  String get attendance_statusOnDuty => 'Working';

  @override
  String get attendance_statusCompleted => 'Clocked Out';

  @override
  String get attendance_workHours => 'Work Hours';

  @override
  String get attendance_buttonClockIn => 'Clock In';

  @override
  String get attendance_buttonClockOut => 'Clock Out';

  @override
  String get notice_errorLoadList => 'Could not load notices';

  @override
  String get notice_empty => 'No notices';

  @override
  String get notice_detail => 'Notice Detail';

  @override
  String get notice_errorLoad => 'Could not load notice';

  @override
  String get notice_important => 'Important';

  @override
  String get notice_confirmed => 'Confirmed';

  @override
  String get notice_confirm => 'Confirm';

  @override
  String get opinion_title => 'Suggestions';

  @override
  String get opinion_errorLoad => 'Could not load suggestions';

  @override
  String get opinion_empty => 'No suggestions';

  @override
  String get opinion_inputHint => 'Enter your suggestion...';

  @override
  String get opinion_statusResolved => 'Resolved';

  @override
  String get opinion_statusInReview => 'Under Review';

  @override
  String get opinion_statusReceived => 'Received';

  @override
  String get home_errorLoad => 'Could not load data';

  @override
  String get home_pendingTasks => 'Pending';

  @override
  String home_unprocessedTasks(int count) {
    return 'You have $count pending tasks.';
  }

  @override
  String home_userTasks(String name) {
    return '$name\'s Tasks';
  }

  @override
  String get home_taskTotal => 'All';

  @override
  String get home_taskPending => 'Pending';

  @override
  String home_completionRate(String rate) {
    return '$rate% Complete';
  }

  @override
  String get home_sendOpinion => 'Send Opinion';

  @override
  String get home_opinionPlaceholder => 'Enter your opinion or suggestion';

  @override
  String get home_recentNotices => 'Recent Notices';

  @override
  String get home_viewMore => 'More';

  @override
  String get home_noRecentNotices => 'No recent notices';

  @override
  String get status_inProgress => 'In Progress';

  @override
  String get status_done => 'Completed';

  @override
  String get status_todo => 'Pending';

  @override
  String get priority_urgent => 'Urgent';

  @override
  String get priority_normal => 'Normal';

  @override
  String get priority_low => 'Low';

  @override
  String get error_generic => 'An error occurred';

  @override
  String get error_retry => 'Retry';

  @override
  String get assignment_detail => 'Task Detail';

  @override
  String get assignment_errorLoad => 'Could not load task';

  @override
  String get assignment_dueDate => 'Deadline';

  @override
  String get assignment_createdDate => 'Created';

  @override
  String get assignment_assignees => 'Assignees';

  @override
  String assignment_comments(int count) {
    return 'Comments ($count)';
  }

  @override
  String get assignment_commentHint => 'Write a comment...';

  @override
  String assignment_assigneeCount(int count) {
    return '$count people';
  }

  @override
  String get assignment_myTasks => 'My Tasks';

  @override
  String get assignment_errorLoadList => 'Could not load tasks';

  @override
  String get assignment_empty => 'No tasks assigned';

  @override
  String get comment_defaultUser => 'User';

  @override
  String get comment_badgeManager => 'Manager';

  @override
  String get date_justNow => 'Just now';

  @override
  String date_minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String date_hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String date_daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String date_hoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String date_minutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get checklist_title => 'Daily Checklist';

  @override
  String get checklist_selectPlaceholder => 'Please select a checklist';

  @override
  String get login_labelUsername => 'Username';

  @override
  String get login_labelPassword => 'Password';

  @override
  String get login_buttonLogin => 'Login';

  @override
  String get login_noAccount => 'Don\'t have an account?';

  @override
  String get login_buttonSignup => 'Sign Up';

  @override
  String signup_title(int step) {
    return 'Sign Up ($step/3)';
  }

  @override
  String get signup_completeTitle => 'Sign Up Complete!';

  @override
  String get signup_completeMessage =>
      'You can use the service after admin approval.';

  @override
  String get signup_buttonGetStarted => 'Get Started';

  @override
  String get signup_errorInvalidEmail => 'Please enter a valid email';

  @override
  String get signup_successCodeSent => 'Verification code sent';

  @override
  String get signup_errorSendFailed => 'Failed to send. Please try again.';

  @override
  String get signup_errorInvalidCode => 'Invalid verification code';

  @override
  String get signup_errorVerifyEmail => 'Please verify your email';

  @override
  String get signup_sectionInfo => 'Enter Information';

  @override
  String get signup_labelName => 'Name';

  @override
  String get signup_labelEmail => 'Email';

  @override
  String get signup_labelCompanyCode => 'Company Code';

  @override
  String get signup_labelPasswordConfirm => 'Confirm Password';

  @override
  String get signup_buttonSignup => 'Sign Up';

  @override
  String get signup_buttonVerifyRequest => 'Request Verification';

  @override
  String get signup_buttonResend => 'Resend';

  @override
  String get signup_buttonVerified => 'Verified';

  @override
  String get signup_labelVerificationCode => '6-digit code';

  @override
  String get signup_buttonVerify => 'Verify';

  @override
  String get signup_errorPasswordMismatch => 'Passwords do not match';

  @override
  String get signup_successCodeResent => 'Verification code resent';

  @override
  String get emailVerify_title => 'Email Verification';

  @override
  String emailVerify_description(String email) {
    return 'Enter the 6-digit code sent to\n$email.';
  }

  @override
  String get emailVerify_resend => 'Resend Code';

  @override
  String get terms_title => 'Terms of Service';

  @override
  String get terms_content =>
      'Article 1 (Purpose)\nThese terms regulate the conditions and procedures for using the TaskManager service.\n\nArticle 2 (Definitions)\n\"Service\" refers to the employee task management platform provided by the company.\n\nArticle 3 (Registration)\nRegistration is done through a company code, and admin approval may be required.\n\nArticle 4 (Privacy)\nCollected personal information is used only for service provision purposes.\n\nArticle 5 (Obligations)\nUsers must use the service for work purposes.';

  @override
  String get terms_agree => 'I agree to the Terms of Service';

  @override
  String get terms_next => 'Next';

  @override
  String get validator_emailRequired => 'Please enter your email';

  @override
  String get validator_emailInvalid => 'Invalid email format';

  @override
  String get validator_loginIdRequired => 'Please enter your username';

  @override
  String get validator_loginIdMinLength =>
      'Username must be at least 3 characters';

  @override
  String get validator_passwordRequired => 'Please enter your password';

  @override
  String get validator_passwordMinLength =>
      'Password must be at least 6 characters';

  @override
  String validator_fieldRequired(String fieldName) {
    return 'Please enter $fieldName';
  }

  @override
  String get validator_codeRequired => 'Please enter verification code';

  @override
  String get validator_codeLength => 'Please enter 6-digit code';

  @override
  String get validator_codeDigitsOnly => 'Numbers only';

  @override
  String get apiError_unknown => 'An unknown error occurred';

  @override
  String get apiError_timeout => 'Server response timed out. Please try again.';

  @override
  String get apiError_noConnection => 'Please check your network connection.';

  @override
  String get apiError_cancelled => 'Request was cancelled.';

  @override
  String get apiError_network => 'A network error occurred.';

  @override
  String get apiError_badRequest => 'Invalid request.';

  @override
  String get apiError_unauthorized => 'Session expired. Please login again.';

  @override
  String get apiError_forbidden => 'Access denied.';

  @override
  String get apiError_notFound => 'Requested information not found.';

  @override
  String get apiError_conflict => 'Request conflict.';

  @override
  String get apiError_fileTooLarge => 'File size is too large.';

  @override
  String get apiError_tooManyRequests =>
      'Too many requests. Please try again later.';

  @override
  String get apiError_server => 'Server error. Please try again later.';

  @override
  String apiError_default(int code) {
    return 'An error occurred. (Code: $code)';
  }
}
