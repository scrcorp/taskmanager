import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/attendance_model.dart';

class AttendanceRemoteDatasource {
  final DioClient _client;

  AttendanceRemoteDatasource({required DioClient client}) : _client = client;

  Future<AttendanceRecordModel?> getToday() async {
    try {
      final response = await _client.get(ApiEndpoints.attendanceToday);
      if (response.data == null) return null;
      return AttendanceRecordModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<AttendanceRecordModel> clockIn({
    String? branchId,
    String? location,
  }) async {
    try {
      final response = await _client.post(
        ApiEndpoints.clockIn,
        data: {
          if (branchId != null) 'branch_id': branchId,
          if (location != null) 'location': location,
        },
      );
      return AttendanceRecordModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<AttendanceRecordModel> clockOut() async {
    try {
      final response = await _client.post(ApiEndpoints.clockOut);
      return AttendanceRecordModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> getHistory({int? year, int? month}) async {
    try {
      final params = <String, dynamic>{};
      if (year != null) params['year'] = year;
      if (month != null) params['month'] = month;
      final response = await _client.get(
        ApiEndpoints.attendanceHistory,
        queryParameters: params,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
