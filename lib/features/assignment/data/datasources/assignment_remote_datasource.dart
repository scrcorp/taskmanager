import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/assignment_model.dart';

class AssignmentRemoteDatasource {
  final DioClient _client;
  AssignmentRemoteDatasource({required DioClient client}) : _client = client;

  Future<List<AssignmentModel>> getAssignments({String? status, String? branchId}) async {
    try {
      final params = <String, dynamic>{};
      if (status != null) params['status'] = status;
      if (branchId != null) params['branch_id'] = branchId;
      final response = await _client.get(ApiEndpoints.assignments, queryParameters: params);
      return (response.data as List).map((e) => AssignmentModel.fromJson(e)).toList();
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<List<AssignmentModel>> getMyAssignments() async {
    try {
      final response = await _client.get(ApiEndpoints.myAssignments);
      return (response.data as List).map((e) => AssignmentModel.fromJson(e)).toList();
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<AssignmentModel> getAssignment(String id) async {
    try {
      final response = await _client.get(ApiEndpoints.assignmentById(id));
      return AssignmentModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<AssignmentModel> createAssignment(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(ApiEndpoints.assignments, data: data);
      return AssignmentModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<AssignmentModel> updateAssignment(String id, Map<String, dynamic> data) async {
    try {
      final response = await _client.patch(ApiEndpoints.assignmentById(id), data: data);
      return AssignmentModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<void> deleteAssignment(String id) async {
    try { await _client.delete(ApiEndpoints.assignmentById(id)); }
    catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<AssignmentModel> updateStatus(String id, String status) async {
    try {
      final response = await _client.patch(ApiEndpoints.assignmentStatus(id), data: {'status': status});
      return AssignmentModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<List<CommentModel>> getComments(String assignmentId) async {
    try {
      final response = await _client.get(ApiEndpoints.assignmentComments(assignmentId));
      return (response.data as List).map((e) => CommentModel.fromJson(e)).toList();
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<CommentModel> createComment(String assignmentId, Map<String, dynamic> data) async {
    try {
      final response = await _client.post(ApiEndpoints.assignmentComments(assignmentId), data: data);
      return CommentModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<void> deleteComment(String assignmentId, String commentId) async {
    try { await _client.delete(ApiEndpoints.deleteComment(assignmentId, commentId)); }
    catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<Map<String, dynamic>> addAssignees(String assignmentId, List<String> userIds) async {
    try {
      final response = await _client.post(
        ApiEndpoints.assignmentAssignees(assignmentId),
        data: {'user_ids': userIds},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<void> removeAssignee(String assignmentId, String userId) async {
    try { await _client.delete(ApiEndpoints.removeAssignee(assignmentId, userId)); }
    catch (e) { throw ServerException(message: e.toString()); }
  }
}
