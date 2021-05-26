import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge_task.g.dart';

/// {@template ChallengeTask}
/// Models a challenge's actual task.
/// {@endtemplate}
@JsonSerializable()
class ChallengeTask extends Equatable {
  /// task description
  final String description;

  // ignore: public_member_api_docs
  ChallengeTask({required this.description});

  @override
  List<Object?> get props => [description];

  // ignore: public_member_api_docs
  factory ChallengeTask.fromJson(Map<String, dynamic> json) =>
      _$ChallengeTaskFromJson(json);

  /// Get the JSON representation
  Map<String, dynamic> get toJson => _$ChallengeTaskToJson(this);
}
