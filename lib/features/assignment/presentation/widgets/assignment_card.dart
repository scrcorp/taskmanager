import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/priority_badge.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/assignment.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback? onTap;

  const AssignmentCard({super.key, required this.assignment, this.onTap});

  PriorityLevel get _priorityLevel {
    switch (assignment.priority) {
      case 'urgent': return PriorityLevel.urgent;
      case 'low': return PriorityLevel.low;
      default: return PriorityLevel.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: assignment.isOverdue ? AppColors.error.withValues(alpha: 0.3) : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PriorityBadge(priority: _priorityLevel),
                const SizedBox(width: 8),
                _StatusChip(status: assignment.status),
                const Spacer(),
                if (assignment.dueDate != null)
                  Text(
                    AppDateUtils.formatShortDate(assignment.dueDate!),
                    style: TextStyle(
                      fontSize: 12,
                      color: assignment.isOverdue ? AppColors.error : AppColors.textTertiary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              assignment.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (assignment.description != null && assignment.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                assignment.description!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (assignment.assignees.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.people_outline, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(
                    l10n.assignment_assigneeCount(assignment.assignees.length),
                    style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                  ),
                  if (assignment.comments.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.textTertiary),
                    const SizedBox(width: 4),
                    Text(
                      '${assignment.comments.length}',
                      style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (label, color) = switch (status) {
      'done' => (l10n.status_done, AppColors.success),
      'in_progress' => (l10n.status_inProgress, AppColors.info),
      _ => (l10n.status_todo, AppColors.textTertiary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
