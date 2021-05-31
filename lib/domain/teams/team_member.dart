import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_member.g.dart';

/// Models a team member
@JsonSerializable()
class TeamMember extends Equatable {
  /// User unique id
  final String id;

  /// User's name
  final String name;

  // ignore: public_member_api_docs
  TeamMember({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$TeamMemberToJson(this);

  // ignore: public_member_api_docs
  factory TeamMember.fromJson(Map<String, dynamic> source) =>
      _$TeamMemberFromJson(source);
}
