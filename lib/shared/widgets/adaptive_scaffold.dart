import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../theme/app_colors.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget child;

  const AdaptiveScaffold({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/notices')) return 2;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/tasks');
      case 2:
        context.go('/notices');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final currentIndex = _currentIndex(context);

    if (width >= AppConstants.mobileBreakpoint) {
      return _buildWithNavigationRail(context, currentIndex, width >= AppConstants.tabletBreakpoint);
    }

    return _buildWithBottomNav(context, currentIndex);
  }

  Widget _buildWithBottomNav(BuildContext context, int currentIndex) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onDestinationSelected(context, index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l10n.nav_home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_outlined),
            activeIcon: const Icon(Icons.assignment),
            label: l10n.nav_tasks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.campaign_outlined),
            activeIcon: const Icon(Icons.campaign),
            label: l10n.nav_notices,
          ),
        ],
      ),
    );
  }

  Widget _buildWithNavigationRail(BuildContext context, int currentIndex, bool extended) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => _onDestinationSelected(context, index),
            extended: extended,
            backgroundColor: Colors.white,
            selectedIconTheme: const IconThemeData(color: AppColors.primary),
            selectedLabelTextStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
            unselectedIconTheme: const IconThemeData(color: AppColors.textTertiary),
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: Text(l10n.nav_home),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.assignment_outlined),
                selectedIcon: const Icon(Icons.assignment),
                label: Text(l10n.nav_tasks),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.campaign_outlined),
                selectedIcon: const Icon(Icons.campaign),
                label: Text(l10n.nav_notices),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
