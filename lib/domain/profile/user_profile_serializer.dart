import 'package:injectable/injectable.dart';

import '../common/json_serializer.dart';
import 'user_profile.dart';

/// UserProfile to/from JSON
@Injectable(as: JsonSerializer)
class UserProfileSerializer extends JsonSerializer<UserProfile> {
  @override
  UserProfile fromJson(Map<String, dynamic> json) => UserProfile.fromJson(json);

  @override
  Map<String, dynamic> toJson(UserProfile instance) => instance.toJson();
}
