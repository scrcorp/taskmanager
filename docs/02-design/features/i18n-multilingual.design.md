# Design: i18n-multilingual

## 1. Architecture Overview

```
┌──────────────────────────────────────────────────┐
│                  MaterialApp.router                │
│  ├── localizationsDelegates:                      │
│  │   ├── AppLocalizations.delegate                │
│  │   ├── GlobalMaterialLocalizations.delegate     │
│  │   ├── GlobalWidgetsLocalizations.delegate      │
│  │   └── GlobalCupertinoLocalizations.delegate    │
│  ├── supportedLocales: [en, ko, es]               │
│  └── locale: ref.watch(localeProvider)            │
├──────────────────────────────────────────────────┤
│              LocaleNotifier (Riverpod)             │
│  ├── state: Locale                                │
│  ├── setLocale(Locale) → save to Hive             │
│  └── init() → load from Hive or system default    │
├──────────────────────────────────────────────────┤
│              Hive Storage                          │
│  └── settings box → 'locale_code' key             │
├──────────────────────────────────────────────────┤
│              ARB Files (l10n/)                      │
│  ├── app_en.arb (English - default)               │
│  ├── app_ko.arb (Korean)                          │
│  └── app_es.arb (Spanish)                         │
└──────────────────────────────────────────────────┘
```

## 2. Dependencies

### 2.1 pubspec.yaml 추가 사항

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  # intl: ^0.19.0  ← 이미 설치됨
```

### 2.2 l10n.yaml (프로젝트 루트에 생성)

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
nullable-getter: false
```

## 3. Provider Design

### 3.1 LocaleNotifier

**Path:** `lib/shared/providers/locale_provider.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  static const _boxName = 'settings';
  static const _key = 'locale_code';
  static const defaultLocale = Locale('ko');
  static const supportedLocales = [
    Locale('en'),
    Locale('ko'),
    Locale('es'),
  ];

  LocaleNotifier() : super(defaultLocale) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final box = Hive.box(_boxName);
    final code = box.get(_key, defaultValue: null);
    if (code != null && supportedLocales.any((l) => l.languageCode == code)) {
      state = Locale(code);
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    state = locale;
    final box = Hive.box(_boxName);
    await box.put(_key, locale.languageCode);
  }
}
```

## 4. App Configuration Changes

### 4.1 app.dart 수정

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen_l10n/app_localizations.dart';
import 'shared/providers/locale_provider.dart';
import 'shared/theme/app_theme.dart';
import 'router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'TaskManager',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
```

### 4.2 Hive settings box 초기화

`lib/core/config/hive_config.dart`에 settings box 오픈 추가:

```dart
await Hive.openBox('settings');
```

## 5. Login Screen Language Selector Design

### 5.1 UI Layout

```
┌──────────────────────────────────┐
│   [🇺🇸 EN ▼]          (우측 상단) │
│                                  │
│          🔵 TaskManager          │
│                                  │
│   ┌──────────────────────────┐   │
│   │ Username                 │   │
│   └──────────────────────────┘   │
│   ┌──────────────────────────┐   │
│   │ Password             👁  │   │
│   └──────────────────────────┘   │
│                                  │
│   ┌──────────────────────────┐   │
│   │          Login           │   │
│   └──────────────────────────┘   │
│                                  │
│   Don't have an account? Sign up │
└──────────────────────────────────┘
```

### 5.2 Language Selector Widget

**Path:** `lib/shared/widgets/language_selector.dart`

```dart
class LanguageSelector extends ConsumerWidget {
  // 국기 이모지 + 언어 코드 드롭다운
  // 선택 시 localeProvider.setLocale() 호출

  static const _languages = [
    _LanguageOption(locale: Locale('en'), flag: '🇺🇸', label: 'EN'),
    _LanguageOption(locale: Locale('ko'), flag: '🇰🇷', label: 'KO'),
    _LanguageOption(locale: Locale('es'), flag: '🇪🇸', label: 'ES'),
  ];
}
```

### 5.3 Login Screen 수정

- `SafeArea` → `Stack`으로 감싸서 우측 상단에 `LanguageSelector` 배치
- 모든 하드코딩 텍스트를 `AppLocalizations.of(context).keyName`으로 교체

## 6. Translation Key Structure

### 6.1 Key Naming Convention

```
{module}_{context}{Description}
```

예시:
- `login_labelUsername` → 로그인 화면의 아이디 라벨
- `common_buttonCancel` → 공통 취소 버튼
- `error_networkConnection` → 네트워크 연결 오류

### 6.2 Complete Translation Keys

#### Common (공통)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `appTitle` | TaskManager | TaskManager | TaskManager |
| `common_buttonCancel` | Cancel | 취소 | Cancelar |
| `common_buttonRetry` | Retry | 다시 시도 | Reintentar |
| `common_emptyData` | No data available | 데이터가 없습니다 | No hay datos |
| `common_errorOccurred` | An error occurred | 오류가 발생했습니다 | Ocurrio un error |
| `common_statusComplete` | Completed | 완료 | Completado |
| `common_statusInProgress` | In Progress | 진행중 | En Progreso |
| `common_statusPending` | Pending | 예정 | Pendiente |

#### Login (로그인)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `login_labelUsername` | Username | 아이디 | Usuario |
| `login_labelPassword` | Password | 비밀번호 | Contrasena |
| `login_buttonLogin` | Login | 로그인 | Iniciar Sesion |
| `login_noAccount` | Don't have an account? | 계정이 없으신가요? | No tienes una cuenta? |
| `login_buttonSignup` | Sign Up | 회원가입 | Registrarse |

#### Signup (회원가입)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `signup_title` | Sign Up ({step}/3) | 회원가입 ({step}/3) | Registro ({step}/3) |
| `signup_labelName` | Name | 이름 | Nombre |
| `signup_labelEmail` | Email | 이메일 | Correo |
| `signup_labelCompanyCode` | Company Code | 회사 코드 | Codigo de Empresa |
| `signup_labelPasswordConfirm` | Confirm Password | 비밀번호 확인 | Confirmar Contrasena |
| `signup_buttonSignup` | Sign Up | 가입하기 | Registrarse |
| `signup_buttonVerifyRequest` | Request Verification | 인증요청 | Solicitar Verificacion |
| `signup_buttonResend` | Resend | 재전송 | Reenviar |
| `signup_buttonVerified` | Verified | 인증완료 | Verificado |
| `signup_labelVerificationCode` | 6-digit code | 인증번호 6자리 | Codigo de 6 digitos |
| `signup_buttonVerify` | Verify | 인증하기 | Verificar |
| `signup_completeTitle` | Sign Up Complete! | 가입 완료! | Registro Completado! |
| `signup_completeMessage` | You can use the service after admin approval. | 관리자 승인 후 서비스를 이용하실 수 있습니다. | Podras usar el servicio despues de la aprobacion del administrador. |
| `signup_buttonGetStarted` | Get Started | 시작하기 | Comenzar |
| `signup_errorInvalidEmail` | Please enter a valid email | 올바른 이메일을 입력해주세요 | Ingrese un correo valido |
| `signup_successCodeSent` | Verification code sent | 인증번호가 전송되었습니다 | Codigo de verificacion enviado |
| `signup_errorSendFailed` | Failed to send. Please try again. | 전송에 실패했습니다. 다시 시도해주세요 | Error al enviar. Intente de nuevo. |
| `signup_errorInvalidCode` | Invalid verification code | 인증번호가 올바르지 않습니다 | Codigo de verificacion invalido |
| `signup_errorVerifyEmail` | Please verify your email | 이메일 인증을 완료해주세요 | Verifique su correo |
| `signup_errorPasswordMismatch` | Passwords do not match | 비밀번호가 일치하지 않습니다 | Las contrasenas no coinciden |
| `signup_successCodeResent` | Verification code resent | 인증번호가 재전송되었습니다 | Codigo reenviado |

#### Email Verify (이메일 인증)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `emailVerify_title` | Email Verification | 이메일 인증 | Verificacion de Correo |
| `emailVerify_description` | Enter the 6-digit code sent to {email} | {email}로 전송된\n6자리 인증번호를 입력해주세요. | Ingrese el codigo de 6 digitos enviado a {email} |
| `emailVerify_buttonResend` | Resend Code | 인증번호 재전송 | Reenviar Codigo |

#### Terms (이용약관)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `terms_title` | Terms of Service | 이용약관 | Terminos de Servicio |
| `terms_content` | (Full terms text) | (Full terms text) | (Full terms text) |
| `terms_agree` | I agree to the Terms of Service | 이용약관에 동의합니다 | Acepto los Terminos de Servicio |
| `terms_buttonNext` | Next | 다음 | Siguiente |
| `signup_sectionInfo` | Enter Information | 정보 입력 | Ingrese Informacion |

#### Assignment (업무)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `assignment_title` | My Tasks | 내 업무 | Mis Tareas |
| `assignment_detailTitle` | Task Detail | 업무 상세 | Detalle de Tarea |
| `assignment_errorLoad` | Could not load tasks | 업무 목록을 불러올 수 없습니다 | No se pudieron cargar las tareas |
| `assignment_errorLoadDetail` | Could not load task | 업무를 불러올 수 없습니다 | No se pudo cargar la tarea |
| `assignment_empty` | No tasks assigned | 배정된 업무가 없습니다 | No hay tareas asignadas |
| `assignment_labelDeadline` | Deadline | 마감일 | Fecha limite |
| `assignment_labelCreated` | Created | 생성일 | Creado |
| `assignment_labelAssignees` | Assignees | 담당자 | Asignados |
| `assignment_labelComments` | Comments ({count}) | 댓글 ({count}) | Comentarios ({count}) |
| `assignment_hintComment` | Write a comment... | 댓글을 입력하세요... | Escribe un comentario... |
| `assignment_assigneeCount` | {count} people | {count}명 | {count} personas |

#### Attendance (출퇴근)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `attendance_title` | Attendance | 출퇴근 | Asistencia |
| `attendance_errorLoad` | Could not load attendance info | 출퇴근 정보를 불러올 수 없습니다 | No se pudo cargar la asistencia |
| `attendance_clockIn` | Clock In Time | 출근 시간 | Hora de Entrada |
| `attendance_clockOut` | Clock Out Time | 퇴근 시간 | Hora de Salida |
| `attendance_successClockIn` | Clock in recorded | 출근 처리되었습니다 | Entrada registrada |
| `attendance_errorClockIn` | Failed to clock in: {error} | 출근 처리에 실패했습니다: {error} | Error al registrar entrada: {error} |
| `attendance_successClockOut` | Clock out recorded | 퇴근 처리되었습니다 | Salida registrada |
| `attendance_errorClockOut` | Failed to clock out: {error} | 퇴근 처리에 실패했습니다: {error} | Error al registrar salida: {error} |
| `attendance_statusBefore` | Before Clock In | 출근 전 | Antes de Entrada |
| `attendance_statusWorking` | Working | 근무 중 | Trabajando |
| `attendance_statusDone` | Clocked Out | 퇴근 완료 | Salida Completada |
| `attendance_workHours` | Work Hours | 근무 시간 | Horas de Trabajo |
| `attendance_durationHoursMinutes` | {hours}h {minutes}m | {hours}시간 {minutes}분 | {hours}h {minutes}m |
| `attendance_buttonClockIn` | Clock In | 출근하기 | Registrar Entrada |
| `attendance_buttonClockOut` | Clock Out | 퇴근하기 | Registrar Salida |

#### Checklist (체크리스트)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `checklist_title` | Daily Checklist | 일일 체크리스트 | Lista Diaria |
| `checklist_selectPlaceholder` | Please select a checklist | 체크리스트를 선택해주세요 | Seleccione una lista |

#### Dashboard (홈)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `dashboard_title` | Home | 홈 | Inicio |
| `dashboard_errorLoad` | Could not load data | 데이터를 불러올 수 없습니다 | No se pudieron cargar los datos |
| `dashboard_chipPending` | Pending | 대기 업무 | Pendientes |
| `dashboard_chipUrgent` | Urgent | 긴급 | Urgente |
| `dashboard_alertTodo` | You have {count} pending tasks. | 처리되지 않은 업무가 {count}건 있습니다. | Tienes {count} tareas pendientes. |
| `dashboard_userTasks` | {name}'s Tasks | {name}님의 업무 | Tareas de {name} |
| `dashboard_countAll` | All | 전체 | Todos |
| `dashboard_countProgress` | In Progress | 진행중 | En Progreso |
| `dashboard_countComplete` | Completed | 완료 | Completados |
| `dashboard_countPending` | Pending | 대기 | Pendientes |
| `dashboard_completionRate` | {rate}% Complete | {rate}% 완료 | {rate}% Completado |
| `dashboard_menuAttendance` | Attendance | 출퇴근 | Asistencia |
| `dashboard_menuChecklist` | Checklist | 체크리스트 | Lista |
| `dashboard_menuOpinion` | Send Opinion | 의견보내기 | Enviar Opinion |
| `dashboard_menuNotification` | Notifications | 알림 | Notificaciones |
| `dashboard_sectionOpinion` | Send Opinion | 의견 보내기 | Enviar Opinion |
| `dashboard_hintOpinion` | Enter your opinion or suggestion | 의견이나 건의사항을 입력해주세요 | Ingrese su opinion o sugerencia |
| `dashboard_sectionNotice` | Recent Notices | 최근 공지사항 | Avisos Recientes |
| `dashboard_buttonMore` | More | 더보기 | Ver mas |
| `dashboard_emptyNotice` | No recent notices | 최근 공지사항이 없습니다 | No hay avisos recientes |

#### Notice (공지사항)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `notice_title` | Notices | 공지사항 | Avisos |
| `notice_detailTitle` | Notice Detail | 공지 상세 | Detalle de Aviso |
| `notice_errorLoad` | Could not load notices | 공지사항을 불러올 수 없습니다 | No se pudieron cargar los avisos |
| `notice_errorLoadDetail` | Could not load notice | 공지를 불러올 수 없습니다 | No se pudo cargar el aviso |
| `notice_empty` | No notices | 공지사항이 없습니다 | No hay avisos |
| `notice_badgeImportant` | Important | 중요 | Importante |
| `notice_successConfirm` | Confirmed | 확인 처리되었습니다 | Confirmado |
| `notice_buttonConfirm` | Confirm | 확인 | Confirmar |

#### Notification (알림)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `notification_title` | Notifications | 알림 | Notificaciones |
| `notification_markAllRead` | Mark All Read | 모두 읽음 | Marcar Todo Leido |
| `notification_errorLoad` | Could not load notifications | 알림을 불러올 수 없습니다 | No se pudieron cargar las notificaciones |
| `notification_empty` | No notifications | 알림이 없습니다 | No hay notificaciones |

#### Opinion (건의사항)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `opinion_title` | Suggestions | 건의사항 | Sugerencias |
| `opinion_errorLoad` | Could not load suggestions | 건의사항을 불러올 수 없습니다 | No se pudieron cargar las sugerencias |
| `opinion_empty` | No suggestions | 등록된 건의사항이 없습니다 | No hay sugerencias |
| `opinion_hintInput` | Enter your suggestion... | 건의사항을 입력하세요... | Ingrese su sugerencia... |
| `opinion_statusDone` | Resolved | 처리완료 | Resuelto |
| `opinion_statusReview` | Under Review | 검토중 | En Revision |
| `opinion_statusReceived` | Received | 접수 | Recibido |

#### User / My Page (마이페이지)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `mypage_title` | My Page | 마이페이지 | Mi Pagina |
| `mypage_defaultName` | User | 사용자 | Usuario |
| `mypage_roleManager` | Manager | 매니저 | Gerente |
| `mypage_roleAdmin` | Admin | 관리자 | Admin |
| `mypage_roleEmployee` | Employee | 직원 | Empleado |
| `mypage_menuProfile` | Edit Profile | 프로필 수정 | Editar Perfil |
| `mypage_menuPassword` | Change Password | 비밀번호 변경 | Cambiar Contrasena |
| `mypage_menuLanguage` | Language Settings | 언어 설정 | Configuracion de Idioma |
| `mypage_menuAppInfo` | App Info | 앱 정보 | Info de la App |
| `mypage_menuLogout` | Logout | 로그아웃 | Cerrar Sesion |
| `mypage_logoutTitle` | Logout | 로그아웃 | Cerrar Sesion |
| `mypage_logoutConfirm` | Are you sure you want to logout? | 정말 로그아웃하시겠습니까? | Estas seguro de que quieres cerrar sesion? |

#### Comment (댓글)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `comment_defaultUser` | User | 사용자 | Usuario |
| `comment_badgeManager` | Manager | 매니저 | Gerente |

#### Priority (우선순위)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `priority_urgent` | Urgent | 긴급 | Urgente |
| `priority_normal` | Normal | 보통 | Normal |
| `priority_low` | Low | 낮음 | Baja |

#### Navigation (내비게이션)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `nav_home` | Home | 홈 | Inicio |
| `nav_tasks` | My Tasks | 내업무 | Mis Tareas |
| `nav_notices` | Notices | 공지사항 | Avisos |

#### Validators (검증)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `validator_emailRequired` | Please enter your email | 이메일을 입력해주세요 | Ingrese su correo |
| `validator_emailInvalid` | Invalid email format | 올바른 이메일 형식이 아닙니다 | Formato de correo invalido |
| `validator_loginIdRequired` | Please enter your username | 아이디를 입력해주세요 | Ingrese su usuario |
| `validator_loginIdMinLength` | Username must be at least 3 characters | 아이디는 3자 이상이어야 합니다 | El usuario debe tener al menos 3 caracteres |
| `validator_passwordRequired` | Please enter your password | 비밀번호를 입력해주세요 | Ingrese su contrasena |
| `validator_passwordMinLength` | Password must be at least 6 characters | 비밀번호는 6자 이상이어야 합니다 | La contrasena debe tener al menos 6 caracteres |
| `validator_fieldRequired` | Please enter {field} | {field}을(를) 입력해주세요 | Ingrese {field} |
| `validator_codeRequired` | Please enter verification code | 인증번호를 입력해주세요 | Ingrese el codigo de verificacion |
| `validator_codeLength` | Please enter 6-digit code | 6자리 인증번호를 입력해주세요 | Ingrese un codigo de 6 digitos |
| `validator_codeNumberOnly` | Numbers only | 숫자만 입력해주세요 | Solo numeros |

#### Date Utils (날짜)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `date_justNow` | Just now | 방금 전 | Justo ahora |
| `date_minutesAgo` | {minutes}m ago | {minutes}분 전 | Hace {minutes}m |
| `date_hoursAgo` | {hours}h ago | {hours}시간 전 | Hace {hours}h |
| `date_daysAgo` | {days}d ago | {days}일 전 | Hace {days}d |
| `date_durationHoursMinutes` | {hours}h {minutes}m | {hours}시간 {minutes}분 | {hours}h {minutes}m |
| `date_durationMinutes` | {minutes}m | {minutes}분 | {minutes}m |

#### API Errors (API 오류)
| Key | EN | KO | ES |
|-----|----|----|-----|
| `apiError_unknown` | An unknown error occurred | 알 수 없는 오류가 발생했습니다 | Ocurrio un error desconocido |
| `apiError_timeout` | Server response timed out. Please try again. | 서버 응답 시간이 초과되었습니다. 잠시 후 다시 시도해 주세요. | Tiempo de respuesta agotado. Intente mas tarde. |
| `apiError_noConnection` | Please check your network connection. | 네트워크 연결을 확인해 주세요. | Verifique su conexion de red. |
| `apiError_cancelled` | Request was cancelled. | 요청이 취소되었습니다. | Solicitud cancelada. |
| `apiError_network` | A network error occurred. | 네트워크 오류가 발생했습니다. | Ocurrio un error de red. |
| `apiError_badRequest` | Invalid request. | 잘못된 요청입니다. | Solicitud invalida. |
| `apiError_unauthorized` | Session expired. Please login again. | 인증이 만료되었습니다. 다시 로그인해 주세요. | Sesion expirada. Inicie sesion de nuevo. |
| `apiError_forbidden` | Access denied. | 접근 권한이 없습니다. | Acceso denegado. |
| `apiError_notFound` | Requested information not found. | 요청한 정보를 찾을 수 없습니다. | Informacion no encontrada. |
| `apiError_conflict` | Request conflict. | 요청이 충돌합니다. | Conflicto en la solicitud. |
| `apiError_fileTooLarge` | File size is too large. | 파일 크기가 너무 큽니다. | El archivo es demasiado grande. |
| `apiError_tooManyRequests` | Too many requests. Please try again later. | 요청이 너무 많습니다. 잠시 후 다시 시도해 주세요. | Demasiadas solicitudes. Intente mas tarde. |
| `apiError_server` | Server error. Please try again later. | 서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요. | Error del servidor. Intente mas tarde. |
| `apiError_default` | An error occurred. (Code: {code}) | 오류가 발생했습니다. (코드: {code}) | Ocurrio un error. (Codigo: {code}) |
| `auth_errorGeneric` | An error occurred | 오류가 발생했습니다 | Ocurrio un error |

## 7. Implementation Checklist

### Phase 1: Core i18n System (Developer)
- [ ] `pubspec.yaml`에 `flutter_localizations` 추가
- [ ] `lib/l10n/` 디렉토리 생성
- [ ] `l10n.yaml` 설정 파일 생성
- [ ] `app_en.arb` 생성 (기본 템플릿, 전체 키)
- [ ] `app_ko.arb` 생성
- [ ] `app_es.arb` 생성
- [ ] `lib/shared/providers/locale_provider.dart` 생성
- [ ] Hive settings box 초기화 (`hive_config.dart`)
- [ ] `app.dart` 수정 (delegates, supportedLocales, locale)
- [ ] `flutter gen-l10n` 실행 확인

### Phase 2: Login Language Selector (Frontend)
- [ ] `lib/shared/widgets/language_selector.dart` 생성
- [ ] `login_screen.dart`에 LanguageSelector 배치
- [ ] 로그인 화면 텍스트 i18n 키 교체

### Phase 3: Component Text Extraction (Developer + Frontend 병렬)
- [ ] Auth 모듈 (6 files) 텍스트 교체
- [ ] Assignment 모듈 (4 files) 텍스트 교체
- [ ] Attendance 모듈 (1 file) 텍스트 교체
- [ ] Checklist 모듈 (1 file) 텍스트 교체
- [ ] Dashboard 모듈 (1 file) 텍스트 교체
- [ ] Notice 모듈 (2 files) 텍스트 교체
- [ ] Notification 모듈 (1 file) 텍스트 교체
- [ ] Opinion 모듈 (1 file) 텍스트 교체
- [ ] User 모듈 (1 file) 텍스트 교체
- [ ] Shared widgets (4 files) 텍스트 교체
- [ ] Core utils (3 files) 텍스트 교체
- [ ] 날짜 포맷 로케일 동적 적용 (`date_utils.dart`)

### Phase 4: Verification (QA)
- [ ] 빌드 확인 (`flutter gen-l10n` + 컴파일)
- [ ] 언어 전환 동작 확인
- [ ] 모든 화면 번역 누락 검증
- [ ] ARB 파일 키 일관성 확인
