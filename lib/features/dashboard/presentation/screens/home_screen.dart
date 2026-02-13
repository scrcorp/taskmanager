import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/common_app_bar.dart';
import '../../../../shared/widgets/app_shimmer.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final user = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.nav_home, showProfile: true),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardProvider),
        child: dashboardAsync.when(
          loading: () => const ShimmerList(itemCount: 4, itemHeight: 100),
          error: (e, _) => ErrorView(
            message: l10n.home_errorLoad,
            onRetry: () => ref.invalidate(dashboardProvider),
          ),
          data: (summary) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Status chips
              _StatusChipsRow(summary: summary),
              const SizedBox(height: 16),

              // Alert card
              if (summary.assignmentSummary.todo > 0) ...[
                _AlertCard(todoCount: summary.assignmentSummary.todo),
                const SizedBox(height: 16),
              ],

              // Task summary card
              _TaskSummaryCard(
                userName: user?.fullName ?? '',
                summary: summary.assignmentSummary,
              ),
              const SizedBox(height: 16),

              // Profile section
              _ProfileSection(
                userName: user?.fullName ?? '',
                role: user?.role ?? '',
              ),
              const SizedBox(height: 20),

              // Quick menu grid
              const _QuickMenuGrid(),
              const SizedBox(height: 20),

              // Opinion input section
              const _OpinionInputSection(),
              const SizedBox(height: 20),

              // Recent notices
              _RecentNoticesSection(notices: summary.recentNotices),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChipsRow extends StatelessWidget {
  final dynamic summary;

  const _StatusChipsRow({required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final assignmentSummary = summary.assignmentSummary;
    return Row(
      children: [
        _StatusChip(
          label: l10n.home_pendingTasks,
          count: assignmentSummary.todo,
          color: AppColors.warning,
        ),
        const SizedBox(width: 8),
        _StatusChip(
          label: l10n.priority_urgent,
          count: assignmentSummary.inProgress,
          color: AppColors.error,
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatusChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$label $count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final int todoCount;

  const _AlertCard({required this.todoCount});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppColors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.home_unprocessedTasks(todoCount),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskSummaryCard extends StatelessWidget {
  final String userName;
  final dynamic summary;

  const _TaskSummaryCard({required this.userName, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF7BB8E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.home_userTasks(userName),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TaskCountItem(label: l10n.home_taskTotal, count: summary.total),
              _TaskCountItem(label: l10n.status_inProgress, count: summary.inProgress),
              _TaskCountItem(label: l10n.status_done, count: summary.completed),
              _TaskCountItem(label: l10n.home_taskPending, count: summary.todo),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: summary.completionRate / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              l10n.home_completionRate(summary.completionRate.toStringAsFixed(0)),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCountItem extends StatelessWidget {
  final String label;
  final int count;

  const _TaskCountItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String userName;
  final String role;

  const _ProfileSection({required this.userName, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryContainer,
            child: Icon(Icons.person, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickMenuGrid extends StatelessWidget {
  const _QuickMenuGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final items = [
      _QuickMenuItem(
        icon: Icons.access_time_rounded,
        label: l10n.attendance_title,
        color: AppColors.primary,
        onTap: () => context.push('/attendance'),
      ),
      _QuickMenuItem(
        icon: Icons.checklist_rounded,
        label: l10n.checklist_title,
        color: AppColors.success,
        onTap: () => context.push('/checklists'),
      ),
      _QuickMenuItem(
        icon: Icons.chat_bubble_outline_rounded,
        label: l10n.home_sendOpinion,
        color: AppColors.warning,
        onTap: () => context.push('/opinion'),
      ),
      _QuickMenuItem(
        icon: Icons.notifications_outlined,
        label: l10n.notification_title,
        color: AppColors.error,
        onTap: () => context.push('/notifications'),
      ),
    ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.85,
      children: items
          .map((item) => GestureDetector(
                onTap: item.onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child:
                          Icon(item.icon, color: item.color, size: 26),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _QuickMenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickMenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _OpinionInputSection extends StatelessWidget {
  const _OpinionInputSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.home_sendOpinion,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => context.push('/opinion'),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.edit_outlined,
                    size: 18, color: AppColors.textTertiary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.home_opinionPlaceholder,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RecentNoticesSection extends StatelessWidget {
  final List<dynamic> notices;

  const _RecentNoticesSection({required this.notices});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.home_recentNotices,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/notices'),
              child: Text(
                l10n.home_viewMore,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (notices.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                l10n.home_noRecentNotices,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          )
        else
          ...notices.map((notice) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: GestureDetector(
                  onTap: () => context.push('/notices/${notice.id}'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.campaign_outlined,
                            size: 18, color: AppColors.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            notice.title,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppDateUtils.formatRelative(notice.createdAt, l10n),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
      ],
    );
  }
}
