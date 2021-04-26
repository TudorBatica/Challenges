import '../common/json_serializer.dart';
import 'challenge_info.dart';

/// [ChallengeInfo] to/from JSON
class ChallengeInfoSerializer implements JsonSerializer<ChallengeInfo> {
  @override
  ChallengeInfo fromJson(Map<String, dynamic> json) =>
      ChallengeInfo.fromJson(json);

  @override
  Map<String, dynamic> toJson(ChallengeInfo instance) => instance.toJson;
}
