import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/challenge/challenge_storage_repository.dart';
import '../common/firebase_storage_repository.dart';
import '../common/storage_naming.dart';

/// [ChallengeStorageRepository] implementation which
/// uses the Firebase Default Storage Bucket
@LazySingleton(as: ChallengeStorageRepository)
class FirebaseChallengeStorageRepository extends FirebaseStorageRepository
    implements ChallengeStorageRepository {
  // ignore: public_member_api_docs
  FirebaseChallengeStorageRepository(FirebaseStorage firebaseStorage)
      : super(firebaseStorage, challengesFolder);

  @override
  Future<String> uploadImageAndRetrieveDownloadURL(
      Uint8List file, String fileName) async {
    return await uploadFile(file, fileName);
  }

  @override
  Future<String> uploadSolution() {
    // TODO: implement uploadSolution
    throw UnimplementedError();
  }
}
