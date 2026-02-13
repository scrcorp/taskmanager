import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/mock/mock_repositories.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/opinion_remote_datasource.dart';
import '../../data/repositories/opinion_repository_impl.dart';
import '../../domain/entities/opinion.dart';
import '../../domain/repositories/opinion_repository.dart';

final opinionRemoteDatasourceProvider =
    Provider<OpinionRemoteDatasource>((ref) {
  return OpinionRemoteDatasource(client: ref.watch(dioClientProvider));
});

final opinionRepositoryProvider = Provider<OpinionRepository>((ref) {
  if (AppConfig.useMockData) return MockOpinionRepository();
  return OpinionRepositoryImpl(
    remoteDatasource: ref.watch(opinionRemoteDatasourceProvider),
  );
});

final opinionsProvider = FutureProvider.autoDispose<List<Opinion>>((ref) async {
  return ref.watch(opinionRepositoryProvider).getOpinions();
});
