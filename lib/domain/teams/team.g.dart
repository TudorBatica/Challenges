// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    id: json['id'] as String,
    name: json['name'] as String,
    members: (json['members'] as List<dynamic>)
        .map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
