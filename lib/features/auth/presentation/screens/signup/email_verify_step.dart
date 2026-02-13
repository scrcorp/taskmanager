import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class EmailVerifyStep extends ConsumerStatefulWidget {
  final String email;
  final VoidCallback onVerified;

  const EmailVerifyStep({
    super.key,
    required this.email,
    required this.onVerified,
  });

  @override
  ConsumerState<EmailVerifyStep> createState() => _EmailVerifyStepState();
}

class _EmailVerifyStepState extends ConsumerState<EmailVerifyStep> {
  final _codeController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_codeController.text.length != 6) return;
    setState(() => _isVerifying = true);

    final success = await ref.read(authProvider.notifier).verifyEmail(
      widget.email,
      _codeController.text,
    );

    if (mounted) {
      setState(() => _isVerifying = false);
      if (success) {
        widget.onVerified();
      } else {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.signup_errorInvalidCode), backgroundColor: AppColors.error),
        );
      }
    }
  }

  Future<void> _resend() async {
    final success = await ref.read(authProvider.notifier).sendVerification(widget.email);
    if (mounted && success) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.signup_successCodeResent)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.emailVerify_title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text(
            l10n.emailVerify_description(widget.email),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _codeController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: '000000',
              counterText: '',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isVerifying ? null : _verify,
            child: _isVerifying
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Text(l10n.signup_buttonVerify),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _resend,
            child: Text(l10n.emailVerify_resend),
          ),
        ],
      ),
    );
  }
}
