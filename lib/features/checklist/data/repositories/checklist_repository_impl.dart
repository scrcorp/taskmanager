import '../../domain/entities/daily_checklist.dart';
import '../../domain/repositories/checklist_repository.dart';
import '../datasources/checklist_remote_datasource.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final ChecklistRemoteDatasource _remoteDatasource;
  ChecklistRepositoryImpl({required ChecklistRemoteDatasource remoteDatasource}) : _remoteDatasource = remoteDatasource;

  @override Future<List<DailyChecklist>> getChecklists(String branchId, String date) => _remoteDatasource.getChecklists(branchId, date);
  @override Future<DailyChecklist> getChecklist(String id) => _remoteDatasource.getChecklist(id);
  @override Future<DailyChecklist> updateItem(String checklistId, int itemIndex, bool isCompleted, {String? verificationData}) =>
      _remoteDatasource.updateItem(checklistId, itemIndex, isCompleted, verificationData: verificationData);
  @override Future<DailyChecklist> generate({required String templateId, required String branchId, required String date, List<String>? groupIds}) =>
      _remoteDatasource.generate(templateId: templateId, branchId: branchId, date: date, groupIds: groupIds);
}
