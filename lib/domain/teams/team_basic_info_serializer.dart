import 'package:injectable/injectable.dart';

import '../common/json_serializer.dart';
import 'team_basic_info.dart';

/// UserProfile to/from JSON
@Injectable(as: JsonSerializer)
class TeamBasicInfoSerializer extends JsonSerializer<TeamBasicInfo> {
  @override
  TeamBasicInfo fromJson(Map<String, dynamic> json) =>
      TeamBasicInfo.fromJson(json);

  @override
  Map<String, dynamic> toJson(TeamBasicInfo instance) => instance.toJson();
}
