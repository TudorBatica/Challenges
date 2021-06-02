import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

/// Models a text message
@JsonSerializable()
class Message extends Equatable {
  /// Creation datetime
  final DateTime createdAt;

  /// Message author(user id)
  final String sender;

  /// Message content
  final String content;

  // ignore: public_member_api_docs
  Message(
      {required this.createdAt, required this.sender, required this.content});

  // ignore: public_member_api_docs
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props => [createdAt, sender, content];
}
