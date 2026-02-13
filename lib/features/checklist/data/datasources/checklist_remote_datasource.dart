import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/daily_checklist_model.dart';

class ChecklistRemoteDatasource {
  final DioClient _client;
  ChecklistRemoteDatasource({required DioClient client}) : _client = client;

  Future<List<DailyChecklistModel>> getChecklists(String branchId, String date) async {
    try {
      final response = await _client.get(ApiEndpoints.dailyChecklists, queryParameters: {'branch_id': branchId, 'date': date});
      return (response.data as List).map((e) => DailyChecklistModel.fromJson(e)).toList();
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<DailyChecklistModel> getChecklist(String id) async {
    try {
      final response = await _client.get(ApiEndpoints.checklistById(id));
      return DailyChecklistModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<DailyChecklistModel> updateItem(String checklistId, int itemIndex, bool isCompleted, {String? verificationData}) async {
    try {
      final response = await _client.patch(ApiEndpoints.updateChecklistItem(checklistId, itemIndex), data: {
        'is_completed': isCompleted,
        if (verificationData != null) 'verification_data': verificationData,
      });
      return DailyChecklistModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }

  Future<DailyChecklistModel> generate({
    required String templateId,
    required String branchId,
    required String date,
    List<String>? groupIds,
  }) async {
    try {
      final response = await _client.post(ApiEndpoints.generateChecklist, data: {
        'template_id': templateId,
        'branch_id': branchId,
        'date': date,
        if (groupIds != null) 'group_ids': groupIds,
      });
      return DailyChecklistModel.fromJson(response.data);
    } catch (e) { throw ServerException(message: e.toString()); }
  }
}
