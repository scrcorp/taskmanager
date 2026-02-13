import '../entities/assignment.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignments({String? status, String? branchId});
  Future<List<Assignment>> getMyAssignments();
  Future<Assignment> getAssignment(String id);
  Future<Assignment> createAssignment(Map<String, dynamic> data);
  Future<Assignment> updateAssignment(String id, Map<String, dynamic> data);
  Future<void> deleteAssignment(String id);
  Future<Assignment> updateStatus(String id, String status);
  Future<List<Comment>> getComments(String assignmentId);
  Future<Comment> createComment(String assignmentId, Map<String, dynamic> data);
  Future<void> deleteComment(String assignmentId, String commentId);
  Future<Map<String, dynamic>> addAssignees(String assignmentId, List<String> userIds);
  Future<void> removeAssignee(String assignmentId, String userId);
}
