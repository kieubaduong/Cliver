// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimplePost _$SimplePostFromJson(Map<String, dynamic> json) => SimplePost(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
      description: json['description'] as String?,
      userId: json['userId'] as String?,
      status: json['status'] as String?,
      subcategoryId: json['subcategoryId'] as int?,
      ratingAvg: (json['ratingAvg'] as num?)?.toDouble(),
      ratingCount: json['ratingCount'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SimplePostToJson(SimplePost instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'userId': instance.userId,
      'status': instance.status,
      'subcategoryId': instance.subcategoryId,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'tags': instance.tags,
      'images': instance.images,
    };
