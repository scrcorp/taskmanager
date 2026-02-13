import '../entities/daily_checklist.dart';

abstract class ChecklistRepository {
  Future<List<DailyChecklist>> getChecklists(String branchId, String date);
  Future<DailyChecklist> getChecklist(String id);
  Future<DailyChecklist> updateItem(String checklistId, int itemIndex, bool isCompleted, {String? verificationData});
  Future<DailyChecklist> generate({required String templateId, required String branchId, required String date, List<String>? groupIds});
}
