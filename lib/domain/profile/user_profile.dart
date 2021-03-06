import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../teams/team.dart';
import '../teams/team_basic_info.dart';

part 'user_profile.g.dart';

/// {@template UserProfile}
/// Represents a user profile, but not their identity
/// (for identity see `UserIdentity`).
///
/// Models data which is related to the user's activity in the app.
/// {@endtemplate}
@JsonSerializable()
class UserProfile extends Equatable {
  /// Display name (not their unique id).
  final String name;

  /// Profile image source
  final String? profilePictureURL;

  /// Teams which the user is part of
  final List<TeamBasicInfo>? teams;

  /// Teams into which the user has been invited.
  final List<Team>? invitations;

  // ignore: public_member_api_docs
  UserProfile(
      {required this.name,
      this.profilePictureURL,
      this.teams,
      this.invitations});

  /// Build profile from json
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Get JSON representation
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [name, profilePictureURL, teams];
}
