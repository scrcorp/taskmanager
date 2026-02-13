import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';

class TermsStep extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool> onAccepted;
  final VoidCallback onNext;

  const TermsStep({
    super.key,
    required this.accepted,
    required this.onAccepted,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.terms_title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDFE6E9)),
              ),
              child: SingleChildScrollView(
                child: Text(
                  l10n.terms_content,
                  style: const TextStyle(height: 1.6, fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: accepted,
            onChanged: (v) => onAccepted(v ?? false),
            title: Text(l10n.terms_agree),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: accepted ? onNext : null,
            child: Text(l10n.terms_next),
          ),
        ],
      ),
    );
  }
}
