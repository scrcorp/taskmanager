import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import '../theme/app_colors.dart';

enum PriorityLevel { urgent, normal, low }

class PriorityBadge extends StatelessWidget {
  final PriorityLevel priority;

  const PriorityBadge({super.key, required this.priority});

  Color get _color {
    switch (priority) {
      case PriorityLevel.urgent:
        return AppColors.urgent;
      case PriorityLevel.normal:
        return AppColors.normal;
      case PriorityLevel.low:
        return AppColors.low;
    }
  }

  String _label(AppLocalizations l10n) {
    switch (priority) {
      case PriorityLevel.urgent:
        return l10n.priority_urgent;
      case PriorityLevel.normal:
        return l10n.priority_normal;
      case PriorityLevel.low:
        return l10n.priority_low;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _label(l10n),
        style: TextStyle(
          color: _color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
