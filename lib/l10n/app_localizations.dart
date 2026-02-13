import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ko'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'TaskManager'**
  String get appTitle;

  /// No description provided for @mypage_title.
  ///
  /// In en, this message translates to:
  /// **'My Page'**
  String get mypage_title;

  /// No description provided for @mypage_editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get mypage_editProfile;

  /// No description provided for @mypage_changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get mypage_changePassword;

  /// No description provided for @mypage_languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get mypage_languageSettings;

  /// No description provided for @mypage_appInfo.
  ///
  /// In en, this message translates to:
  /// **'App Info'**
  String get mypage_appInfo;

  /// No description provided for @mypage_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get mypage_logout;

  /// No description provided for @mypage_logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get mypage_logoutConfirm;

  /// No description provided for @mypage_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mypage_cancel;

  /// No description provided for @mypage_roleManager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get mypage_roleManager;

  /// No description provided for @mypage_roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get mypage_roleAdmin;

  /// No description provided for @mypage_roleEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get mypage_roleEmployee;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_tasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get nav_tasks;

  /// No description provided for @nav_notices.
  ///
  /// In en, this message translates to:
  /// **'Notices'**
  String get nav_notices;

  /// No description provided for @notification_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification_title;

  /// No description provided for @notification_markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All Read'**
  String get notification_markAllRead;

  /// No description provided for @notification_errorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load notifications'**
  String get notification_errorLoad;

  /// No description provided for @notification_empty.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notification_empty;

  /// No description provided for @attendance_title.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance_title;

  /// No description provided for @attendance_errorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load attendance info'**
  String get attendance_errorLoad;

  /// No description provided for @attendance_clockIn.
  ///
  /// In en, this message translates to:
  /// **'Clock In Time'**
  String get attendance_clockIn;

  /// No description provided for @attendance_clockOut.
  ///
  /// In en, this message translates to:
  /// **'Clock Out Time'**
  String get attendance_clockOut;

  /// No description provided for @attendance_clockInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Clock in recorded'**
  String get attendance_clockInSuccess;

  /// No description provided for @attendance_clockInFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to clock in: {error}'**
  String attendance_clockInFail(String error);

  /// No description provided for @attendance_clockOutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Clock out recorded'**
  String get attendance_clockOutSuccess;

  /// No description provided for @attendance_clockOutFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to clock out: {error}'**
  String attendance_clockOutFail(String error);

  /// No description provided for @attendance_statusBefore.
  ///
  /// In en, this message translates to:
  /// **'Before Clock In'**
  String get attendance_statusBefore;

  /// No description provided for @attendance_statusOnDuty.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get attendance_statusOnDuty;

  /// No description provided for @attendance_statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Clocked Out'**
  String get attendance_statusCompleted;

  /// No description provided for @attendance_workHours.
  ///
  /// In en, this message translates to:
  /// **'Work Hours'**
  String get attendance_workHours;

  /// No description provided for @attendance_buttonClockIn.
  ///
  /// In en, this message translates to:
  /// **'Clock In'**
  String get attendance_buttonClockIn;

  /// No description provided for @attendance_buttonClockOut.
  ///
  /// In en, this message translates to:
  /// **'Clock Out'**
  String get attendance_buttonClockOut;

  /// No description provided for @notice_errorLoadList.
  ///
  /// In en, this message translates to:
  /// **'Could not load notices'**
  String get notice_errorLoadList;

  /// No description provided for @notice_empty.
  ///
  /// In en, this message translates to:
  /// **'No notices'**
  String get notice_empty;

  /// No description provided for @notice_detail.
  ///
  /// In en, this message translates to:
  /// **'Notice Detail'**
  String get notice_detail;

  /// No description provided for @notice_errorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load notice'**
  String get notice_errorLoad;

  /// No description provided for @notice_important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get notice_important;

  /// No description provided for @notice_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get notice_confirmed;

  /// No description provided for @notice_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get notice_confirm;

  /// No description provided for @opinion_title.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get opinion_title;

  /// No description provided for @opinion_errorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load suggestions'**
  String get opinion_errorLoad;

  /// No description provided for @opinion_empty.
  ///
  /// In en, this message translates to:
  /// **'No suggestions'**
  String get opinion_empty;

  /// No description provided for @opinion_inputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your suggestion...'**
  String get opinion_inputHint;

  /// No description provided for @opinion_statusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get opinion_statusResolved;

  /// No description provided for @opinion_statusInReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get opinion_statusInReview;

  /// No description provided for @opinion_statusReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get opinion_statusReceived;

  /// No description provided for @home_errorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load data'**
  String get home_errorLoad;

  /// No description provided for @home_pendingTasks.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get home_pendingTasks;

  /// No description provided for @home_unprocessedTasks.
  ///
  /// In en, this message translates to:
  /// **'You have {count} pending tasks.'**
  String home_unprocessedTasks(int count);

  /// No description provided for @home_userTasks.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s Tasks'**
  String home_userTasks(String name);

  /// No description provided for @home_taskTotal.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get home_taskTotal;

  /// No description provided for @home_taskPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get home_taskPending;

  /// No description provided for @home_completionRate.
  ///
  /// In en, this message translates to:
  /// **'{rate}% Complete'**
  String home_completionRate(String rate);

  /// No description provided for @home_sendOpinion.
  ///
  /// In en, this message translates to:
  /// **'Send Opinion'**
  String get home_sendOpinion;

  /// No description provided for @home_opinionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your opinion or suggestion'**
  String get home_opinionPlaceholder;

  /// No description provided for @home_recentNotices.
  ///
  /// In en, this message translates to:
  /// **'Recent Notices'**
  String get home_recentNotices;

  /// No description provided for @home_viewMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get home_viewMore;

  /// No description provided for @home_noRecentNotices.
  ///
  /// In en, this message translates to:
  /// **'No recent notices'**
  String get home_noRecentNotices;

  /// No description provided for @status_inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get status_inProgress;

  /// No description provided for @status_done.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get status_done;

  /// No description provided for @status_todo.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get status_todo;

  /// No description provided for @priority_urgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get priority_urgent;

  /// No description provided for @priority_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get priority_normal;

  /// No description provided for @priority_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priority_low;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error_generic;

  /// No description provided for @error_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get error_retry;

  /// No description provided for @assignment_detail.
  ///
  /// In en, this message translates to:
  /// **'Task Detail'**
  String get assignment_detail;

  /// No description provided for @assignment_errorLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load task'**
  String get assignment_errorLoad;

  /// No description provided for @assignment_dueDate.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get assignment_dueDate;

  /// No description provided for @assignment_createdDate.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get assignment_createdDate;

  /// No description provided for @assignment_assignees.
  ///
  /// In en, this message translates to:
  /// **'Assignees'**
  String get assignment_assignees;

  /// No description provided for @assignment_comments.
  ///
  /// In en, this message translates to:
  /// **'Comments ({count})'**
  String assignment_comments(int count);

  /// No description provided for @assignment_commentHint.
  ///
  /// In en, this message translates to:
  /// **'Write a comment...'**
  String get assignment_commentHint;

  /// No description provided for @assignment_assigneeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} people'**
  String assignment_assigneeCount(int count);

  /// No description provided for @assignment_myTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get assignment_myTasks;

  /// No description provided for @assignment_errorLoadList.
  ///
  /// In en, this message translates to:
  /// **'Could not load tasks'**
  String get assignment_errorLoadList;

  /// No description provided for @assignment_empty.
  ///
  /// In en, this message translates to:
  /// **'No tasks assigned'**
  String get assignment_empty;

  /// No description provided for @comment_defaultUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get comment_defaultUser;

  /// No description provided for @comment_badgeManager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get comment_badgeManager;

  /// No description provided for @date_justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get date_justNow;

  /// No description provided for @date_minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String date_minutesAgo(int minutes);

  /// No description provided for @date_hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String date_hoursAgo(int hours);

  /// No description provided for @date_daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String date_daysAgo(int days);

  /// No description provided for @date_hoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String date_hoursMinutes(int hours, int minutes);

  /// No description provided for @date_minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String date_minutes(int minutes);

  /// No description provided for @checklist_title.
  ///
  /// In en, this message translates to:
  /// **'Daily Checklist'**
  String get checklist_title;

  /// No description provided for @checklist_selectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Please select a checklist'**
  String get checklist_selectPlaceholder;

  /// No description provided for @login_labelUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get login_labelUsername;

  /// No description provided for @login_labelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_labelPassword;

  /// No description provided for @login_buttonLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_buttonLogin;

  /// No description provided for @login_noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_noAccount;

  /// No description provided for @login_buttonSignup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get login_buttonSignup;

  /// No description provided for @signup_title.
  ///
  /// In en, this message translates to:
  /// **'Sign Up ({step}/3)'**
  String signup_title(int step);

  /// No description provided for @signup_completeTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Complete!'**
  String get signup_completeTitle;

  /// No description provided for @signup_completeMessage.
  ///
  /// In en, this message translates to:
  /// **'You can use the service after admin approval.'**
  String get signup_completeMessage;

  /// No description provided for @signup_buttonGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get signup_buttonGetStarted;

  /// No description provided for @signup_errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get signup_errorInvalidEmail;

  /// No description provided for @signup_successCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent'**
  String get signup_successCodeSent;

  /// No description provided for @signup_errorSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send. Please try again.'**
  String get signup_errorSendFailed;

  /// No description provided for @signup_errorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code'**
  String get signup_errorInvalidCode;

  /// No description provided for @signup_errorVerifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email'**
  String get signup_errorVerifyEmail;

  /// No description provided for @signup_sectionInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter Information'**
  String get signup_sectionInfo;

  /// No description provided for @signup_labelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get signup_labelName;

  /// No description provided for @signup_labelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signup_labelEmail;

  /// No description provided for @signup_labelCompanyCode.
  ///
  /// In en, this message translates to:
  /// **'Company Code'**
  String get signup_labelCompanyCode;

  /// No description provided for @signup_labelPasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signup_labelPasswordConfirm;

  /// No description provided for @signup_buttonSignup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup_buttonSignup;

  /// No description provided for @signup_buttonVerifyRequest.
  ///
  /// In en, this message translates to:
  /// **'Request Verification'**
  String get signup_buttonVerifyRequest;

  /// No description provided for @signup_buttonResend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get signup_buttonResend;

  /// No description provided for @signup_buttonVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get signup_buttonVerified;

  /// No description provided for @signup_labelVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get signup_labelVerificationCode;

  /// No description provided for @signup_buttonVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get signup_buttonVerify;

  /// No description provided for @signup_errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get signup_errorPasswordMismatch;

  /// No description provided for @signup_successCodeResent.
  ///
  /// In en, this message translates to:
  /// **'Verification code resent'**
  String get signup_successCodeResent;

  /// No description provided for @emailVerify_title.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerify_title;

  /// No description provided for @emailVerify_description.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to\n{email}.'**
  String emailVerify_description(String email);

  /// No description provided for @emailVerify_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get emailVerify_resend;

  /// No description provided for @terms_title.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_title;

  /// No description provided for @terms_content.
  ///
  /// In en, this message translates to:
  /// **'Article 1 (Purpose)\nThese terms regulate the conditions and procedures for using the TaskManager service.\n\nArticle 2 (Definitions)\n\"Service\" refers to the employee task management platform provided by the company.\n\nArticle 3 (Registration)\nRegistration is done through a company code, and admin approval may be required.\n\nArticle 4 (Privacy)\nCollected personal information is used only for service provision purposes.\n\nArticle 5 (Obligations)\nUsers must use the service for work purposes.'**
  String get terms_content;

  /// No description provided for @terms_agree.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service'**
  String get terms_agree;

  /// No description provided for @terms_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get terms_next;

  /// No description provided for @validator_emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get validator_emailRequired;

  /// No description provided for @validator_emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get validator_emailInvalid;

  /// No description provided for @validator_loginIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get validator_loginIdRequired;

  /// No description provided for @validator_loginIdMinLength.
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get validator_loginIdMinLength;

  /// No description provided for @validator_passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get validator_passwordRequired;

  /// No description provided for @validator_passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get validator_passwordMinLength;

  /// No description provided for @validator_fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter {fieldName}'**
  String validator_fieldRequired(String fieldName);

  /// No description provided for @validator_codeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get validator_codeRequired;

  /// No description provided for @validator_codeLength.
  ///
  /// In en, this message translates to:
  /// **'Please enter 6-digit code'**
  String get validator_codeLength;

  /// No description provided for @validator_codeDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Numbers only'**
  String get validator_codeDigitsOnly;

  /// No description provided for @apiError_unknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get apiError_unknown;

  /// No description provided for @apiError_timeout.
  ///
  /// In en, this message translates to:
  /// **'Server response timed out. Please try again.'**
  String get apiError_timeout;

  /// No description provided for @apiError_noConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your network connection.'**
  String get apiError_noConnection;

  /// No description provided for @apiError_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get apiError_cancelled;

  /// No description provided for @apiError_network.
  ///
  /// In en, this message translates to:
  /// **'A network error occurred.'**
  String get apiError_network;

  /// No description provided for @apiError_badRequest.
  ///
  /// In en, this message translates to:
  /// **'Invalid request.'**
  String get apiError_badRequest;

  /// No description provided for @apiError_unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get apiError_unauthorized;

  /// No description provided for @apiError_forbidden.
  ///
  /// In en, this message translates to:
  /// **'Access denied.'**
  String get apiError_forbidden;

  /// No description provided for @apiError_notFound.
  ///
  /// In en, this message translates to:
  /// **'Requested information not found.'**
  String get apiError_notFound;

  /// No description provided for @apiError_conflict.
  ///
  /// In en, this message translates to:
  /// **'Request conflict.'**
  String get apiError_conflict;

  /// No description provided for @apiError_fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File size is too large.'**
  String get apiError_fileTooLarge;

  /// No description provided for @apiError_tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later.'**
  String get apiError_tooManyRequests;

  /// No description provided for @apiError_server.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get apiError_server;

  /// No description provided for @apiError_default.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. (Code: {code})'**
  String apiError_default(int code);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
