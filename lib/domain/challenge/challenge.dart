import 'package:equatable/equatable.dart';

import 'challenge_info.dart';
import 'challenge_task.dart';

/// Models all the data available for a challenge.
class Challenge extends Equatable {
  /// {@macro ChallengeInfo}
  final ChallengeInfo information;

  /// {@macro ChallengeTask}
  final ChallengeTask task;

  // ignore: public_member_api_docs
  Challenge({required this.information, required this.task});

  @override
  List<Object?> get props => [information, task];
}
