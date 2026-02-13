import '../../domain/entities/opinion.dart';

class OpinionModel extends Opinion {
  const OpinionModel({
    required super.id,
    required super.companyId,
    required super.userId,
    required super.content,
    required super.status,
    required super.createdAt,
  });

  factory OpinionModel.fromJson(Map<String, dynamic> json) {
    return OpinionModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      content: json['content'] as String,
      status: json['status'] as String? ?? 'submitted',
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
