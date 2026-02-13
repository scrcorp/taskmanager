import '../../domain/entities/assignment.dart';

class AssignmentModel extends Assignment {
  const AssignmentModel({
    required super.id, required super.companyId, super.branchId,
    required super.title, super.description, required super.priority,
    required super.status, super.dueDate, super.recurrence,
    required super.createdBy, required super.createdAt, required super.updatedAt,
    super.assignees, super.comments,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      branchId: json['branch_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: json['priority'] as String? ?? 'normal',
      status: json['status'] as String? ?? 'todo',
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date'] as String) : null,
      recurrence: json['recurrence'] as Map<String, dynamic>?,
      createdBy: json['created_by'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] as String? ?? DateTime.now().toIso8601String()),
      assignees: (json['assignees'] as List<dynamic>?)
          ?.map((e) => AssigneeModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class AssigneeModel extends AssignmentAssignee {
  const AssigneeModel({
    required super.assignmentId, required super.userId, required super.assignedAt, super.userName,
  });

  factory AssigneeModel.fromJson(Map<String, dynamic> json) {
    return AssigneeModel(
      assignmentId: json['assignment_id'] as String? ?? '',
      userId: json['user_id'] as String,
      assignedAt: DateTime.parse(json['assigned_at'] as String? ?? DateTime.now().toIso8601String()),
      userName: json['user_name'] as String? ?? json['full_name'] as String?,
    );
  }
}

class CommentModel extends Comment {
  const CommentModel({
    required super.id, required super.assignmentId, required super.userId,
    super.userName, required super.isManager, super.content,
    required super.contentType, super.attachments, required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      assignmentId: json['assignment_id'] as String? ?? '',
      userId: json['user_id'] as String,
      userName: json['user_name'] as String?,
      isManager: json['is_manager'] as bool? ?? false,
      content: json['content'] as String?,
      contentType: json['content_type'] as String? ?? 'text',
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Map<String, dynamic>.from(e)).toList(),
      createdAt: DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
}
