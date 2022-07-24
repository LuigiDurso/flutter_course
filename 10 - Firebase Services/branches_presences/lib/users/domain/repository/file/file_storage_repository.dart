import 'dart:io';

import 'package:branches_presences/app/domain/data/file_storage_data_provider.dart';

class FileStorageRepository {
  final FileStorageDataProvider fileStorageDataProvider;

  FileStorageRepository({required this.fileStorageDataProvider});

  Future<String> uploadFile(String path, String fileName, File file) {
    return fileStorageDataProvider.uploadFile(path, fileName, file);
  }
}
