import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/assignment_remote_datasource.dart';
import '../../data/repositories/assignment_repository_impl.dart';
import '../../domain/entities/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';

final assignmentRemoteDatasourceProvider = Provider<AssignmentRemoteDatasource>((ref) {
  return AssignmentRemoteDatasource(client: ref.watch(dioClientProvider));
});

final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  return AssignmentRepositoryImpl(remoteDatasource: ref.watch(assignmentRemoteDatasourceProvider));
});

final myAssignmentsProvider = FutureProvider.autoDispose<List<Assignment>>((ref) async {
  final repo = ref.watch(assignmentRepositoryProvider);
  return repo.getMyAssignments();
});

final assignmentDetailProvider = FutureProvider.autoDispose.family<Assignment, String>((ref, id) async {
  final repo = ref.watch(assignmentRepositoryProvider);
  return repo.getAssignment(id);
});

final assignmentCommentsProvider = FutureProvider.autoDispose.family<List<Comment>, String>((ref, id) async {
  final repo = ref.watch(assignmentRepositoryProvider);
  return repo.getComments(id);
});
