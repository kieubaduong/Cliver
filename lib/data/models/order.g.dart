// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as int?,
      price: json['price'] as int?,
      note: json['note'] as String?,
      dueBy: json['dueBy'] as String?,
      buyerId: json['buyerId'] as String?,
      buyer: json['buyer'] == null
          ? null
          : User.fromJson(json['buyer'] as Map<String, dynamic>),
      sellerId: json['sellerId'] as String?,
      seller: json['seller'] == null
          ? null
          : User.fromJson(json['seller'] as Map<String, dynamic>),
      revisionTimes: json['revisionTimes'] as int?,
      leftRevisionTimes: json['leftRevisionTimes'] as int?,
      packageId: json['packageId'] as int?,
      paymentMethod: json['paymentMethod'] as String?,
      package: json['package'] == null
          ? null
          : Package.fromJson(json['package'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      histories: (json['histories'] as List<dynamic>?)
          ?.map((e) => OrderHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'id': instance.id,
      'price': instance.price,
      'note': instance.note,
      'dueBy': instance.dueBy,
      'buyerId': instance.buyerId,
      'buyer': instance.buyer?.toJson(),
      'sellerId': instance.sellerId,
      'seller': instance.seller?.toJson(),
      'revisionTimes': instance.revisionTimes,
      'leftRevisionTimes': instance.leftRevisionTimes,
      'packageId': instance.packageId,
      'paymentMethod': instance.paymentMethod,
      'package': instance.package?.toJson(),
      'status': _$StatusEnumMap[instance.status],
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
      'histories': instance.histories?.map((e) => e.toJson()).toList(),
    };

const _$StatusEnumMap = {
  Status.PendingPayment: 'PendingPayment',
  Status.Created: 'Created',
  Status.Doing: 'Doing',
  Status.Delivered: 'Delivered',
  Status.Completed: 'Completed',
  Status.Cancelled: 'Cancelled',
};
