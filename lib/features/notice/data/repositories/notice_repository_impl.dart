import '../../domain/entities/notice.dart';
import '../../domain/repositories/notice_repository.dart';
import '../datasources/notice_remote_datasource.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeRemoteDatasource _remoteDatasource;

  NoticeRepositoryImpl({required NoticeRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<List<Notice>> getNotices({int? limit}) =>
      _remoteDatasource.getNotices(limit: limit);

  @override
  Future<Notice> getNotice(String id) => _remoteDatasource.getNotice(id);

  @override
  Future<void> confirmNotice(String id) => _remoteDatasource.confirmNotice(id);

  @override
  Future<Notice> createNotice(Map<String, dynamic> data) =>
      _remoteDatasource.createNotice(data);

  @override
  Future<Notice> updateNotice(String id, Map<String, dynamic> data) =>
      _remoteDatasource.updateNotice(id, data);

  @override
  Future<void> deleteNotice(String id) => _remoteDatasource.deleteNotice(id);
}
