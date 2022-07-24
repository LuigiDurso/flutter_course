import 'dart:io';

import 'package:branches_presences/app/domain/data/file_storage_data_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageClient implements FileStorageDataProvider {
  final FirebaseStorage _firebaseStorage;

  FirebaseStorageClient({
    FirebaseStorage? firebaseStorage,
  })  : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<String> uploadFile(String path, String fileName, File file) async {
    final ref = _firebaseStorage.ref()
        .child(path)
        .child(fileName);
    await ref.putFile(file);
    return ref.getDownloadURL();
  }
}
