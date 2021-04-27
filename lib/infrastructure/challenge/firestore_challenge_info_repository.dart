import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/challenge/challenge_info.dart';
import '../../domain/common/json_serializer.dart';
import '../common/database_naming.dart';
import '../common/firestore_crud_repository.dart';

/// Repository which manages the challenge info documents.
@LazySingleton(as: FirestoreCrudRepository)
class FirestoreChallengeInfoRepository
    extends FirestoreCrudRepository<ChallengeInfo> {
  // ignore: public_member_api_docs
  FirestoreChallengeInfoRepository(FirebaseFirestore firebaseFirestore,
      JsonSerializer<ChallengeInfo> serializer)
      : super(firebaseFirestore, serializer, challengeInfoCollectionPath);
}
