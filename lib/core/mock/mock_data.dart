import '../../features/auth/domain/entities/user.dart';
import '../../features/assignment/domain/entities/assignment.dart';
import '../../features/notice/domain/entities/notice.dart';
import '../../features/dashboard/domain/entities/dashboard_summary.dart';
import '../../features/attendance/domain/entities/attendance_record.dart';
import '../../features/notification/domain/entities/app_notification.dart';
import '../../features/opinion/domain/entities/opinion.dart';
import '../../features/checklist/domain/entities/daily_checklist.dart';

class MockData {
  MockData._();

  // ─── Current User ───────────────────────────────────
  static final currentUser = User(
    id: 'mock-user-1',
    email: 'minsu.kim@scr.co.kr',
    loginId: 'minsu.kim',
    fullName: '김민수',
    companyId: 'mock-company-1',
    role: 'manager',
    status: 'active',
    language: 'ko',
    emailVerified: true,
    joinDate: DateTime(2024, 3, 15),
    createdAt: DateTime(2024, 3, 15),
    updatedAt: DateTime(2026, 2, 1),
  );

  // ─── Assignments ────────────────────────────────────
  static final assignments = <Assignment>[
    Assignment(
      id: 'mock-assignment-1',
      companyId: 'mock-company-1',
      branchId: 'mock-branch-1',
      title: '매장 청소 및 정리',
      description: '영업 종료 후 매장 전체 청소 및 물품 정리를 완료해주세요.\n\n- 바닥 청소\n- 테이블 정리\n- 쓰레기 수거',
      priority: 'normal',
      status: 'todo',
      dueDate: DateTime(2026, 2, 14),
      createdBy: 'mock-user-2',
      createdAt: DateTime(2026, 2, 10),
      updatedAt: DateTime(2026, 2, 10),
      assignees: [
        AssignmentAssignee(
          assignmentId: 'mock-assignment-1',
          userId: 'mock-user-1',
          assignedAt: DateTime(2026, 2, 10),
          userName: '김민수',
        ),
      ],
    ),
    Assignment(
      id: 'mock-assignment-2',
      companyId: 'mock-company-1',
      branchId: 'mock-branch-1',
      title: '재고 확인 보고서 작성',
      description: '이번 주 재고 현황을 확인하고 보고서를 작성해주세요.\n품목별 수량 및 유통기한 확인 필수.',
      priority: 'normal',
      status: 'in_progress',
      dueDate: DateTime(2026, 2, 15),
      createdBy: 'mock-user-2',
      createdAt: DateTime(2026, 2, 8),
      updatedAt: DateTime(2026, 2, 12),
      assignees: [
        AssignmentAssignee(
          assignmentId: 'mock-assignment-2',
          userId: 'mock-user-1',
          assignedAt: DateTime(2026, 2, 8),
          userName: '김민수',
        ),
        AssignmentAssignee(
          assignmentId: 'mock-assignment-2',
          userId: 'mock-user-3',
          assignedAt: DateTime(2026, 2, 8),
          userName: '이서연',
        ),
      ],
    ),
    Assignment(
      id: 'mock-assignment-3',
      companyId: 'mock-company-1',
      branchId: 'mock-branch-1',
      title: '신규 직원 교육 진행',
      description: '신규 입사자 박지훈 사원의 매장 운영 교육을 진행해주세요.\n\n교육 내용:\n- POS 시스템 사용법\n- 재고 관리 방법\n- 고객 응대 매뉴얼',
      priority: 'urgent',
      status: 'in_progress',
      dueDate: DateTime(2026, 2, 13),
      createdBy: 'mock-user-2',
      createdAt: DateTime(2026, 2, 5),
      updatedAt: DateTime(2026, 2, 11),
      assignees: [
        AssignmentAssignee(
          assignmentId: 'mock-assignment-3',
          userId: 'mock-user-1',
          assignedAt: DateTime(2026, 2, 5),
          userName: '김민수',
        ),
      ],
    ),
    Assignment(
      id: 'mock-assignment-4',
      companyId: 'mock-company-1',
      branchId: 'mock-branch-1',
      title: '월간 매출 보고서 제출',
      description: '1월 매출 보고서를 작성하여 본사에 제출해주세요.',
      priority: 'normal',
      status: 'done',
      dueDate: DateTime(2026, 2, 5),
      createdBy: 'mock-user-2',
      createdAt: DateTime(2026, 1, 28),
      updatedAt: DateTime(2026, 2, 4),
      assignees: [
        AssignmentAssignee(
          assignmentId: 'mock-assignment-4',
          userId: 'mock-user-1',
          assignedAt: DateTime(2026, 1, 28),
          userName: '김민수',
        ),
      ],
    ),
    Assignment(
      id: 'mock-assignment-5',
      companyId: 'mock-company-1',
      branchId: 'mock-branch-1',
      title: '고객 피드백 분석',
      description: '지난 한 달간 수집된 고객 피드백을 분석하고 개선 사항을 정리해주세요.',
      priority: 'urgent',
      status: 'todo',
      dueDate: DateTime(2026, 2, 20),
      createdBy: 'mock-user-2',
      createdAt: DateTime(2026, 2, 12),
      updatedAt: DateTime(2026, 2, 12),
      assignees: [
        AssignmentAssignee(
          assignmentId: 'mock-assignment-5',
          userId: 'mock-user-1',
          assignedAt: DateTime(2026, 2, 12),
          userName: '김민수',
        ),
        AssignmentAssignee(
          assignmentId: 'mock-assignment-5',
          userId: 'mock-user-4',
          assignedAt: DateTime(2026, 2, 12),
          userName: '최영호',
        ),
      ],
    ),
    Assignment(
      id: 'mock-assignment-6',
      companyId: 'mock-company-1',
      branchId: 'mock-branch-1',
      title: '안전 점검 실시',
      description: '소방 설비 및 전기 안전 점검을 실시해주세요.',
      priority: 'low',
      status: 'todo',
      dueDate: DateTime(2026, 2, 28),
      createdBy: 'mock-user-2',
      createdAt: DateTime(2026, 2, 1),
      updatedAt: DateTime(2026, 2, 1),
      assignees: [
        AssignmentAssignee(
          assignmentId: 'mock-assignment-6',
          userId: 'mock-user-1',
          assignedAt: DateTime(2026, 2, 1),
          userName: '김민수',
        ),
      ],
    ),
  ];

  // ─── Comments (by assignment ID) ────────────────────
  static final comments = <String, List<Comment>>{
    'mock-assignment-1': [
      Comment(
        id: 'mock-comment-1',
        assignmentId: 'mock-assignment-1',
        userId: 'mock-user-2',
        userName: '박점장',
        isManager: true,
        content: '오늘 영업 종료 후 반드시 완료해주세요.',
        contentType: 'text',
        createdAt: DateTime(2026, 2, 10, 14, 30),
      ),
      Comment(
        id: 'mock-comment-2',
        assignmentId: 'mock-assignment-1',
        userId: 'mock-user-1',
        userName: '김민수',
        isManager: true,
        content: '네, 알겠습니다. 퇴근 전에 완료하겠습니다.',
        contentType: 'text',
        createdAt: DateTime(2026, 2, 10, 15, 0),
      ),
    ],
    'mock-assignment-3': [
      Comment(
        id: 'mock-comment-3',
        assignmentId: 'mock-assignment-3',
        userId: 'mock-user-2',
        userName: '박점장',
        isManager: true,
        content: 'POS 교육은 완료되었나요?',
        contentType: 'text',
        createdAt: DateTime(2026, 2, 11, 10, 0),
      ),
      Comment(
        id: 'mock-comment-4',
        assignmentId: 'mock-assignment-3',
        userId: 'mock-user-1',
        userName: '김민수',
        isManager: true,
        content: '네, POS 기본 교육은 완료했고 내일 재고 관리 교육 진행 예정입니다.',
        contentType: 'text',
        createdAt: DateTime(2026, 2, 11, 11, 30),
      ),
    ],
  };

  // ─── Notices ────────────────────────────────────────
  static final notices = <Notice>[
    Notice(
      id: 'mock-notice-1',
      companyId: 'mock-company-1',
      authorId: 'mock-user-admin',
      authorName: '본사 관리팀',
      authorRole: 'admin',
      title: '2월 근무 일정 안내',
      content: '2월 근무 일정이 확정되었습니다.\n\n주요 변경사항:\n- 설 연휴(2/28~3/2) 근무조 편성\n- 야간 근무 시간 변경(22:00 → 21:30)\n\n자세한 내용은 매장 게시판을 확인해주세요.',
      isImportant: true,
      createdAt: DateTime(2026, 2, 1, 9, 0),
    ),
    Notice(
      id: 'mock-notice-2',
      companyId: 'mock-company-1',
      authorId: 'mock-user-admin',
      authorName: 'IT팀',
      title: '시스템 업데이트 안내',
      content: '2월 15일(토) 02:00~06:00 시스템 정기 점검이 예정되어 있습니다.\n해당 시간에는 앱 사용이 일시적으로 제한될 수 있습니다.',
      isImportant: false,
      createdAt: DateTime(2026, 2, 5, 10, 0),
    ),
    Notice(
      id: 'mock-notice-3',
      companyId: 'mock-company-1',
      authorId: 'mock-user-admin',
      authorName: '인사팀',
      authorRole: 'admin',
      title: '연간 건강검진 안내',
      content: '2026년 연간 건강검진 일정을 안내드립니다.\n\n대상: 전 직원\n기간: 3월 1일 ~ 3월 31일\n지정병원: 서울대학교병원, 삼성서울병원\n\n검진 예약은 각 병원 홈페이지에서 진행해주세요.',
      isImportant: true,
      createdAt: DateTime(2026, 2, 10, 9, 0),
    ),
    Notice(
      id: 'mock-notice-4',
      companyId: 'mock-company-1',
      authorId: 'mock-user-admin',
      authorName: '마케팅팀',
      title: '신메뉴 출시 안내',
      content: '2월 20일부터 봄 시즌 신메뉴가 출시됩니다.\n\n신메뉴:\n- 딸기 라떼\n- 벚꽃 에이드\n- 봄날 샌드위치\n\n메뉴 교육은 2월 18일에 진행 예정입니다.',
      isImportant: false,
      createdAt: DateTime(2026, 2, 12, 14, 0),
    ),
  ];

  // ─── Notifications ──────────────────────────────────
  static final notifications = <AppNotification>[
    AppNotification(
      id: 'mock-noti-1',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      type: 'assignment',
      title: '새 업무가 배정되었습니다',
      message: '"고객 피드백 분석" 업무가 배정되었습니다.',
      referenceId: 'mock-assignment-5',
      referenceType: 'assignment',
      isRead: false,
      createdAt: DateTime(2026, 2, 12, 15, 0),
    ),
    AppNotification(
      id: 'mock-noti-2',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      type: 'notice',
      title: '새 공지사항',
      message: '"신메뉴 출시 안내"가 등록되었습니다.',
      referenceId: 'mock-notice-4',
      referenceType: 'notice',
      isRead: false,
      createdAt: DateTime(2026, 2, 12, 14, 0),
    ),
    AppNotification(
      id: 'mock-noti-3',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      type: 'comment',
      title: '새 댓글',
      message: '박점장님이 "신규 직원 교육 진행"에 댓글을 남겼습니다.',
      referenceId: 'mock-assignment-3',
      referenceType: 'assignment',
      isRead: true,
      createdAt: DateTime(2026, 2, 11, 10, 0),
    ),
    AppNotification(
      id: 'mock-noti-4',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      type: 'system',
      title: '출근 알림',
      message: '오늘 근무 시작 시간입니다. 출근 체크를 해주세요.',
      isRead: true,
      createdAt: DateTime(2026, 2, 13, 8, 50),
    ),
    AppNotification(
      id: 'mock-noti-5',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      type: 'assignment',
      title: '업무 마감 임박',
      message: '"신규 직원 교육 진행" 업무의 마감일이 오늘입니다.',
      referenceId: 'mock-assignment-3',
      referenceType: 'assignment',
      isRead: false,
      createdAt: DateTime(2026, 2, 13, 9, 0),
    ),
  ];

  // ─── Attendance ─────────────────────────────────────
  static final todayAttendance = AttendanceRecord(
    id: 'mock-attendance-1',
    companyId: 'mock-company-1',
    userId: 'mock-user-1',
    branchId: 'mock-branch-1',
    clockIn: DateTime(2026, 2, 13, 9, 2),
    status: 'on_duty',
    location: '강남점',
  );

  static final attendanceHistory = <String, dynamic>{
    'records': [
      {
        'id': 'mock-att-h1',
        'date': '2026-02-12',
        'clock_in': '2026-02-12T09:00:00',
        'clock_out': '2026-02-12T18:05:00',
        'status': 'completed',
        'work_hours': 9.08,
      },
      {
        'id': 'mock-att-h2',
        'date': '2026-02-11',
        'clock_in': '2026-02-11T08:55:00',
        'clock_out': '2026-02-11T18:10:00',
        'status': 'completed',
        'work_hours': 9.25,
      },
      {
        'id': 'mock-att-h3',
        'date': '2026-02-10',
        'clock_in': '2026-02-10T09:15:00',
        'clock_out': '2026-02-10T18:00:00',
        'status': 'completed',
        'work_hours': 8.75,
      },
    ],
    'summary': {
      'total_days': 9,
      'present_days': 9,
      'absent_days': 0,
      'late_days': 1,
      'average_work_hours': 8.9,
    },
  };

  // ─── Dashboard Summary ──────────────────────────────
  static final dashboardSummary = DashboardSummary(
    assignmentSummary: const AssignmentSummary(
      total: 6,
      completed: 1,
      inProgress: 2,
      todo: 3,
      completionRate: 16.7,
    ),
    attendance: AttendanceStatus(
      status: 'on_duty',
      clockIn: DateTime(2026, 2, 13, 9, 2),
    ),
    recentNotices: [
      RecentNotice(
        id: 'mock-notice-4',
        title: '신메뉴 출시 안내',
        createdAt: DateTime(2026, 2, 12, 14, 0),
      ),
      RecentNotice(
        id: 'mock-notice-3',
        title: '연간 건강검진 안내',
        createdAt: DateTime(2026, 2, 10, 9, 0),
      ),
      RecentNotice(
        id: 'mock-notice-2',
        title: '시스템 업데이트 안내',
        createdAt: DateTime(2026, 2, 5, 10, 0),
      ),
    ],
  );

  // ─── Opinions ───────────────────────────────────────
  static final opinions = <Opinion>[
    Opinion(
      id: 'mock-opinion-1',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      content: '휴게실 정수기가 고장났습니다. 수리 요청드립니다.',
      status: 'in_review',
      createdAt: DateTime(2026, 2, 8, 11, 0),
    ),
    Opinion(
      id: 'mock-opinion-2',
      companyId: 'mock-company-1',
      userId: 'mock-user-3',
      content: '주차장 조명이 너무 어두워 안전사고 우려가 있습니다.',
      status: 'submitted',
      createdAt: DateTime(2026, 2, 10, 16, 30),
    ),
    Opinion(
      id: 'mock-opinion-3',
      companyId: 'mock-company-1',
      userId: 'mock-user-1',
      content: '유니폼 추가 지급 요청드립니다. 현재 2벌로는 부족합니다.',
      status: 'resolved',
      createdAt: DateTime(2026, 1, 20, 9, 0),
    ),
  ];

  // ─── Checklists ─────────────────────────────────────
  static final checklists = <DailyChecklist>[
    DailyChecklist(
      id: 'mock-checklist-1',
      templateId: 'mock-template-1',
      branchId: 'mock-branch-1',
      date: '2026-02-13',
      createdAt: DateTime(2026, 2, 13, 7, 0),
      items: const [
        ChecklistItem(content: '매장 조명 점검', verificationType: 'check', isCompleted: true, sortOrder: 0),
        ChecklistItem(content: '냉장/냉동고 온도 확인', verificationType: 'text', isCompleted: true, verificationData: '냉장: 4°C, 냉동: -18°C', sortOrder: 1),
        ChecklistItem(content: '화장실 청소 상태 확인', verificationType: 'photo', isCompleted: false, sortOrder: 2),
        ChecklistItem(content: 'POS 시스템 정상 작동 확인', verificationType: 'check', isCompleted: true, sortOrder: 3),
        ChecklistItem(content: '출입문 및 비상구 점검', verificationType: 'check', isCompleted: false, sortOrder: 4),
        ChecklistItem(content: '음향/BGM 설정', verificationType: 'check', isCompleted: true, sortOrder: 5),
      ],
    ),
    DailyChecklist(
      id: 'mock-checklist-2',
      templateId: 'mock-template-2',
      branchId: 'mock-branch-1',
      date: '2026-02-13',
      createdAt: DateTime(2026, 2, 13, 7, 0),
      items: const [
        ChecklistItem(content: '매출 정산 완료', verificationType: 'check', isCompleted: false, sortOrder: 0),
        ChecklistItem(content: '재고 실사 기록', verificationType: 'text', isCompleted: false, sortOrder: 1),
        ChecklistItem(content: '주방 청소 완료', verificationType: 'photo', isCompleted: false, sortOrder: 2),
        ChecklistItem(content: '전기/가스 차단 확인', verificationType: 'check', isCompleted: false, sortOrder: 3),
        ChecklistItem(content: '시건장치 확인', verificationType: 'check', isCompleted: false, sortOrder: 4),
      ],
    ),
  ];
}
