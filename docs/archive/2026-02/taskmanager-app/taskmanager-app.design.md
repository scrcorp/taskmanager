# Design: TaskManager Flutter App

## 1. Architecture Overview

```
┌─────────────────────────────────────────────────┐
│                 Presentation Layer               │
│  ┌──────────┐  ┌───────────┐  ┌──────────────┐ │
│  │  Screens  │  │ Providers │  │   Widgets    │ │
│  │ (GoRouter)│  │(Riverpod) │  │  (Reusable)  │ │
│  └──────────┘  └───────────┘  └──────────────┘ │
├─────────────────────────────────────────────────┤
│                  Domain Layer                    │
│  ┌──────────┐  ┌───────────┐  ┌──────────────┐ │
│  │ Entities  │  │ Usecases  │  │ Repositories │ │
│  │  (Models) │  │ (Business)│  │ (Interfaces) │ │
│  └──────────┘  └───────────┘  └──────────────┘ │
│              (No external dependencies)          │
├─────────────────────────────────────────────────┤
│                   Data Layer                     │
│  ┌──────────┐  ┌───────────┐  ┌──────────────┐ │
│  │   DTOs    │  │   Remote  │  │    Local     │ │
│  │  (JSON)   │  │(Dio/API)  │  │  (Hive)      │ │
│  └──────────┘  └───────────┘  └──────────────┘ │
└─────────────────────────────────────────────────┘
```

## 2. Project Structure

```
lib/
├── main.dart                          # Entry point
├── app.dart                           # MaterialApp.router setup
├── core/
│   ├── config/
│   │   ├── app_config.dart            # Environment config (baseUrl, etc.)
│   │   └── hive_config.dart           # Hive initialization
│   ├── constants/
│   │   ├── api_endpoints.dart         # API path constants
│   │   └── app_constants.dart         # App-wide constants
│   ├── network/
│   │   ├── dio_client.dart            # Dio singleton with interceptors
│   │   ├── auth_interceptor.dart      # Token attach + auto-refresh
│   │   ├── retry_interceptor.dart     # Exponential backoff retry
│   │   ├── cache_interceptor.dart     # Hive-based response cache
│   │   └── api_response.dart          # Generic API response wrapper
│   ├── error/
│   │   ├── exceptions.dart            # Custom exceptions
│   │   └── failures.dart              # Failure classes for domain layer
│   ├── storage/
│   │   ├── token_storage.dart         # Secure token storage
│   │   └── cache_storage.dart         # Hive cache manager
│   └── utils/
│       ├── date_utils.dart            # Date formatting
│       └── validators.dart            # Input validators
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   ├── login_request.dart
│   │   │   │   ├── signup_request.dart
│   │   │   │   └── token_response.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       └── screens/
│   │           ├── login_screen.dart
│   │           ├── signup/
│   │           │   ├── signup_screen.dart
│   │           │   ├── terms_step.dart
│   │           │   ├── info_input_step.dart
│   │           │   ├── email_verify_step.dart
│   │           │   └── complete_step.dart
│   │           └── splash_screen.dart
│   ├── assignment/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── assignment_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── assignment_model.dart
│   │   │   │   ├── comment_model.dart
│   │   │   │   └── assignee_model.dart
│   │   │   └── repositories/
│   │   │       └── assignment_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── assignment.dart
│   │   │   │   └── comment.dart
│   │   │   └── repositories/
│   │   │       └── assignment_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── assignment_provider.dart
│   │       ├── screens/
│   │       │   ├── assignment_list_screen.dart
│   │       │   └── assignment_detail_screen.dart
│   │       └── widgets/
│   │           ├── assignment_card.dart
│   │           ├── comment_bubble.dart
│   │           └── priority_badge.dart
│   ├── checklist/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── checklist_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── daily_checklist_model.dart
│   │   │   └── repositories/
│   │   │       └── checklist_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── daily_checklist.dart
│   │   │   └── repositories/
│   │   │       └── checklist_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── checklist_provider.dart
│   │       └── screens/
│   │           └── checklist_screen.dart
│   ├── notice/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── notice_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── notice_model.dart
│   │   │   └── repositories/
│   │   │       └── notice_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── notice.dart
│   │   │   └── repositories/
│   │   │       └── notice_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── notice_provider.dart
│   │       └── screens/
│   │           ├── notice_list_screen.dart
│   │           └── notice_detail_screen.dart
│   ├── dashboard/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── dashboard_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── dashboard_model.dart
│   │   │   └── repositories/
│   │   │       └── dashboard_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── dashboard_summary.dart
│   │   │   └── repositories/
│   │   │       └── dashboard_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── dashboard_provider.dart
│   │       └── screens/
│   │           └── home_screen.dart
│   ├── attendance/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── attendance_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── attendance_model.dart
│   │   │   └── repositories/
│   │   │       └── attendance_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── attendance_record.dart
│   │   │   └── repositories/
│   │   │       └── attendance_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── attendance_provider.dart
│   │       └── screens/
│   │           └── attendance_screen.dart
│   ├── opinion/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── opinion_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── opinion_model.dart
│   │   │   └── repositories/
│   │   │       └── opinion_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── opinion.dart
│   │   │   └── repositories/
│   │   │       └── opinion_repository.dart
│   │   └── presentation/
│   │       └── providers/
│   │           └── opinion_provider.dart
│   ├── notification/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── notification_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── notification_model.dart
│   │   │   └── repositories/
│   │   │       └── notification_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── app_notification.dart
│   │   │   └── repositories/
│   │   │       └── notification_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── notification_provider.dart
│   │       └── screens/
│   │           └── notification_screen.dart
│   ├── user/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── user_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── user_repository_impl.dart
│   │   ├── domain/
│   │   │   └── repositories/
│   │   │       └── user_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── user_provider.dart
│   │       └── screens/
│   │           └── mypage_screen.dart
│   └── file/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── file_remote_datasource.dart
│       │   └── repositories/
│       │       └── file_repository_impl.dart
│       └── domain/
│           └── repositories/
│               └── file_repository.dart
├── shared/
│   ├── widgets/
│   │   ├── adaptive_scaffold.dart     # Responsive shell (BottomNav/NavRail)
│   │   ├── app_shimmer.dart           # Shimmer loading placeholder
│   │   ├── common_app_bar.dart        # Reusable app bar
│   │   ├── error_view.dart            # Error state widget
│   │   ├── empty_view.dart            # Empty state widget
│   │   ├── loading_overlay.dart       # Full-screen loading
│   │   └── responsive_builder.dart    # Breakpoint-based builder
│   ├── providers/
│   │   └── connectivity_provider.dart # Network status
│   └── theme/
│       ├── app_theme.dart             # Theme data
│       └── app_colors.dart            # Color constants
└── router/
    └── app_router.dart                # GoRouter configuration
```

## 3. Core Infrastructure Design

### 3.1 Dio Client
```dart
// Interceptor chain order:
// 1. AuthInterceptor - attach Bearer token, handle 401 -> refresh
// 2. RetryInterceptor - exponential backoff (3 retries, 1s/2s/4s)
// 3. CacheInterceptor - Hive-based GET response cache (5min TTL)
// 4. LogInterceptor - debug logging

// Config:
// - connectTimeout: 15s
// - receiveTimeout: 30s
// - Base URL from AppConfig (environment-specific)
```

### 3.2 Token Management
```dart
// TokenStorage (flutter_secure_storage):
// - saveTokens(access, refresh)
// - getAccessToken() -> String?
// - getRefreshToken() -> String?
// - clearTokens()

// AuthInterceptor flow:
// 1. Attach access_token to all requests
// 2. On 401 -> attempt refresh with refresh_token
// 3. On refresh success -> retry original request
// 4. On refresh failure -> clear tokens, redirect to login
```

### 3.3 Cache Strategy
```dart
// HiveCacheManager:
// - Key: "${method}_${path}_${queryHash}"
// - Value: { data, timestamp, ttl }
// - Default TTL: 5 minutes (GET only)
// - Force refresh: pull-to-refresh clears cache for that endpoint
// - Startup: serve cached data immediately, then fetch fresh data
```

### 3.4 Environment Config
```dart
// AppConfig:
// - dev:  https://task-server-xxx.onrender.com/api/v1
// - prod: (future AWS URL)
// - Configurable via --dart-define or .env
```

## 4. State Management (Riverpod)

### Pattern: AsyncNotifier per feature
```dart
// Provider types used:
// - StateNotifierProvider: Auth state (user, isAuthenticated)
// - AsyncNotifierProvider: Data fetching (assignments, notices, etc.)
// - FutureProvider: Simple one-shot reads (dashboard, attendance/today)
// - Provider: Computed/derived values (filtered lists, counts)

// Auth state flows through all providers via ref.watch(authProvider)
```

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| authProvider | StateNotifier | Auth state (user, tokens, isAuth) |
| assignmentListProvider | AsyncNotifier | Assignments list with filters |
| assignmentDetailProvider | Family AsyncNotifier | Single assignment by ID |
| noticeListProvider | AsyncNotifier | Notices list |
| dashboardProvider | FutureProvider | Dashboard summary |
| attendanceProvider | AsyncNotifier | Today + history |
| notificationProvider | AsyncNotifier | Notifications + unread count |
| checklistProvider | AsyncNotifier | Daily checklists |
| opinionProvider | AsyncNotifier | Opinions list |

## 5. Routing Design (GoRouter)

```
/ (redirect -> /login or /home based on auth)
├── /login
├── /signup
├── /home (ShellRoute with AdaptiveScaffold)
│   ├── / (HomeScreen - Dashboard)
│   ├── /tasks (AssignmentListScreen)
│   └── /notices (NoticeListScreen)
├── /tasks/:id (AssignmentDetailScreen)
├── /notices/:id (NoticeDetailScreen)
├── /notifications (NotificationScreen)
├── /mypage (MyPageScreen)
├── /attendance (AttendanceScreen)
└── /checklists (ChecklistScreen)
```

## 6. Responsive Design

### Breakpoints
| Size | Width | Navigation | Layout |
|------|-------|-----------|--------|
| Mobile | < 600px | BottomNavigationBar | Single column |
| Tablet | 600-1199px | NavigationRail | Two column (list-detail) |
| Desktop | >= 1200px | NavigationRail (expanded) | Three column |

### AdaptiveScaffold
- Mobile: Standard Scaffold + BottomNav
- Tablet: Row[NavigationRail, Expanded(content)]
- Desktop: Row[NavigationRail(extended), Expanded(content), Expanded(detail)]

## 7. UI Component Design

### Shared Widgets
| Widget | Purpose |
|--------|---------|
| AdaptiveScaffold | Responsive navigation shell |
| AppShimmer | Shimmer loading for lists/cards |
| CommonAppBar | Consistent app bar with notification badge |
| ErrorView | Error state with retry button |
| EmptyView | Empty state with illustration |
| LoadingOverlay | Action progress overlay |
| PriorityBadge | Urgent/Normal/Low badge |
| AssignmentCard | Assignment list item |
| CommentBubble | Chat-style comment (left/right aligned) |

### Theme (from Prototype)
- Primary: #5B9BD5
- Secondary: #7EC8C8
- Urgent: #FF6B6B
- Normal: #FFB84D
- Low: #51CF66
- Surface: #F8F9FA
- Font: Noto Sans KR (Google Fonts)

## 8. API Integration Map

| Feature | Endpoints | Cache |
|---------|----------|-------|
| Auth | POST login, signup, logout, refresh, verify-email, resend | No |
| Auth | GET me | 1min |
| Assignments | GET list, my, {id} | 5min |
| Assignments | POST/PATCH/DELETE CRUD | Invalidate |
| Comments | GET/POST/DELETE | No cache |
| Checklists | GET list, {id} | 5min |
| Checklists | POST generate, PATCH item | Invalidate |
| Notices | GET list, {id} | 5min |
| Notices | POST confirm/create/update/delete | Invalidate |
| Dashboard | GET summary | 2min |
| Attendance | GET today, history | 1min |
| Attendance | POST clock-in/out | Invalidate |
| Opinions | GET list, POST create | No cache |
| Notifications | GET list | 1min |
| Notifications | PATCH read, read-all | Invalidate |
| Users | GET/PATCH profile, POST password | No cache |
| Files | POST upload, presigned-url, DELETE | No cache |

## 9. Error Handling Strategy

```
API Error Flow:
  DioException
    ├── connectionTimeout → RetryInterceptor (3x backoff)
    ├── receiveTimeout → RetryInterceptor (3x backoff)
    ├── 401 → AuthInterceptor (refresh token attempt)
    ├── 400 → Parse "detail" → Show user-friendly message
    ├── 403 → "Access denied" message
    ├── 404 → "Not found" message
    ├── 413 → "File too large" message
    ├── 429 → "Too many requests" with countdown
    └── 500 → Generic error with retry option

UI Error States:
  - Inline: SnackBar for action failures
  - Full-page: ErrorView for data loading failures
  - Dialog: Confirmation for destructive actions
```

## 10. Implementation Order

### Phase 1: Core (Task #3)
1. Flutter project creation + pubspec.yaml
2. Directory structure
3. AppConfig + environment setup
4. DioClient + interceptors
5. TokenStorage + CacheStorage
6. Theme + shared widgets
7. GoRouter skeleton
8. Splash screen

### Phase 2: Auth (Task #4)
1. User entity + model
2. Auth datasource + repository
3. Auth provider (StateNotifier)
4. Login screen
5. Signup screens (4 steps)
6. Router auth redirect

### Phase 3: Assignments + Checklists (Task #5)
1. Assignment/Comment entities + models
2. Assignment datasource + repository
3. Assignment providers
4. Assignment list screen + card widget
5. Assignment detail screen + comments
6. Checklist entities + data layer
7. Checklist screen

### Phase 4: Notices + Dashboard + Others (Task #6)
1. Notice entity + data layer
2. Notice screens
3. Dashboard entity + data layer + home screen
4. Attendance entity + data layer + screen
5. Opinion entity + data layer
6. Notification entity + data layer + screen
7. User profile + mypage screen
8. File upload service

### Phase 5: Responsive + Polish (Task #7)
1. AdaptiveScaffold implementation
2. Responsive breakpoint testing
3. Shimmer loading states
4. Error/Empty states
5. Pull-to-refresh
6. Navigation polish
