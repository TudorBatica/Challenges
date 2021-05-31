import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

/// Models a team
@JsonSerializable()
class Team extends Equatable {
  /// Team unique id
  final String id;

  /// Team name
  final String name;

  /// Team members
  final List<String> members;

  // ignore: public_member_api_docs
  Team({required this.id, required this.name, required this.members});

  // ignore: public_member_api_docs
  factory Team.fromJson(json) => _$TeamFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  @override
  List<Object?> get props => [id, name, members];
}
