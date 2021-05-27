import 'package:injectable/injectable.dart';

import '../../domain/challenge/challenge.dart';
import '../../domain/challenge/challenge_info.dart';
import '../../domain/challenge/challenge_repository.dart';
import '../../domain/challenge/challenge_task.dart';
import '../common/firestore_crud_repository.dart';

/// [ChallengeRepository] implementation which stores the data in Firestore.
@LazySingleton(as: ChallengeRepository)
class FirestoreChallengeRepository implements ChallengeRepository {
  final FirestoreCrudRepository<ChallengeInfo> _challengeInfoRepository;
  final FirestoreCrudRepository<ChallengeTask> _challengeTaskRepository;

  // ignore: public_member_api_docs
  FirestoreChallengeRepository(
      this._challengeInfoRepository, this._challengeTaskRepository);

  @override
  Future<void> createNewChallenge(Challenge challenge) async {
    final challengeId =
        await _challengeInfoRepository.create(challenge.information, null);
    await _challengeTaskRepository.create(challenge.task, challengeId);
  }

  @override
  Future<Challenge> getChallenge(String id) {
    // TODO: implement getChallenge
    throw UnimplementedError();
  }

  @override
  Future<ChallengeInfo> getChallengeInfo(String id) async {
    return await _challengeInfoRepository.read(id);
  }

  @override
  Future<List<ChallengeInfo>> getAllChallengeInfos() {
    return _challengeInfoRepository.readEntireCollection();
  }
}
