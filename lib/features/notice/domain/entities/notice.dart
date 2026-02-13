class Notice {
  final String id;
  final String companyId;
  final String? branchId;
  final String? authorId;
  final String authorName;
  final String? authorRole;
  final String title;
  final String content;
  final bool isImportant;
  final DateTime createdAt;

  const Notice({
    required this.id,
    required this.companyId,
    this.branchId,
    this.authorId,
    required this.authorName,
    this.authorRole,
    required this.title,
    required this.content,
    required this.isImportant,
    required this.createdAt,
  });
}
