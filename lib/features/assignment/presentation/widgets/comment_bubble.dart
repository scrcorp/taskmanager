import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/assignment.dart';

class CommentBubble extends StatelessWidget {
  final Comment comment;
  final bool isOwn;

  const CommentBubble({super.key, required this.comment, this.isOwn = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isOwn ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isOwn ? 12 : 0),
            bottomRight: Radius.circular(isOwn ? 0 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  comment.userName ?? l10n.comment_defaultUser,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: comment.isManager ? AppColors.primary : AppColors.textPrimary,
                  ),
                ),
                if (comment.isManager) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(l10n.comment_badgeManager, style: const TextStyle(fontSize: 9, color: AppColors.primary)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            if (comment.content != null) Text(comment.content!, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              AppDateUtils.formatRelative(comment.createdAt, l10n),
              style: const TextStyle(fontSize: 10, color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
