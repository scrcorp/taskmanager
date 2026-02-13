import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/mock/mock_repositories.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasources/notice_remote_datasource.dart';
import '../../data/repositories/notice_repository_impl.dart';
import '../../domain/entities/notice.dart';
import '../../domain/repositories/notice_repository.dart';

final noticeRemoteDatasourceProvider = Provider<NoticeRemoteDatasource>((ref) {
  return NoticeRemoteDatasource(client: ref.watch(dioClientProvider));
});

final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  if (AppConfig.useMockData) return MockNoticeRepository();
  return NoticeRepositoryImpl(
    remoteDatasource: ref.watch(noticeRemoteDatasourceProvider),
  );
});

final noticeListProvider =
    FutureProvider.autoDispose<List<Notice>>((ref) async {
  return ref.watch(noticeRepositoryProvider).getNotices();
});

final noticeDetailProvider =
    FutureProvider.autoDispose.family<Notice, String>((ref, id) async {
  return ref.watch(noticeRepositoryProvider).getNotice(id);
});
