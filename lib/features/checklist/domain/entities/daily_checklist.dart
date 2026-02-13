class DailyChecklist {
  final String id;
  final String templateId;
  final String branchId;
  final String date;
  final List<ChecklistItem> items;
  final List<String>? groupIds;
  final DateTime createdAt;

  const DailyChecklist({
    required this.id, required this.templateId, required this.branchId,
    required this.date, required this.items, this.groupIds, required this.createdAt,
  });

  double get completionRate {
    if (items.isEmpty) return 0;
    return items.where((i) => i.isCompleted).length / items.length;
  }
}

class ChecklistItem {
  final String content;
  final String verificationType;
  final bool isCompleted;
  final String? verificationData;
  final int sortOrder;

  const ChecklistItem({
    required this.content, required this.verificationType,
    this.isCompleted = false, this.verificationData, required this.sortOrder,
  });
}
