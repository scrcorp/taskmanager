import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class InfoInputStep extends ConsumerStatefulWidget {
  final void Function(String email, String loginId, String password, String fullName, String companyCode) onSubmit;

  const InfoInputStep({super.key, required this.onSubmit});

  @override
  ConsumerState<InfoInputStep> createState() => _InfoInputStepState();
}

class _InfoInputStepState extends ConsumerState<InfoInputStep> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _loginIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _companyCodeController = TextEditingController();
  bool _obscurePassword = true;

  bool _codeSent = false;
  bool _emailVerified = false;
  bool _isSendingCode = false;
  bool _isVerifying = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _loginIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _companyCodeController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    if (Validators.email(context)(email) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.signup_errorInvalidEmail), backgroundColor: AppColors.error),
      );
      return;
    }

    setState(() => _isSendingCode = true);
    final success = await ref.read(authProvider.notifier).sendVerification(email);
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _isSendingCode = false;
        if (success) _codeSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? l10n.signup_successCodeSent : l10n.signup_errorSendFailed),
          backgroundColor: success ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.length != 6) return;

    setState(() => _isVerifying = true);
    final success = await ref.read(authProvider.notifier).verifyEmail(
      _emailController.text.trim(),
      code,
    );
    if (mounted) {
      setState(() {
        _isVerifying = false;
        if (success) _emailVerified = true;
      });
      if (!success) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.signup_errorInvalidCode), backgroundColor: AppColors.error),
        );
      }
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_emailVerified) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.signup_errorVerifyEmail), backgroundColor: AppColors.error),
      );
      return;
    }
    widget.onSubmit(
      _emailController.text.trim(),
      _loginIdController.text.trim(),
      _passwordController.text,
      _fullNameController.text.trim(),
      _companyCodeController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.signup_sectionInfo, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            TextFormField(
              controller: _fullNameController,
              validator: Validators.required(context, l10n.signup_labelName),
              decoration: InputDecoration(labelText: l10n.signup_labelName, prefixIcon: const Icon(Icons.badge_outlined)),
            ),
            const SizedBox(height: 16),

            // Email + send verification button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    validator: Validators.email(context),
                    readOnly: _emailVerified,
                    decoration: InputDecoration(
                      labelText: l10n.signup_labelEmail,
                      prefixIcon: const Icon(Icons.email_outlined),
                      suffixIcon: _emailVerified
                          ? const Icon(Icons.check_circle, color: AppColors.success)
                          : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _emailVerified || _isSendingCode ? null : _sendVerificationCode,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: _emailVerified ? AppColors.success : null,
                      ),
                      child: _isSendingCode
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text(_emailVerified ? l10n.signup_buttonVerified : (_codeSent ? l10n.signup_buttonResend : l10n.signup_buttonVerifyRequest), style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),

            // Verification code input (shown after code sent, before verified)
            if (_codeSent && !_emailVerified) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _codeController,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.signup_labelVerificationCode,
                        prefixIcon: const Icon(Icons.pin_outlined),
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isVerifying ? null : _verifyCode,
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16)),
                        child: _isVerifying
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : Text(l10n.signup_buttonVerify, style: const TextStyle(fontSize: 13)),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 16),
            TextFormField(
              controller: _loginIdController,
              validator: Validators.loginId(context),
              decoration: InputDecoration(labelText: l10n.login_labelUsername, prefixIcon: const Icon(Icons.person_outline)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              validator: Validators.password(context),
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: l10n.login_labelPassword,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscurePassword,
              validator: (v) {
                if (v != _passwordController.text) return l10n.signup_errorPasswordMismatch;
                return null;
              },
              decoration: InputDecoration(labelText: l10n.signup_labelPasswordConfirm, prefixIcon: const Icon(Icons.lock_outline)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _companyCodeController,
              validator: Validators.required(context, l10n.signup_labelCompanyCode),
              decoration: InputDecoration(labelText: l10n.signup_labelCompanyCode, prefixIcon: const Icon(Icons.business_outlined)),
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: _submit, child: Text(l10n.signup_buttonSignup)),
          ],
        ),
      ),
    );
  }
}
