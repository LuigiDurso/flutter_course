import 'dart:io';

abstract class FileStorageDataProvider {
  Future<String> uploadFile(String path, String fileName, File file);
}