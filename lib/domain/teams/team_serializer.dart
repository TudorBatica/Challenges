import 'package:injectable/injectable.dart';

import '../common/json_serializer.dart';
import 'team.dart';

/// UserProfile to/from JSON
@Injectable(as: JsonSerializer)
class TeamSerializer extends JsonSerializer<Team> {
  @override
  Team fromJson(Map<String, dynamic> json) => Team.fromJson(json);

  @override
  Map<String, dynamic> toJson(Team instance) => instance.toJson();
}
