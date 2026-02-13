import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String formatFullDate(DateTime date, {required String locale}) {
    return DateFormat.yMMMMEEEEd(locale).format(date);
  }

  static String formatShortDate(DateTime date) {
    return DateFormat('M/d').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatRelative(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return l10n.date_justNow;
    if (diff.inMinutes < 60) return l10n.date_minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.date_hoursAgo(diff.inHours);
    if (diff.inDays < 7) return l10n.date_daysAgo(diff.inDays);
    return formatShortDate(date);
  }

  static String formatDuration(Duration duration, AppLocalizations l10n) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) return l10n.date_hoursMinutes(hours, minutes);
    return l10n.date_minutes(minutes);
  }
}
