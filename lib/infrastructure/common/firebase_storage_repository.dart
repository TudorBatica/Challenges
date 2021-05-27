import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/common/common_failures.dart';

/// Handles file downloads/uploads from/to
/// a specific folder inside the Firebase Default Storage Bucket.
abstract class FirebaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  /// The root folder which this repository handles.
  final String rootFolder;

  // ignore: public_member_api_docs
  FirebaseStorageRepository(this._firebaseStorage, this.rootFolder);

  /// Uploads a file in the form of a Uint8List
  /// to the Firebase Default Storage Bucket,
  /// at the following path: `this.rootFolder/fileRelativePath`.
  /// Returns a download URL for the uploaded resource,
  /// or throws a [UploadFailed] exception if the process fails.
  Future<String> uploadFile(Uint8List file, String fileRelativePath) async {
    try {
      await _firebaseStorage
          .ref(rootFolder)
          .child(fileRelativePath)
          .putData(file);

      final downloadUrl = await _firebaseStorage
          .ref(rootFolder)
          .child(fileRelativePath)
          .getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e.message);
      print(e.code);
      throw UploadFailed();
    }
  }
}
