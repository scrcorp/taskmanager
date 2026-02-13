import '../../domain/repositories/file_repository.dart';
import '../datasources/file_remote_datasource.dart';

class FileRepositoryImpl implements FileRepository {
  final FileRemoteDatasource _remoteDatasource;

  FileRepositoryImpl({required FileRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<Map<String, dynamic>> uploadFile(
    String filePath, {
    String folder = 'uploads',
  }) =>
      _remoteDatasource.uploadFile(filePath, folder: folder);

  @override
  Future<String> getPresignedUrl(String filePath) =>
      _remoteDatasource.getPresignedUrl(filePath);

  @override
  Future<void> deleteFile(String filePath) =>
      _remoteDatasource.deleteFile(filePath);
}
