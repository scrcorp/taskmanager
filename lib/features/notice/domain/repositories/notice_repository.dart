import '../entities/notice.dart';

abstract class NoticeRepository {
  Future<List<Notice>> getNotices({int? limit});
  Future<Notice> getNotice(String id);
  Future<void> confirmNotice(String id);
  Future<Notice> createNotice(Map<String, dynamic> data);
  Future<Notice> updateNotice(String id, Map<String, dynamic> data);
  Future<void> deleteNotice(String id);
}
