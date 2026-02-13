import '../entities/opinion.dart';

abstract class OpinionRepository {
  Future<List<Opinion>> getOpinions();
  Future<Opinion> createOpinion(String content);
}
