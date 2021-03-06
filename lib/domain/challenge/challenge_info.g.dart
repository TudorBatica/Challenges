// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeInfo _$ChallengeInfoFromJson(Map<String, dynamic> json) {
  return ChallengeInfo(
    id: json['id'] as String,
    challengeHostName: json['challengeHostName'] as String,
    challengeHostId: json['challengeHostId'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    registration: DateTime.parse(json['registration'] as String),
    start: DateTime.parse(json['start'] as String),
    submission: DateTime.parse(json['submission'] as String),
    prize: json['prize'] as String,
    teamSizeMin: json['teamSizeMin'] as int,
    teamSizeMax: json['teamSizeMax'] as int,
    imageURL: json['imageURL'] as String,
    registeredTeams: (json['registeredTeams'] as List<dynamic>?)
        ?.map((e) => TeamBasicInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ChallengeInfoToJson(ChallengeInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengeHostName': instance.challengeHostName,
      'challengeHostId': instance.challengeHostId,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'registration': instance.registration.toIso8601String(),
      'start': instance.start.toIso8601String(),
      'submission': instance.submission.toIso8601String(),
      'prize': instance.prize,
      'teamSizeMin': instance.teamSizeMin,
      'teamSizeMax': instance.teamSizeMax,
      'imageURL': instance.imageURL,
      'registeredTeams': instance.registeredTeams,
    };
