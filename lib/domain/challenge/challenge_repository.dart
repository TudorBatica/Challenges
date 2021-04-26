import 'package:challengesapp/domain/challenge/challenge_info.dart';

import 'challenge.dart';

/// Repository which manages challenge models
abstract class ChallengeRepository {
  /// Store a new challenge
  Future<void> createNewChallenge();

  /// Retrieves a specific challenge.
  /// The [Challenge] model object holds all the available data of a challenge,
  /// including the actual task.
  /// To prevent leaking the challenge task prematurely,
  /// you should use the [getChallengeInfo] method.
  Future<Challenge> getChallenge(String id);

  /// Retrieves the challenge information of a specific challenge.
  Future<ChallengeInfo> getChallengeInfo(String id);
}
