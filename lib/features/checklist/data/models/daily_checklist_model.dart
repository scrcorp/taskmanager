import '../../domain/entities/daily_checklist.dart';

class DailyChecklistModel extends DailyChecklist {
  const DailyChecklistModel({
    required super.id, required super.templateId, required super.branchId,
    required super.date, required super.items, super.groupIds, required super.createdAt,
  });

  factory DailyChecklistModel.fromJson(Map<String, dynamic> json) {
    final data = json['checklist_data'] as List<dynamic>? ?? [];
    return DailyChecklistModel(
      id: json['id'] as String,
      templateId: json['template_id'] as String,
      branchId: json['branch_id'] as String,
      date: json['date'] as String,
      items: data.map((e) => ChecklistItemModel.fromJson(e)).toList(),
      groupIds: (json['group_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
}

class ChecklistItemModel extends ChecklistItem {
  const ChecklistItemModel({
    required super.content, required super.verificationType,
    super.isCompleted, super.verificationData, required super.sortOrder,
  });

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemModel(
      content: json['content'] as String? ?? '',
      verificationType: json['verification_type'] as String? ?? 'none',
      isCompleted: json['is_completed'] as bool? ?? false,
      verificationData: json['verification_data'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }
}
