// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    name: json['name'] as String,
    profilePictureURL: json['profilePictureURL'] as String?,
    teams: (json['teams'] as List<dynamic>?)
        ?.map((e) => TeamBasicInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profilePictureURL': instance.profilePictureURL,
      'teams': instance.teams,
    };
