class Opinion {
  final String id;
  final String companyId;
  final String userId;
  final String content;
  final String status;
  final DateTime createdAt;

  const Opinion({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.content,
    required this.status,
    required this.createdAt,
  });
}
