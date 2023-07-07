// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      content: json['content'] as String?,
      senderId: json['senderId'] as String?,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      roomId: json['roomId'] as int?,
      postId: json['postId'] as int?,
      relatedPost: json['relatedPost'] == null
          ? null
          : Post.fromJson(json['relatedPost'] as Map<String, dynamic>),
      repliedToMessageId: json['repliedToMessageId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      customPackageId: json['customPackageId'] as int?,
      customPackage: json['customPackage'] == null
          ? null
          : CustomOrder.fromJson(json['customPackage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'senderId': instance.senderId,
      'sender': instance.sender?.toJson(),
      'roomId': instance.roomId,
      'postId': instance.postId,
      'relatedPost': instance.relatedPost?.toJson(),
      'repliedToMessageId': instance.repliedToMessageId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'customPackageId': instance.customPackageId,
      'customPackage': instance.customPackage?.toJson(),
    };
