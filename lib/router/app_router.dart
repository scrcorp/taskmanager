import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup/signup_screen.dart';
import '../features/dashboard/presentation/screens/home_screen.dart';
import '../features/assignment/presentation/screens/assignment_list_screen.dart';
import '../features/assignment/presentation/screens/assignment_detail_screen.dart';
import '../features/notice/presentation/screens/notice_list_screen.dart';
import '../features/notice/presentation/screens/notice_detail_screen.dart';
import '../features/notification/presentation/screens/notification_screen.dart';
import '../features/user/presentation/screens/mypage_screen.dart';
import '../features/checklist/presentation/screens/checklist_screen.dart';
import '../features/opinion/presentation/screens/opinion_screen.dart';
import '../shared/widgets/adaptive_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class _RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  _RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authProvider);
    final isAuthenticated = authState.isAuthenticated;
    final isSplash = state.matchedLocation == '/splash';
    final isLoginRoute = state.matchedLocation == '/login';
    final isSignupRoute = state.matchedLocation == '/signup';

    if (isSplash) return null;

    if (!isAuthenticated && !isLoginRoute && !isSignupRoute) {
      return '/login';
    }
    if (isAuthenticated && (isLoginRoute || isSignupRoute)) {
      return '/';
    }
    return null;
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AdaptiveScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const AssignmentListScreen(),
          ),
          GoRoute(
            path: '/notices',
            builder: (context, state) => const NoticeListScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/tasks/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => AssignmentDetailScreen(
          assignmentId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/notices/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => NoticeDetailScreen(
          noticeId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: '/mypage',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MyPageScreen(),
      ),
      GoRoute(
        path: '/attendance',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Attendance')),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.construction_rounded, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  '준비중입니다',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Coming Soon',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/checklists',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ChecklistScreen(),
      ),
      GoRoute(
        path: '/opinion',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OpinionScreen(),
      ),
    ],
  );
});
