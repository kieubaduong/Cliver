// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomOrder _$CustomOrderFromJson(Map<String, dynamic> json) => CustomOrder(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      postId: json['postId'] as int?,
      post: json['post'] == null
          ? null
          : SimplePost.fromJson(json['post'] as Map<String, dynamic>),
      buyerId: json['buyerId'] as String?,
      deliveryDays: json['deliveryDays'] as int?,
      numberOfRevisions: json['numberOfRevisions'] as int?,
      price: json['price'] as int?,
      expirationDays: json['expirationDays'] as int?,
      roomId: json['roomId'] as int?,
    )..status = $enumDecodeNullable(_$CustomOrderStatusEnumMap, json['status']);

Map<String, dynamic> _$CustomOrderToJson(CustomOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'postId': instance.postId,
      'post': instance.post?.toJson(),
      'buyerId': instance.buyerId,
      'deliveryDays': instance.deliveryDays,
      'numberOfRevisions': instance.numberOfRevisions,
      'price': instance.price,
      'expirationDays': instance.expirationDays,
      'roomId': instance.roomId,
      'status': _$CustomOrderStatusEnumMap[instance.status],
    };

const _$CustomOrderStatusEnumMap = {
  CustomOrderStatus.Available: 'Available',
  CustomOrderStatus.Closed: 'Closed',
  CustomOrderStatus.Declined: 'Declined',
  CustomOrderStatus.Ordered: 'Ordered',
};
