import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';

final userRemoteDatasourceProvider = Provider<UserRemoteDatasource>((ref) {
  final client = ref.watch(dioClientProvider);
  return UserRemoteDatasource(client: client);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final datasource = ref.watch(userRemoteDatasourceProvider);
  return UserRepositoryImpl(remoteDatasource: datasource);
});

final userProfileProvider = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getProfile();
});
