import '../../domain/entities/assignment.dart';
import '../../domain/repositories/assignment_repository.dart';
import '../datasources/assignment_remote_datasource.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDatasource _remoteDatasource;
  AssignmentRepositoryImpl({required AssignmentRemoteDatasource remoteDatasource}) : _remoteDatasource = remoteDatasource;

  @override
  Future<List<Assignment>> getAssignments({String? status, String? branchId}) =>
      _remoteDatasource.getAssignments(status: status, branchId: branchId);
  @override
  Future<List<Assignment>> getMyAssignments() => _remoteDatasource.getMyAssignments();
  @override
  Future<Assignment> getAssignment(String id) => _remoteDatasource.getAssignment(id);
  @override
  Future<Assignment> createAssignment(Map<String, dynamic> data) => _remoteDatasource.createAssignment(data);
  @override
  Future<Assignment> updateAssignment(String id, Map<String, dynamic> data) => _remoteDatasource.updateAssignment(id, data);
  @override
  Future<void> deleteAssignment(String id) => _remoteDatasource.deleteAssignment(id);
  @override
  Future<Assignment> updateStatus(String id, String status) => _remoteDatasource.updateStatus(id, status);
  @override
  Future<List<Comment>> getComments(String assignmentId) => _remoteDatasource.getComments(assignmentId);
  @override
  Future<Comment> createComment(String assignmentId, Map<String, dynamic> data) => _remoteDatasource.createComment(assignmentId, data);
  @override
  Future<void> deleteComment(String assignmentId, String commentId) => _remoteDatasource.deleteComment(assignmentId, commentId);
  @override
  Future<Map<String, dynamic>> addAssignees(String assignmentId, List<String> userIds) => _remoteDatasource.addAssignees(assignmentId, userIds);
  @override
  Future<void> removeAssignee(String assignmentId, String userId) => _remoteDatasource.removeAssignee(assignmentId, userId);
}
