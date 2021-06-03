import 'challenge.dart';
import 'challenge_info.dart';
import 'challenge_task.dart';

/// Repository which manages challenge models.
abstract class ChallengeRepository {
  /// Store a new challenge
  Future<void> createNewChallenge(Challenge challenge);

  /// Retrieves a specific challenge.
  /// The [Challenge] model object holds all the available data of a challenge,
  /// including the actual task.
  /// To prevent leaking the challenge task,
  /// you can use the [getChallengeInfo] method.
  Future<Challenge> getChallenge(String id);

  /// Retrieves the challenge information of a specific challenge.
  Future<ChallengeInfo> getChallengeInfo(String id);

  /// Retrieves a challenge's task
  Future<ChallengeTask> getChallengeTask(String id);

  /// Retrieve all challenge infos(no tasks).
  Future<List<ChallengeInfo>> getAllChallengeInfos();

  /// Update a challenge info
  Future<void> updateChallengeInfo(
      String id, Map<String, dynamic> fieldsToUpdate);
}
