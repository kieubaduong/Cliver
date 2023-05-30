// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      postId: json['postId'] as int?,
      post: json['post'] == null
          ? null
          : SimplePost.fromJson(json['post'] as Map<String, dynamic>),
      deliveryDays: json['deliveryDays'] as int?,
      numberOfRevisions: json['numberOfRevisions'] as int?,
      price: json['price'] as int?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'postId': instance.postId,
      'post': instance.post,
      'deliveryDays': instance.deliveryDays,
      'numberOfRevisions': instance.numberOfRevisions,
      'price': instance.price,
      'type': instance.type,
    };
