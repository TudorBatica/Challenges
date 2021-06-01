import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

/// Models a text message
@JsonSerializable()
class Message extends Equatable {
  final DateTime createdAt;
  final String sender;
  final String content;

  Message(
      {required this.createdAt, required this.sender, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props => [createdAt, sender, content];
}
