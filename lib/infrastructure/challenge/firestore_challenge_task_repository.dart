import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/challenge/challenge_task.dart';
import '../../domain/common/json_serializer.dart';
import '../common/database_naming.dart';
import '../common/firestore_crud_repository.dart';

/// Repository which manages challenge task documents.
@LazySingleton(as: FirestoreCrudRepository)
class FirestoreChallengeTaskRepository
    extends FirestoreCrudRepository<ChallengeTask> {
  // ignore: public_member_api_docs
  FirestoreChallengeTaskRepository(FirebaseFirestore firebaseFirestore,
      JsonSerializer<ChallengeTask> serializer, String challengeId)
      : super(firebaseFirestore, serializer, challengeTasksCollectionPath);
}
