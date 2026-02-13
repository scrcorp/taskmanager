import '../../domain/entities/notice.dart';

class NoticeModel extends Notice {
  const NoticeModel({
    required super.id,
    required super.companyId,
    super.branchId,
    super.authorId,
    required super.authorName,
    super.authorRole,
    required super.title,
    required super.content,
    required super.isImportant,
    required super.createdAt,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String? ?? '',
      branchId: json['branch_id'] as String?,
      authorId: json['author_id'] as String?,
      authorName: json['author_name'] as String? ?? '',
      authorRole: json['author_role'] as String?,
      title: json['title'] as String,
      content: json['content'] as String? ?? '',
      isImportant: json['is_important'] as bool? ?? false,
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
