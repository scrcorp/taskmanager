import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import '../../../../shared/widgets/common_app_bar.dart';
import '../../../../shared/theme/app_colors.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.checklist_title, showBack: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.checklist, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(l10n.checklist_selectPlaceholder, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
