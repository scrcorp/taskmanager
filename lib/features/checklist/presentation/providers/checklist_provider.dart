import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/mock/mock_repositories.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/checklist_remote_datasource.dart';
import '../../data/repositories/checklist_repository_impl.dart';
import '../../domain/repositories/checklist_repository.dart';

final checklistRemoteDatasourceProvider = Provider<ChecklistRemoteDatasource>((ref) {
  return ChecklistRemoteDatasource(client: ref.watch(dioClientProvider));
});

final checklistRepositoryProvider = Provider<ChecklistRepository>((ref) {
  if (AppConfig.useMockData) return MockChecklistRepository();
  return ChecklistRepositoryImpl(remoteDatasource: ref.watch(checklistRemoteDatasourceProvider));
});
