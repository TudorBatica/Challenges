import '../common/json_serializer.dart';

import 'challenge_task.dart';

/// [ChallengeTask] to/from JSON
class ChallengeTaskSerializer implements JsonSerializer<ChallengeTask> {
  @override
  ChallengeTask fromJson(Map<String, dynamic> json) =>
      ChallengeTask.fromJson(json);

  @override
  Map<String, dynamic> toJson(ChallengeTask instance) => instance.toJson;
}
