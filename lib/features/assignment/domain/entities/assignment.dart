class Assignment {
  final String id;
  final String companyId;
  final String? branchId;
  final String title;
  final String? description;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final Map<String, dynamic>? recurrence;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AssignmentAssignee> assignees;
  final List<Comment> comments;

  const Assignment({
    required this.id,
    required this.companyId,
    this.branchId,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    this.dueDate,
    this.recurrence,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.assignees = const [],
    this.comments = const [],
  });

  bool get isUrgent => priority == 'urgent';
  bool get isDone => status == 'done';
  bool get isOverdue => dueDate != null && dueDate!.isBefore(DateTime.now()) && !isDone;
}

class AssignmentAssignee {
  final String assignmentId;
  final String userId;
  final DateTime assignedAt;
  final String? userName;

  const AssignmentAssignee({
    required this.assignmentId,
    required this.userId,
    required this.assignedAt,
    this.userName,
  });
}

class Comment {
  final String id;
  final String assignmentId;
  final String userId;
  final String? userName;
  final bool isManager;
  final String? content;
  final String contentType;
  final List<Map<String, dynamic>>? attachments;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.assignmentId,
    required this.userId,
    this.userName,
    required this.isManager,
    this.content,
    required this.contentType,
    this.attachments,
    required this.createdAt,
  });
}
