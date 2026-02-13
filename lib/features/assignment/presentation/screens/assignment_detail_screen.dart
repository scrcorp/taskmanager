import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_shimmer.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/priority_badge.dart';
import '../../../../core/utils/date_utils.dart';
import '../providers/assignment_provider.dart';
import '../widgets/comment_bubble.dart';

class AssignmentDetailScreen extends ConsumerStatefulWidget {
  final String assignmentId;
  const AssignmentDetailScreen({super.key, required this.assignmentId});

  @override
  ConsumerState<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends ConsumerState<AssignmentDetailScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _sendComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final repo = ref.read(assignmentRepositoryProvider);
    await repo.createComment(widget.assignmentId, {
      'content': text,
      'content_type': 'text',
    });
    _commentController.clear();
    ref.invalidate(assignmentDetailProvider(widget.assignmentId));
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(assignmentDetailProvider(widget.assignmentId));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.assignment_detail),
      ),
      body: detailAsync.when(
        loading: () => const ShimmerList(itemCount: 3, itemHeight: 100),
        error: (e, _) => ErrorView(
          message: l10n.assignment_errorLoad,
          onRetry: () => ref.invalidate(assignmentDetailProvider(widget.assignmentId)),
        ),
        data: (assignment) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        PriorityBadge(priority: _toPriorityLevel(assignment.priority)),
                        const SizedBox(width: 8),
                        _StatusBadge(status: assignment.status),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(assignment.title, style: Theme.of(context).textTheme.headlineSmall),
                    if (assignment.description != null) ...[
                      const SizedBox(height: 8),
                      Text(assignment.description!, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                    const SizedBox(height: 16),
                    // Info
                    if (assignment.dueDate != null)
                      _InfoRow(icon: Icons.calendar_today, label: l10n.assignment_dueDate, value: AppDateUtils.formatDateTime(assignment.dueDate!)),
                    _InfoRow(icon: Icons.access_time, label: l10n.assignment_createdDate, value: AppDateUtils.formatDateTime(assignment.createdAt)),

                    // Assignees
                    if (assignment.assignees.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(l10n.assignment_assignees, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: assignment.assignees.map((a) => Chip(
                          avatar: const CircleAvatar(
                            backgroundColor: AppColors.primaryContainer,
                            child: Icon(Icons.person, size: 16, color: AppColors.primary),
                          ),
                          label: Text(a.userName ?? a.userId, style: const TextStyle(fontSize: 12)),
                        )).toList(),
                      ),
                    ],

                    // Comments
                    const SizedBox(height: 24),
                    Text(l10n.assignment_comments(assignment.comments.length), style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    ...assignment.comments.map((c) => CommentBubble(comment: c)),
                  ],
                ),
              ),
            ),
            // Comment input
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: l10n.assignment_commentHint,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          isDense: true,
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendComment(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _sendComment,
                      icon: const Icon(Icons.send, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PriorityLevel _toPriorityLevel(String p) => switch (p) {
    'urgent' => PriorityLevel.urgent,
    'low' => PriorityLevel.low,
    _ => PriorityLevel.normal,
  };
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (label, color) = switch (status) {
      'done' => (l10n.status_done, AppColors.success),
      'in_progress' => (l10n.status_inProgress, AppColors.info),
      _ => (l10n.status_todo, AppColors.textTertiary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textTertiary),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.textTertiary)),
          Text(value, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
