# Plan: i18n-multilingual

## 1. Overview

TaskManager Flutter 앱에 다국어(i18n) 지원을 추가합니다.
로그인 화면에 언어 선택 기능을 제공하고, 앱 전체의 하드코딩된 한국어 텍스트를 3개 언어(영어, 한국어, 스페인어)로 번역 지원합니다.

## 2. Goals

| # | Goal | Priority |
|---|------|----------|
| G1 | 로그인 화면에서 언어 선택 가능 (EN/KO/ES) | P0 |
| G2 | 전체 앱 컴포넌트 및 텍스트 i18n 지원 | P0 |
| G3 | 선택된 언어 설정 로컬 저장 (앱 재시작 시 유지) | P0 |
| G4 | 런타임 언어 전환 (앱 재시작 없이) | P1 |

## 3. Scope

### 3.1 In Scope

- Flutter 공식 localization 시스템 적용 (`flutter_localizations` + `flutter_gen_l10n`)
- ARB(Application Resource Bundle) 파일 기반 번역 관리
- 로그인 화면 언어 선택 UI (드롭다운/버튼)
- 26개 Dart 파일의 하드코딩 한국어 텍스트 추출 및 i18n 키 교체
- Hive를 활용한 언어 설정 영속 저장
- Riverpod 기반 locale 상태 관리

### 3.2 Out of Scope

- 서버 사이드 언어 설정 동기화
- 추가 언어 (3개 외)
- RTL(Right-to-Left) 레이아웃 지원
- 번역 품질 검증 자동화

## 4. Feature Scope

### Feature 1: 로그인 화면 언어 선택기

| 항목 | 내용 |
|------|------|
| **위치** | 로그인 화면 상단 또는 우측 상단 |
| **UI** | 국기 아이콘 + 언어명 드롭다운 |
| **지원 언어** | English (EN), 한국어 (KO), Español (ES) |
| **기본 언어** | 기기 시스템 언어 기반 자동 감지 (미지원 시 영어) |
| **저장** | Hive box에 locale 코드 저장 |

### Feature 2: 전체 앱 i18n 지원

| 항목 | 내용 |
|------|------|
| **대상 파일** | 26개 Dart 파일 (10개 feature 모듈 + shared + core) |
| **방식** | Flutter gen_l10n + ARB 파일 |
| **키 규칙** | `featureName_contextDescription` (예: `login_titleUsername`) |
| **번역 파일** | `lib/l10n/app_en.arb`, `app_ko.arb`, `app_es.arb` |

## 5. Affected Files (26 files)

### Auth Module (6 files)
- `lib/features/auth/presentation/screens/login_screen.dart`
- `lib/features/auth/presentation/screens/signup/signup_screen.dart`
- `lib/features/auth/presentation/screens/signup/info_input_step.dart`
- `lib/features/auth/presentation/screens/signup/complete_step.dart`
- `lib/features/auth/presentation/screens/signup/email_verify_step.dart`
- `lib/features/auth/presentation/screens/signup/terms_step.dart`

### Feature Modules (11 files)
- `lib/features/assignment/presentation/screens/assignment_detail_screen.dart`
- `lib/features/assignment/presentation/screens/assignment_list_screen.dart`
- `lib/features/assignment/presentation/widgets/assignment_card.dart`
- `lib/features/assignment/presentation/widgets/comment_bubble.dart`
- `lib/features/attendance/presentation/screens/attendance_screen.dart`
- `lib/features/checklist/presentation/screens/checklist_screen.dart`
- `lib/features/dashboard/presentation/screens/home_screen.dart`
- `lib/features/notice/presentation/screens/notice_detail_screen.dart`
- `lib/features/notice/presentation/screens/notice_list_screen.dart`
- `lib/features/notification/presentation/screens/notification_screen.dart`
- `lib/features/opinion/presentation/screens/opinion_screen.dart`

### User & Shared (5 files)
- `lib/features/user/presentation/screens/mypage_screen.dart`
- `lib/shared/widgets/priority_badge.dart`
- `lib/shared/widgets/empty_view.dart`
- `lib/shared/widgets/error_view.dart`
- `lib/shared/widgets/adaptive_scaffold.dart`

### Core (2 files)
- `lib/core/utils/validators.dart`
- `lib/core/utils/date_utils.dart`

### Provider (1 file)
- `lib/features/auth/presentation/providers/auth_provider.dart`

## 6. Technical Approach

### 6.1 Flutter Localization Stack

```
flutter_localizations (SDK)  ← 프레임워크 위젯 번역
flutter_gen_l10n              ← ARB → Dart 코드 자동 생성
intl (이미 설치됨)             ← 날짜/숫자 포맷
```

### 6.2 Architecture

```
┌─────────────────────────────────┐
│         MaterialApp.router       │
│  ├── localizationsDelegates     │
│  ├── supportedLocales           │
│  └── locale (from Provider)     │
├─────────────────────────────────┤
│      LocaleNotifier (Riverpod)  │
│  ├── currentLocale              │
│  ├── setLocale(Locale)          │
│  └── loadSavedLocale()          │
├─────────────────────────────────┤
│       Hive (Persistent)         │
│  └── settings box → locale_code │
└─────────────────────────────────┘
```

### 6.3 Implementation Order

1. 의존성 추가 (`flutter_localizations`)
2. ARB 파일 생성 (3개 언어)
3. `l10n.yaml` 설정
4. `LocaleNotifier` Provider 생성
5. `MaterialApp` 수정 (delegates, supportedLocales, locale)
6. 로그인 화면 언어 선택 UI 구현
7. 26개 파일의 하드코딩 텍스트를 i18n 키로 교체
8. 날짜 포맷 로케일 동적 적용

## 7. Non-Functional Requirements

| 항목 | 요구사항 |
|------|----------|
| **성능** | 언어 전환 시 100ms 이내 UI 갱신 |
| **저장** | 앱 재시작 후에도 선택 언어 유지 |
| **UX** | 언어 전환 시 앱 재시작 불필요 |
| **확장성** | 새 언어 추가 시 ARB 파일만 추가하면 됨 |

## 8. Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| 번역 누락 | 일부 텍스트 한국어로 남음 | Gap analysis로 누락 검증 |
| 텍스트 길이 차이 | UI 레이아웃 깨짐 | 긴 텍스트 기준으로 UI 여유 확보 |
| 복수형/성별 처리 | 번역 부정확 | intl MessageFormat 활용 |
| 날짜 포맷 | 언어별 다른 포맷 | `DateFormat` 로케일 파라미터 동적화 |

## 9. Development Phases

| Phase | Task | Assignee |
|-------|------|----------|
| Phase 1 | Core i18n 시스템 구축 (의존성, ARB, Provider) | Developer |
| Phase 2 | 로그인 화면 언어 선택 UI | Frontend |
| Phase 3 | 전체 컴포넌트 텍스트 추출 및 교체 | Developer + Frontend (병렬) |
| Phase 4 | Gap Analysis & 번역 검증 | QA |
