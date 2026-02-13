import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';

class FileRemoteDatasource {
  final DioClient _client;

  FileRemoteDatasource({required DioClient client}) : _client = client;

  Future<Map<String, dynamic>> uploadFile(
    String filePath, {
    String folder = 'uploads',
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _client.post(
        '${ApiEndpoints.fileUpload}?folder=$folder',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<String> getPresignedUrl(String filePath) async {
    try {
      final response = await _client.post(
        ApiEndpoints.presignedUrl,
        data: {'file_path': filePath},
      );
      return (response.data as Map<String, dynamic>)['url'] as String;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      await _client.delete(
        ApiEndpoints.fileDelete,
        data: {'file_path': filePath},
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
