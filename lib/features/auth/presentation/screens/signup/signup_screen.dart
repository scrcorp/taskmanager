import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../../shared/widgets/loading_overlay.dart';
import '../../providers/auth_provider.dart';
import '../../../data/models/signup_request.dart';
import 'terms_step.dart';
import 'info_input_step.dart';
import 'complete_step.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  int _currentStep = 0;
  bool _termsAccepted = false;

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      context.go('/login');
    }
  }

  Future<void> _handleSignup(String email, String loginId, String password, String fullName, String companyCode) async {
    final request = SignupRequest(
      email: email,
      loginId: loginId,
      password: password,
      fullName: fullName,
      companyCode: companyCode,
    );
    final user = await ref.read(authProvider.notifier).signup(request);
    if (user != null && mounted) {
      _nextStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;

    return LoadingOverlay(
      isLoading: authState.isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: _currentStep < 2
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _prevStep,
                )
              : null,
          automaticallyImplyLeading: false,
          title: Text(l10n.signup_title(_currentStep + 1)),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / 3,
                    backgroundColor: AppColors.border,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _currentStep,
                      children: [
                        TermsStep(
                          accepted: _termsAccepted,
                          onAccepted: (v) => setState(() => _termsAccepted = v),
                          onNext: _nextStep,
                        ),
                        InfoInputStep(
                          onSubmit: _handleSignup,
                        ),
                        const CompleteStep(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
