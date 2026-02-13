import 'package:flutter/material.dart';
import 'package:taskmanager/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/common_app_bar.dart';
import '../../../../shared/widgets/app_shimmer.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/empty_view.dart';
import '../providers/assignment_provider.dart';
import '../widgets/assignment_card.dart';

class AssignmentListScreen extends ConsumerWidget {
  const AssignmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(myAssignmentsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CommonAppBar(title: l10n.assignment_myTasks, showProfile: true),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myAssignmentsProvider);
        },
        child: assignmentsAsync.when(
          loading: () => const ShimmerList(),
          error: (e, _) => ErrorView(
            message: l10n.assignment_errorLoadList,
            onRetry: () => ref.invalidate(myAssignmentsProvider),
          ),
          data: (assignments) {
            if (assignments.isEmpty) {
              return EmptyView(
                message: l10n.assignment_empty,
                icon: Icons.assignment_outlined,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: assignments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return AssignmentCard(
                  assignment: assignment,
                  onTap: () => context.push('/tasks/${assignment.id}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
