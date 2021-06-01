import 'package:injectable/injectable.dart';

import '../challenge/challenge_task.dart';
import '../common/json_serializer.dart';
import 'message.dart';

/// [ChallengeTask] to/from JSON
@Injectable(as: JsonSerializer)
class MessageSerializer implements JsonSerializer<Message> {
  @override
  Message fromJson(Map<String, dynamic> json) => Message.fromJson(json);

  @override
  Map<String, dynamic> toJson(Message instance) => instance.toJson();
}
