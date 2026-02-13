import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/exceptions.dart';
import '../models/opinion_model.dart';

class OpinionRemoteDatasource {
  final DioClient _client;

  OpinionRemoteDatasource({required DioClient client}) : _client = client;

  Future<List<OpinionModel>> getOpinions() async {
    try {
      final response = await _client.get(ApiEndpoints.opinions);
      return (response.data as List)
          .map((e) => OpinionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<OpinionModel> createOpinion(String content) async {
    try {
      final response = await _client.post(
        ApiEndpoints.opinions,
        data: {'content': content},
      );
      return OpinionModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
