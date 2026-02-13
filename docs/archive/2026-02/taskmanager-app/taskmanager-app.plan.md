# Plan: TaskManager Flutter App

## 1. Overview
Flutter-based TaskManager application for staff management. Supports mobile (iOS/Android) and web platforms with responsive design. Based on V2 API specification and existing prototype.

## 2. Goals
- Production-ready staff task management app
- Clean Architecture for maintainability and scalability
- Seamless multi-platform experience (mobile + web)
- Robust error handling for free-tier server latency
- Migration-ready design (Render/Supabase -> AWS)

## 3. Feature Scope

### 3.1 Auth (Priority: Critical)
- Login (login_id + password)
- Signup (multi-step: terms -> info input -> email verify -> complete)
- Logout
- Token management (access/refresh JWT)
- Email verification (6-digit code)
- Auto-refresh on token expiry

### 3.2 Assignments (Priority: Critical)
- List assignments (filter by status, branch)
- My assignments view
- Assignment detail (with assignees & comments)
- Create/Update/Delete assignments
- Status updates (todo -> in_progress -> done)
- Assignee management (add/remove)
- Comments with multimedia attachments

### 3.3 Daily Checklists (Priority: High)
- List checklists by branch & date
- Checklist detail with items
- Generate checklist from template
- Update item completion (with photo verification)

### 3.4 Notices (Priority: High)
- List notices (company-scoped)
- Notice detail view
- Confirm notice (read receipt)
- Create/Update/Delete (manager+ role)

### 3.5 Dashboard (Priority: High)
- Assignment summary (total/completed/in_progress/todo)
- Attendance status
- Recent notices preview

### 3.6 Attendance (Priority: Medium)
- Today's attendance status
- Clock-in / Clock-out
- Monthly history with summary

### 3.7 Opinions (Priority: Medium)
- Submit opinion from home screen
- My opinions list

### 3.8 Notifications (Priority: Medium)
- Notification list with unread count
- Mark as read (single/all)
- Badge indicator on app bar

### 3.9 User Profile (Priority: Medium)
- View/Edit profile (name, image, language)
- Change password

### 3.10 File Management (Priority: Low)
- File upload (multipart/form-data)
- Presigned URL for secure access
- Used within comments and checklists

## 4. Excluded Scope
- Admin features (staff approval, company/brand/branch management, templates, feedbacks, compliance dashboard)
- Push notifications (FCM/APNs)
- Offline-first mode (cache-only, not full offline)
- Dark theme (future enhancement)

## 5. Technical Stack
| Category | Technology |
|----------|-----------|
| Framework | Flutter (latest stable) |
| State Management | Riverpod (flutter_riverpod) |
| HTTP Client | Dio (with interceptors) |
| Routing | GoRouter |
| Local Storage | Hive (general cache), flutter_secure_storage (tokens) |
| Architecture | Clean Architecture (Data/Domain/Presentation) |
| Fonts | Google Fonts (Noto Sans KR) |
| Date/Time | intl |

## 6. Non-Functional Requirements
- **Loading UX**: Shimmer placeholders + Spinner for actions
- **Splash Screen**: App initialization with token check
- **Error Handling**: Timeout (30s), Retry with exponential backoff (3 attempts)
- **Caching**: API responses cached in Hive with TTL
- **Responsive**: LayoutBuilder-based breakpoints (mobile < 600, tablet < 1200, desktop >= 1200)
- **Adaptive Navigation**: BottomNavBar (mobile) / NavigationRail (tablet/desktop)

## 7. Screen Map (from Prototype)
| Screen | Route | Description |
|--------|-------|-------------|
| Splash | / (initial) | Token check + server warm-up |
| Login | /login | login_id + password |
| Signup | /signup | 4-step wizard |
| Home | / | Dashboard + Quick menu + Notices |
| Task List | /tasks | My assignments list |
| Task Detail | /tasks/:id | Assignment detail with comments |
| Notice List | /notices | Company notices |
| Notice Detail | /notices/:id | Notice content + confirm |
| Notifications | /notifications | All notifications |
| My Page | /mypage | Profile + settings |
| Attendance | /attendance | Clock in/out + history |
| Daily Checklist | /checklists | Checklist by date |

## 8. Development Phases
1. **Phase 1**: Project setup + Core infrastructure (Dio, Hive, theme, routing)
2. **Phase 2**: Auth flow (login, signup, token management)
3. **Phase 3**: Home + Dashboard + Navigation shell
4. **Phase 4**: Assignments (list, detail, CRUD, comments)
5. **Phase 5**: Notices + Notifications
6. **Phase 6**: Attendance + Daily Checklists + Opinions
7. **Phase 7**: Profile + File management
8. **Phase 8**: Responsive layout + Polish + Testing

## 9. Risk & Mitigation
| Risk | Mitigation |
|------|-----------|
| Server cold start (free tier) | Splash screen + retry logic + Hive cache |
| Large API surface | Modular feature implementation |
| Cross-platform inconsistency | Responsive breakpoints + adaptive widgets |
| Token expiration mid-use | Dio interceptor for auto-refresh |

## 10. Success Criteria
- All 10 user-facing API domains integrated
- Prototype-matching UI on mobile
- Responsive layout working on tablet/web
- Error states handled gracefully
- Cache providing snappy experience on slow network
