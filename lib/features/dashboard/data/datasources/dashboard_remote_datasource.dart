import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/dashboard_model.dart';

class DashboardRemoteDatasource {
  final DioClient _client;

  DashboardRemoteDatasource({required DioClient client}) : _client = client;

  Future<DashboardSummaryModel> getSummary() async {
    try {
      final response = await _client.get(ApiEndpoints.dashboardSummary);
      return DashboardSummaryModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
