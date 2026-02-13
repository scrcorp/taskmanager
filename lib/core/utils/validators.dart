import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';

class Validators {
  Validators._();

  static String? Function(String?) email(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return (value) {
      if (value == null || value.isEmpty) return l10n.validator_emailRequired;
      final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!regex.hasMatch(value)) return l10n.validator_emailInvalid;
      return null;
    };
  }

  static String? Function(String?) loginId(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return (value) {
      if (value == null || value.isEmpty) return l10n.validator_loginIdRequired;
      if (value.length < 3) return l10n.validator_loginIdMinLength;
      return null;
    };
  }

  static String? Function(String?) password(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return (value) {
      if (value == null || value.isEmpty) return l10n.validator_passwordRequired;
      if (value.length < 6) return l10n.validator_passwordMinLength;
      return null;
    };
  }

  static String? Function(String?) required(BuildContext context, String fieldName) {
    final l10n = AppLocalizations.of(context)!;
    return (value) {
      if (value == null || value.trim().isEmpty) return l10n.validator_fieldRequired(fieldName);
      return null;
    };
  }

  static String? Function(String?) verificationCode(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return (value) {
      if (value == null || value.isEmpty) return l10n.validator_codeRequired;
      if (value.length != 6) return l10n.validator_codeLength;
      if (!RegExp(r'^\d{6}$').hasMatch(value)) return l10n.validator_codeDigitsOnly;
      return null;
    };
  }
}
