// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    createdAt: DateTime.parse(json['createdAt'] as String),
    sender: json['sender'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'sender': instance.sender,
      'content': instance.content,
    };
