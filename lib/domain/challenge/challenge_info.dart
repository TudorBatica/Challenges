import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'challenge_info.g.dart';

/// {@template ChallengeInfo}
/// Models the base details of a challenge
/// {@endtemplate}
@JsonSerializable()
class ChallengeInfo extends Equatable {
  /// Challenge host
  final String challengeHostName;

  /// Challenge host id
  final String challengeHostId;

  /// Challenge name
  final String title;

  /// Describes what the challenge will be about. NOT the actual task
  final String description;

  ///TODO: replace with actual Category obj
  final String category;

  /// Registration deadline
  final DateTime registration;

  /// Starting datetime
  final DateTime start;

  /// Solution submission deadline
  final DateTime submission;

  /// Describes the prize(s)
  final String prize;

  /// Minimum number of people in a team
  final int teamSizeMin;

  /// Maximum number of people in a team
  final int teamSizeMax;

  // ignore: public_member_api_docs
  ChallengeInfo(
      {required this.challengeHostName,
      required this.challengeHostId,
      required this.title,
      required this.description,
      required this.category,
      required this.registration,
      required this.start,
      required this.submission,
      required this.prize,
      required this.teamSizeMin,
      required this.teamSizeMax});

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        registration,
        start,
        submission,
        prize,
        teamSizeMin,
        teamSizeMax
      ];

  // ignore: public_member_api_docs
  factory ChallengeInfo.fromJson(Map<String, dynamic> json) =>
      _$ChallengeInfoFromJson(json);

  /// Get the JSON representation
  Map<String, dynamic> get toJson => _$ChallengeInfoToJson(this);
}
