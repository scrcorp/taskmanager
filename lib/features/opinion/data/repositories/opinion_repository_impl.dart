import '../../domain/entities/opinion.dart';
import '../../domain/repositories/opinion_repository.dart';
import '../datasources/opinion_remote_datasource.dart';

class OpinionRepositoryImpl implements OpinionRepository {
  final OpinionRemoteDatasource _remoteDatasource;

  OpinionRepositoryImpl({required OpinionRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<List<Opinion>> getOpinions() => _remoteDatasource.getOpinions();

  @override
  Future<Opinion> createOpinion(String content) =>
      _remoteDatasource.createOpinion(content);
}
