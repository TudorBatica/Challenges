import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team_basic_info.g.dart';

/// Holds a team's name and unique id
@JsonSerializable()
class TeamBasicInfo extends Equatable {
  /// Team unique id
  final String id;

  /// Team name
  final String name;

  // ignore: public_member_api_docs
  TeamBasicInfo({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$TeamBasicInfoToJson(this);

  // ignore: public_member_api_docs
  factory TeamBasicInfo.fromJson(Map<String, dynamic> source) =>
      _$TeamBasicInfoFromJson(source);
}
