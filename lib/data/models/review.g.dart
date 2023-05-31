// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int?,
      orderId: json['orderId'] as int?,
      comment: json['comment'] as String?,
      userId: json['userId'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      rating: json['rating'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    )..type = $enumDecodeNullable(_$ReviewTypeEnumMap, json['type']);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'comment': instance.comment,
      'userId': instance.userId,
      'user': instance.user?.toJson(),
      'type': _$ReviewTypeEnumMap[instance.type],
      'rating': instance.rating,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ReviewTypeEnumMap = {
  ReviewType.FromBuyer: 'FromBuyer',
  ReviewType.FromSeller: 'FromSeller',
};
