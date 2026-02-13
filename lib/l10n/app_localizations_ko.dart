// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'TaskManager';

  @override
  String get mypage_title => '마이페이지';

  @override
  String get mypage_editProfile => '프로필 수정';

  @override
  String get mypage_changePassword => '비밀번호 변경';

  @override
  String get mypage_languageSettings => '언어 설정';

  @override
  String get mypage_appInfo => '앱 정보';

  @override
  String get mypage_logout => '로그아웃';

  @override
  String get mypage_logoutConfirm => '정말 로그아웃하시겠습니까?';

  @override
  String get mypage_cancel => '취소';

  @override
  String get mypage_roleManager => '매니저';

  @override
  String get mypage_roleAdmin => '관리자';

  @override
  String get mypage_roleEmployee => '직원';

  @override
  String get nav_home => '홈';

  @override
  String get nav_tasks => '내업무';

  @override
  String get nav_notices => '공지사항';

  @override
  String get notification_title => '알림';

  @override
  String get notification_markAllRead => '모두 읽음';

  @override
  String get notification_errorLoad => '알림을 불러올 수 없습니다';

  @override
  String get notification_empty => '알림이 없습니다';

  @override
  String get attendance_title => '출퇴근';

  @override
  String get attendance_errorLoad => '출퇴근 정보를 불러올 수 없습니다';

  @override
  String get attendance_clockIn => '출근 시간';

  @override
  String get attendance_clockOut => '퇴근 시간';

  @override
  String get attendance_clockInSuccess => '출근 처리되었습니다';

  @override
  String attendance_clockInFail(String error) {
    return '출근 처리에 실패했습니다: $error';
  }

  @override
  String get attendance_clockOutSuccess => '퇴근 처리되었습니다';

  @override
  String attendance_clockOutFail(String error) {
    return '퇴근 처리에 실패했습니다: $error';
  }

  @override
  String get attendance_statusBefore => '출근 전';

  @override
  String get attendance_statusOnDuty => '근무 중';

  @override
  String get attendance_statusCompleted => '퇴근 완료';

  @override
  String get attendance_workHours => '근무 시간';

  @override
  String get attendance_buttonClockIn => '출근하기';

  @override
  String get attendance_buttonClockOut => '퇴근하기';

  @override
  String get notice_errorLoadList => '공지사항을 불러올 수 없습니다';

  @override
  String get notice_empty => '공지사항이 없습니다';

  @override
  String get notice_detail => '공지 상세';

  @override
  String get notice_errorLoad => '공지를 불러올 수 없습니다';

  @override
  String get notice_important => '중요';

  @override
  String get notice_confirmed => '확인 처리되었습니다';

  @override
  String get notice_confirm => '확인';

  @override
  String get opinion_title => '건의사항';

  @override
  String get opinion_errorLoad => '건의사항을 불러올 수 없습니다';

  @override
  String get opinion_empty => '등록된 건의사항이 없습니다';

  @override
  String get opinion_inputHint => '건의사항을 입력하세요...';

  @override
  String get opinion_statusResolved => '처리완료';

  @override
  String get opinion_statusInReview => '검토중';

  @override
  String get opinion_statusReceived => '접수';

  @override
  String get home_errorLoad => '데이터를 불러올 수 없습니다';

  @override
  String get home_pendingTasks => '대기 업무';

  @override
  String home_unprocessedTasks(int count) {
    return '처리되지 않은 업무가 $count건 있습니다.';
  }

  @override
  String home_userTasks(String name) {
    return '$name님의 업무';
  }

  @override
  String get home_taskTotal => '전체';

  @override
  String get home_taskPending => '대기';

  @override
  String home_completionRate(String rate) {
    return '$rate% 완료';
  }

  @override
  String get home_sendOpinion => '의견보내기';

  @override
  String get home_opinionPlaceholder => '의견이나 건의사항을 입력해주세요';

  @override
  String get home_recentNotices => '최근 공지사항';

  @override
  String get home_viewMore => '더보기';

  @override
  String get home_noRecentNotices => '최근 공지사항이 없습니다';

  @override
  String get status_inProgress => '진행중';

  @override
  String get status_done => '완료';

  @override
  String get status_todo => '예정';

  @override
  String get priority_urgent => '긴급';

  @override
  String get priority_normal => '보통';

  @override
  String get priority_low => '낮음';

  @override
  String get error_generic => '오류가 발생했습니다';

  @override
  String get error_retry => '다시 시도';

  @override
  String get assignment_detail => '업무 상세';

  @override
  String get assignment_errorLoad => '업무를 불러올 수 없습니다';

  @override
  String get assignment_dueDate => '마감일';

  @override
  String get assignment_createdDate => '생성일';

  @override
  String get assignment_assignees => '담당자';

  @override
  String assignment_comments(int count) {
    return '댓글 ($count)';
  }

  @override
  String get assignment_commentHint => '댓글을 입력하세요...';

  @override
  String assignment_assigneeCount(int count) {
    return '$count명';
  }

  @override
  String get assignment_myTasks => '내 업무';

  @override
  String get assignment_errorLoadList => '업무 목록을 불러올 수 없습니다';

  @override
  String get assignment_empty => '배정된 업무가 없습니다';

  @override
  String get comment_defaultUser => '사용자';

  @override
  String get comment_badgeManager => '매니저';

  @override
  String get date_justNow => '방금 전';

  @override
  String date_minutesAgo(int minutes) {
    return '$minutes분 전';
  }

  @override
  String date_hoursAgo(int hours) {
    return '$hours시간 전';
  }

  @override
  String date_daysAgo(int days) {
    return '$days일 전';
  }

  @override
  String date_hoursMinutes(int hours, int minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String date_minutes(int minutes) {
    return '$minutes분';
  }

  @override
  String get checklist_title => '일일 체크리스트';

  @override
  String get checklist_selectPlaceholder => '체크리스트를 선택해주세요';

  @override
  String get login_labelUsername => '아이디';

  @override
  String get login_labelPassword => '비밀번호';

  @override
  String get login_buttonLogin => '로그인';

  @override
  String get login_noAccount => '계정이 없으신가요?';

  @override
  String get login_buttonSignup => '회원가입';

  @override
  String signup_title(int step) {
    return '회원가입 ($step/3)';
  }

  @override
  String get signup_completeTitle => '가입 완료!';

  @override
  String get signup_completeMessage => '관리자 승인 후 서비스를 이용하실 수 있습니다.';

  @override
  String get signup_buttonGetStarted => '시작하기';

  @override
  String get signup_errorInvalidEmail => '올바른 이메일을 입력해주세요';

  @override
  String get signup_successCodeSent => '인증번호가 전송되었습니다';

  @override
  String get signup_errorSendFailed => '전송에 실패했습니다. 다시 시도해주세요';

  @override
  String get signup_errorInvalidCode => '인증번호가 올바르지 않습니다';

  @override
  String get signup_errorVerifyEmail => '이메일 인증을 완료해주세요';

  @override
  String get signup_sectionInfo => '정보 입력';

  @override
  String get signup_labelName => '이름';

  @override
  String get signup_labelEmail => '이메일';

  @override
  String get signup_labelCompanyCode => '회사 코드';

  @override
  String get signup_labelPasswordConfirm => '비밀번호 확인';

  @override
  String get signup_buttonSignup => '가입하기';

  @override
  String get signup_buttonVerifyRequest => '인증요청';

  @override
  String get signup_buttonResend => '재전송';

  @override
  String get signup_buttonVerified => '인증완료';

  @override
  String get signup_labelVerificationCode => '인증번호 6자리';

  @override
  String get signup_buttonVerify => '인증하기';

  @override
  String get signup_errorPasswordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String get signup_successCodeResent => '인증번호가 재전송되었습니다';

  @override
  String get emailVerify_title => '이메일 인증';

  @override
  String emailVerify_description(String email) {
    return '$email로 전송된\n6자리 인증번호를 입력해주세요.';
  }

  @override
  String get emailVerify_resend => '인증번호 재전송';

  @override
  String get terms_title => '이용약관';

  @override
  String get terms_content =>
      '제 1조 (목적)\n본 약관은 TaskManager 서비스 이용에 관한 조건 및 절차를 규정합니다.\n\n제 2조 (정의)\n\"서비스\"란 회사가 제공하는 직원 업무 관리 플랫폼을 의미합니다.\n\n제 3조 (가입)\n회원가입은 회사 코드를 통해 이루어지며, 관리자 승인이 필요할 수 있습니다.\n\n제 4조 (개인정보)\n수집된 개인정보는 서비스 제공 목적으로만 사용됩니다.\n\n제 5조 (의무)\n이용자는 서비스를 업무 목적으로 사용해야 합니다.';

  @override
  String get terms_agree => '이용약관에 동의합니다';

  @override
  String get terms_next => '다음';

  @override
  String get validator_emailRequired => '이메일을 입력해주세요';

  @override
  String get validator_emailInvalid => '올바른 이메일 형식이 아닙니다';

  @override
  String get validator_loginIdRequired => '아이디를 입력해주세요';

  @override
  String get validator_loginIdMinLength => '아이디는 3자 이상이어야 합니다';

  @override
  String get validator_passwordRequired => '비밀번호를 입력해주세요';

  @override
  String get validator_passwordMinLength => '비밀번호는 6자 이상이어야 합니다';

  @override
  String validator_fieldRequired(String fieldName) {
    return '$fieldName을(를) 입력해주세요';
  }

  @override
  String get validator_codeRequired => '인증번호를 입력해주세요';

  @override
  String get validator_codeLength => '6자리 인증번호를 입력해주세요';

  @override
  String get validator_codeDigitsOnly => '숫자만 입력해주세요';

  @override
  String get apiError_unknown => '알 수 없는 오류가 발생했습니다';

  @override
  String get apiError_timeout => '서버 응답 시간이 초과되었습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get apiError_noConnection => '네트워크 연결을 확인해 주세요.';

  @override
  String get apiError_cancelled => '요청이 취소되었습니다.';

  @override
  String get apiError_network => '네트워크 오류가 발생했습니다.';

  @override
  String get apiError_badRequest => '잘못된 요청입니다.';

  @override
  String get apiError_unauthorized => '인증이 만료되었습니다. 다시 로그인해 주세요.';

  @override
  String get apiError_forbidden => '접근 권한이 없습니다.';

  @override
  String get apiError_notFound => '요청한 정보를 찾을 수 없습니다.';

  @override
  String get apiError_conflict => '요청이 충돌합니다.';

  @override
  String get apiError_fileTooLarge => '파일 크기가 너무 큽니다.';

  @override
  String get apiError_tooManyRequests => '요청이 너무 많습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get apiError_server => '서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String apiError_default(int code) {
    return '오류가 발생했습니다. (코드: $code)';
  }
}
