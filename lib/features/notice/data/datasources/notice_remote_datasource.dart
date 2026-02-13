import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/notice_model.dart';

class NoticeRemoteDatasource {
  final DioClient _client;

  NoticeRemoteDatasource({required DioClient client}) : _client = client;

  Future<List<NoticeModel>> getNotices({int? limit}) async {
    try {
      final params = <String, dynamic>{};
      if (limit != null) params['limit'] = limit;
      final response = await _client.get(
        ApiEndpoints.notices,
        queryParameters: params,
      );
      return (response.data as List)
          .map((e) => NoticeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<NoticeModel> getNotice(String id) async {
    try {
      final response = await _client.get(ApiEndpoints.noticeById(id));
      return NoticeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> confirmNotice(String id) async {
    try {
      await _client.post(ApiEndpoints.confirmNotice(id));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<NoticeModel> createNotice(Map<String, dynamic> data) async {
    try {
      final response = await _client.post(ApiEndpoints.notices, data: data);
      return NoticeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<NoticeModel> updateNotice(String id, Map<String, dynamic> data) async {
    try {
      final response = await _client.patch(ApiEndpoints.noticeById(id), data: data);
      return NoticeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> deleteNotice(String id) async {
    try {
      await _client.delete(ApiEndpoints.noticeById(id));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
