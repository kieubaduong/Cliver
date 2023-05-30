// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      userId: json['userId'] as String?,
      status: json['status'] as String?,
      subcategoryId: json['subcategoryId'] as int?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      video: json['video'] as String?,
      document: json['document'] as String?,
      isSaved: json['isSaved'] as bool?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      hasOfferPackages: json['hasOfferPackages'] as bool?,
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      ratingAvg: (json['ratingAvg'] as num?)?.toDouble(),
      ratingCount: json['ratingCount'] as int?,
      minPrice: json['minPrice'] as int?,
      isPublish: json['isPublish'] as bool?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'userId': instance.userId,
      'status': instance.status,
      'user': instance.user?.toJson(),
      'subcategoryId': instance.subcategoryId,
      'category': instance.category?.toJson(),
      'tags': instance.tags,
      'images': instance.images,
      'video': instance.video,
      'document': instance.document,
      'isSaved': instance.isSaved,
      'hasOfferPackages': instance.hasOfferPackages,
      'packages': instance.packages?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'minPrice': instance.minPrice,
      'message': instance.message,
      'isPublish': instance.isPublish,
    };
