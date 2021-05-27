import 'dart:typed_data';

/// Handles file storage for challenges.
abstract class ChallengeStorageRepository {
  /// Upload the challenge image and
  /// return a download URL for the uploaded image.
  Future<String> uploadImageAndRetrieveDownloadURL(
      Uint8List file, String fileName);

  Future<String> uploadSolution();
}
