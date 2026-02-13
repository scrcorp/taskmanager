import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/common_app_bar.dart';
import '../../../../shared/widgets/app_shimmer.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../providers/attendance_provider.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(todayAttendanceProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.attendance_title, showBack: true),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(todayAttendanceProvider),
        child: attendanceAsync.when(
          loading: () => const ShimmerList(itemCount: 2, itemHeight: 120),
          error: (e, _) => ErrorView(
            message: l10n.attendance_errorLoad,
            onRetry: () => ref.invalidate(todayAttendanceProvider),
          ),
          data: (record) => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Date header
              Center(
                child: Text(
                  AppDateUtils.formatFullDate(DateTime.now(), locale: Localizations.localeOf(context).toString()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Status card
              _StatusCard(record: record),
              const SizedBox(height: 24),

              // Time info
              if (record != null) ...[
                _TimeInfoRow(
                  label: l10n.attendance_clockIn,
                  time: record.clockIn != null
                      ? AppDateUtils.formatTime(record.clockIn!)
                      : '--:--',
                  icon: Icons.login_rounded,
                  color: AppColors.success,
                ),
                const SizedBox(height: 12),
                _TimeInfoRow(
                  label: l10n.attendance_clockOut,
                  time: record.clockOut != null
                      ? AppDateUtils.formatTime(record.clockOut!)
                      : '--:--',
                  icon: Icons.logout_rounded,
                  color: AppColors.error,
                ),
                if (record.isCompleted && record.workHours != null) ...[
                  const SizedBox(height: 20),
                  _WorkHoursCard(workHours: record.workHours!),
                ],
                const SizedBox(height: 32),
              ],

              // Action button
              _ActionButton(
                record: record,
                onClockIn: () async {
                  try {
                    await ref
                        .read(attendanceRepositoryProvider)
                        .clockIn();
                    ref.invalidate(todayAttendanceProvider);
                    if (context.mounted) {
                      final l10n = AppLocalizations.of(context)!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.attendance_clockInSuccess)),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      final l10n = AppLocalizations.of(context)!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.attendance_clockInFail(e.toString()))),
                      );
                    }
                  }
                },
                onClockOut: () async {
                  try {
                    await ref
                        .read(attendanceRepositoryProvider)
                        .clockOut();
                    ref.invalidate(todayAttendanceProvider);
                    if (context.mounted) {
                      final l10n = AppLocalizations.of(context)!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.attendance_clockOutSuccess)),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      final l10n = AppLocalizations.of(context)!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.attendance_clockOutFail(e.toString()))),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final dynamic record;

  const _StatusCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String statusText;
    final Color statusColor;
    final IconData statusIcon;

    if (record == null) {
      statusText = l10n.attendance_statusBefore;
      statusColor = AppColors.textTertiary;
      statusIcon = Icons.schedule;
    } else if (record.isOnDuty) {
      statusText = l10n.attendance_statusOnDuty;
      statusColor = AppColors.success;
      statusIcon = Icons.work_rounded;
    } else if (record.isCompleted) {
      statusText = l10n.attendance_statusCompleted;
      statusColor = AppColors.primary;
      statusIcon = Icons.check_circle_outline;
    } else {
      statusText = record.status;
      statusColor = AppColors.textSecondary;
      statusIcon = Icons.info_outline;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, color: statusColor, size: 32),
          ),
          const SizedBox(height: 14),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeInfoRow extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;
  final Color color;

  const _TimeInfoRow({
    required this.label,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkHoursCard extends StatelessWidget {
  final double workHours;

  const _WorkHoursCard({required this.workHours});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hours = workHours.floor();
    final minutes = ((workHours - hours) * 60).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            l10n.attendance_workHours,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.date_hoursMinutes(hours, minutes),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final dynamic record;
  final VoidCallback onClockIn;
  final VoidCallback onClockOut;

  const _ActionButton({
    required this.record,
    required this.onClockIn,
    required this.onClockOut,
  });

  @override
  Widget build(BuildContext context) {
    if (record != null && record.isCompleted) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context)!;
    final bool isClockIn = record == null;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: isClockIn ? onClockIn : onClockOut,
        icon: Icon(isClockIn ? Icons.login_rounded : Icons.logout_rounded),
        label: Text(
          isClockIn ? l10n.attendance_buttonClockIn : l10n.attendance_buttonClockOut,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isClockIn ? AppColors.primary : AppColors.error,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
