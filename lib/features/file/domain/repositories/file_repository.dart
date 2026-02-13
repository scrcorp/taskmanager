abstract class FileRepository {
  Future<Map<String, dynamic>> uploadFile(String filePath, {String folder});
  Future<String> getPresignedUrl(String filePath);
  Future<void> deleteFile(String filePath);
}
